#' ---
#' title: "Ch4 - Displaying Multiway Tables"
#' author:
#' date: 
#' output:
#'    html_document:
#'      keep_md: true
#'      toc: true
#'      toc_depth: 2
#' ---

#'
#' **Topics covered**:
#' 
#' - Cleveland dot plot
#' - Bar chart
#' - Reordering factor levels
#' 
#' 

library(lattice)

VADeaths
class(VADeaths)
methods("dotplot")

#' ## Figure 4.1
dotplot(VADeaths, groups = FALSE)

#' ## Figure 4.2
dotplot(VADeaths, groups = FALSE, 
        layout = c(1, 4), aspect = 0.7, 
        origin = 0, type = c("p", "h"),
        main = "Death Rates in Virginia - 1940", 
        xlab = "Rate (per 1000)")

#' ## Figure 4.3
dotplot(VADeaths, type = "o",
        auto.key = list(lines = TRUE, space = "right"),
        main = "Death Rates in Virginia - 1940",
        xlab = "Rate (per 1000)")

#' ## Figure 4.4
barchart(VADeaths, groups = FALSE,
         layout = c(1, 4), aspect = 0.7, reference = FALSE, 
         main = "Death Rates in Virginia - 1940",
         xlab = "Rate (per 100)")

data(postdoc, package = "latticeExtra")

#' ## Figure 4.5
barchart(prop.table(postdoc, margin = 1), xlab = "Proportion",
         auto.key = list(adj = 1))

#' ## Figure 4.6
dotplot(prop.table(postdoc, margin = 1), groups = FALSE, 
        xlab = "Proportion",
        par.strip.text = list(abbreviate = TRUE, minlength = 10))

#' ## Figure 4.7
dotplot(prop.table(postdoc, margin = 1), groups = FALSE, 
        index.cond = function(x, y) median(x),
        xlab = "Proportion", layout = c(1, 5), aspect = 0.6,
        scales = list(y = list(relation = "free", rot = 0)),
        prepanel = function(x, y) {
          list(ylim = levels(reorder(y, x)))
        },
        panel = function(x, y, ...) {
          panel.dotplot(x, reorder(y, x), ...)
        })

data(Chem97, package = "mlmRev")
gcsescore.tab <- xtabs(~gcsescore + gender, Chem97)
gcsescore.df <- as.data.frame(gcsescore.tab)
gcsescore.df$gcsescore <- 
  as.numeric(as.character(gcsescore.df$gcsescore))

#' ## Figure 4.8
xyplot(Freq ~ gcsescore | gender, data = gcsescore.df, 
       type = "h", layout = c(1, 2), xlab = "Average GCSE Score")

score.tab <- xtabs(~score + gender, Chem97)
score.df <- as.data.frame(score.tab)

#' ## Figure 4.9
barchart(Freq ~ score | gender, score.df, origin = 0)