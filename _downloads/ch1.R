#' ---
#' title: "Ch1 - Introduction"
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

data(Chem97, package = "mlmRev")
xtabs( ~ score, data = Chem97)
library("lattice")

#' ## Figure 1.1 (conditional histogram)
histogram(~ gcsescore | factor(score), data = Chem97)

#' ## Figure 1.2 (conditional density plot)
densityplot(~ gcsescore | factor(score), data = Chem97, 
            plot.points = FALSE, ref = TRUE)

#' ## Figure 1.3 (grouped kde plot)
densityplot(~ gcsescore, data = Chem97, groups = score,
            plot.points = FALSE, ref = TRUE,
            auto.key = list(columns = 3))

#' ## Figure 1.4 (conditional histogram and kde grouped in a single figure)
tp1 <- histogram(~ gcsescore | factor(score), data = Chem97)
tp2 <- 
  densityplot(~ gcsescore, data = Chem97, groups = score,
              plot.points = FALSE,
              auto.key = list(space = "right", title = "score"))
class(tp2)
summary(tp1)
plot(tp1, split = c(1, 1, 1, 2))
plot(tp2, split = c(1, 2, 1, 2), newpage = FALSE)
