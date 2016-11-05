#' ---
#' title: "Site-correction with ComBat - PCA analysis"
#' output:
#'    html_document:
#'      keep_md: true
#'      toc: true
#'      toc_depth: 2
#' ---
#'
#' **About this document**
#' See if the effect of *site-difference* manifests itself as *batch-effect*.
#' 
#' To this end, we'll study the distribution of the first few dominant 
#' principal components to find out.
#' 

options(show.error.locations = TRUE)
library(ggplot2)
source('tak.R')
getwd()

# get matlab data ----
#' # Load data
# load design matrix (readMat returns a list)
X <- R.matlab::readMat('tobpnc_drew.mat')$X
df <- read.csv('tobpnc_drew.csv')

# Scale normalize data ----
#' # Scale normalize data 
normalize <- function() {
  # get median matrices for each site
  Xpnc <- X[df$site=='pnc',] # pnc
  Xtob <- X[df$site=='tob',] # tob
  
  # get max-median edge
  Xpnc_maxmed <- max(apply(Xpnc,2,median))
  Xtob_maxmed <- max(apply(Xtob,2,median))
  
  # normalize
  Xpnc_n <- Xpnc/Xpnc_maxmed
  Xtob_n <- Xtob/Xtob_maxmed
  X_norm <- rbind(Xpnc_n,Xtob_n)
  return(X_norm)
}

Xnorm <- normalize()

# Study pca of scale normalized data ----
#' # Study pca of scale normalized data

pca <- prcomp(Xnorm,center=TRUE,scale. = FALSE)
# pca.pnc <- prcomp(Xnorm[df$site == 'pnc',],center=TRUE,scale. = FALSE)
# pca.tob <- prcomp(Xnorm[df$site == 'tob',],center=TRUE,scale. = FALSE)

# summary(..)$importance is a matrix object
# pcainfo.imp <- summary(pca.pnc)$importance
# plot(pcainfo.imp["Cumulative Proportion",],ylim=c(0,1))
# pcainfo.imp <- as.data.frame(t(pcainfo.imp))

# first 5 components
ncomp <- 5
pca5 <- as.data.frame(pca$x[,1:ncomp])
# pca5.pnc <- pca.pnc$x[,1:ncomp]
# pca5.tob <- pca.tob$x[,1:ncomp]
# pca5 <- as.data.frame(rbind(pca5.pnc,pca5.tob))

pca5['site'] <- df$site

# ** scattermatrix ----
#' ## scattermatrix plot
#' I was sad to see there wasn't a function in ggplot that achieves this
#' (am i missing something? google-search told me `ggpair` got deprecated...)
pairs(pca5[,1:ncomp],col=df$site)

# ** Scatter-matrix using `lattice::splom` ----
#' ## Scatter-matrix using `lattice::splom`
#' **Holy batman**! Look at the 2nd PC! Clearly a site difference
#http://takwatanabe.me/data_science/R/lattice-R-book/ch5.html
lattice::splom(pca5,group=pca5$site,alpha=0.2)

# heatmap ----
# http://stackoverflow.com/questions/30977249/ggplot-equivalent-for-matplot
# tmp1 <- dvecinv(X[1,])
# tmp1 <- as.data.frame(tmp1,row.names=as.character(1:nrow(tmp1)), col.names=as.character(1:ncol(tmp1)))
# tmp1$id <- 1:nrow(tmp1)
# ttt <- reshape2::melt(tmp1,id.var="id")
# ggplot(data = ttt, aes(x=row,y=variable,fill=value)) + geom_tile()

# Correct site-effect via running ComBat on normalized data ----
#' # Correct site-effect via running ComBat on normalized data
site <- df$site
age <- df$age

# combat without model (just the intercept)
mod0 <- model.matrix(~1,data=df)
X_combat0 <- t(sva::ComBat(dat=t(Xnorm), batch=site,mod=mod0))

# Repeat pca plot after site-correction ----
#' ## Repeat pca plot after site-correction
pca.combat <- prcomp(X_combat0,center=TRUE,scale. = FALSE)

# first 5 components
pca5.combat <- as.data.frame(pca.combat$x[,1:ncomp])
pca5.combat['site'] <- df$site
lattice::splom(pca5.combat,group=pca5.combat$site,alpha=0.2)


#' So looks like the site differences got removed quite nicely.
#' Next we'll see if **age-related biological variation** was preserved
#' (our variation of interest). We'll run machine-learning/regression-analysi
#' for this. Let's move over to Python and Scikit-Learn for this...)
#' 
#' # Save ComBat corrected data-matrix
#' Save as `.mat` file for analysis in python (in my experience, `.mat` has 
#' nice compression for purely numerical arrays like this)
R.matlab::writeMat('Xcombat_mod0.mat',X_combat=X_combat0)