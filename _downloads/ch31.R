#' ---
#' title: "Ch3 - Displaying Univariate Distributions"
#' author:
#' date: 
#' output:
#'    html_document:
#'      keep_md: true
#'      toc: true
#'      toc_depth: 2
#' ---

#'
#'
#' From http://lmdvr.r-forge.r-project.org/figures/figures.html
#+ results = 'asis'
#'


library(lattice)
library("latticeExtra")
library(xtable)

#' # Datasets used in this Chapter

#' ## faithful
str(faithful)
#+ results = 'asis'
print(xtable(head(faithful,n=5)), type='html')

#' ## gvhd10
data(gvhd10)
str(gvhd10)
#+ results = 'asis'
print(xtable(head(gvhd10,n=5)), type='html')

#' ## Chem97
data(Chem97, package = "mlmRev")
str(Chem97)
#+ results = 'asis'
print(xtable(head(Chem97,n=5)), type='html')

#' ## quakes
str(quakes)
#+ results = 'asis'
print(xtable(head(quakes,n=5)), type='html')

#' ## barley
str(barley)
#+ results = 'asis'
print(xtable(head(barley,n=5)), type='html')

#' # Density plot

#' ## Figure 3.1
densityplot(~ eruptions, data = faithful)

#' ## Figure 3.2
densityplot(~ eruptions, data = faithful, 
            kernel = "rect", bw = 0.2, plot.points = "rug", n = 200)

#' ## Figure 3.3
densityplot(~log(FSC.H) | Days, data = gvhd10, 
            plot.points = FALSE, ref = TRUE, layout = c(2, 4))

#' # Histograms
#' ## Figure 3.4
histogram(~log2(FSC.H) | Days, gvhd10, xlab = "log Forward Scatter",
          type = "density", nint = 50, layout = c(2, 4))

#' # Normal QQ Plots

#' ## Figure 3.5
qqmath(~ gcsescore | factor(score), data = Chem97, 
       f.value = ppoints(100))

#' ## Figure 3.6
qqmath(~ gcsescore | gender, Chem97, groups = score, aspect = "xy", 
       f.value = ppoints(100), auto.key = list(space = "right"),
       xlab = "Standard Normal Quantiles", 
       ylab = "Average GCSE Score")

Chem97.mod <- transform(Chem97, gcsescore.trans = gcsescore^2.34)

#+ results = 'asis'
str(Chem97.mod)
print(xtable(head(Chem97.mod,n=5)), type='html')

#' ## Figure 3.7
qqmath(~ gcsescore.trans | gender, Chem97.mod, groups = score,
       f.value = ppoints(100), aspect = "xy",
       auto.key = list(space = "right", title = "score"), 
       xlab = "Standard Normal Quantiles", 
       ylab = "Transformed GCSE Score")

library("latticeExtra")

#' # The empirical CDF
#' ## Figure 3.8
ecdfplot(~ gcsescore | factor(score), data = Chem97, 
         groups = gender, auto.key = list(columns = 2),
         subset = gcsescore > 0, xlab = "Average GCSE Score")

#' # Two-sample QQ-plots
#' ## Figure 3.9
qqmath(~ gcsescore | factor(score), data = Chem97, groups = gender, 
       auto.key = list(points = FALSE, lines = TRUE, columns = 2),
       subset = gcsescore > 0, type = "l", distribution = qunif, 
       prepanel = prepanel.qqmathline, aspect = "xy",
       xlab = "Standard Normal Quantiles", 
       ylab = "Average GCSE Score")

#' ## Figure 3.10
qq(gender ~ gcsescore | factor(score), Chem97, 
   f.value = ppoints(100), aspect = 1)

#' # Box-and-whisker plots
#' ## Figure 3.11
bwplot(factor(score) ~ gcsescore | gender, data = Chem97, 
       xlab = "Average GCSE Score")

#' ## Figure 3.12
bwplot(gcsescore^2.34 ~ gender | factor(score), Chem97, 
       varwidth = TRUE, layout = c(6, 1),
       ylab = "Transformed GCSE score")

#' ## Figure 3.13

bwplot(Days ~ log(FSC.H), data = gvhd10, 
       xlab = "log(Forward Scatter)", ylab = "Days Past Transplant")

#' ## Figure 3.14
bwplot(Days ~ log(FSC.H), gvhd10, 
       panel = panel.violin, box.ratio = 3,
       xlab = "log(Forward Scatter)", 
       ylab = "Days Past Transplant")

#' # Strip plot

#' ## Figure 3.15
stripplot(factor(mag) ~ depth, quakes)

#' ## Figure 3.16
stripplot(depth ~ factor(mag), quakes, 
          jitter.data = TRUE, alpha = 0.6,
          xlab = "Magnitude (Richter)", ylab = "Depth (km)")

#' ## Figure 3.17
stripplot(sqrt(abs(residuals(lm(yield~variety+year+site)))) ~ site, 
          data = barley, groups = year, jitter.data = TRUE,
          auto.key = list(points = TRUE, lines = TRUE, columns = 2),
          type = c("p", "a"), fun = median,
          ylab = expression(abs("Residual Barley Yield")^{1 / 2}))
