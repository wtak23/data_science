#' ---
#' title: "Ch2 - A Technical Overview"
#' author:
#' date: 
#' output:
#'    html_document:
#'      keep_md: true
#'      toc: true
#'      toc_depth: 2
#' ---

#' Gives a "big picture" view of the system. 
#' 
#' **Topics covered**
#' 
#' - The formula interface
#' - object dimensions and physical layout
#' - Annotation
#' - Scales and Axes
#' - Panel functions
#'
#+ results = 'asis'
#'

library(lattice)

data(Oats, package = "MEMSS")

#' # Dimension and Physical Layout
#' ## Figure 2.1 (A Trelis display of the **Data** Object)
tp1.oats <- 
  xyplot(yield ~ nitro | Variety + Block, data = Oats, type = 'o')
print(tp1.oats)

dim(tp1.oats)
dimnames(tp1.oats)
xtabs(~Variety + Block, data = Oats)
summary(tp1.oats)
summary(tp1.oats[, 1])

#' ## Figure 2.2 (subset display of the Trellis object)
print(tp1.oats[, 1])

#' ## Figure 2.3 (aspect ratio control)
update(tp1.oats, 
       aspect="xy")

#' ## Figure 2.4 
update(tp1.oats, aspect = "xy",
       layout = c(0, 18))

#' ## Figure 2.5 (fig 2.5 with spacing between column blocks)
update(tp1.oats, aspect = "xy", layout = c(0, 18), 
       between = list(x = c(0, 0, 0.5), y = 0.5))

#' # Grouped displays
#' ## Figure 2.6 
dotplot(variety ~ yield | site, barley, 
        layout = c(1, 6), aspect = c(0.7),
        groups = year, auto.key = list(space = 'right'))

#' # Annotation: Captions, labels, and legends
#' ## Figure 2.7
key.variety <- 
  list(space = "right", text = list(levels(Oats$Variety)),
       points = list(pch = 1:3, col = "black"))
xyplot(yield ~ nitro | Block, Oats, aspect = "xy", type = "o", 
       groups = Variety, key = key.variety, lty = 1, pch = 1:3, 
       col.line = "darkgrey", col.symbol = "black",
       xlab = "Nitrogen concentration (cwt/acre)",
       ylab = "Yield (bushels/acre)", 
       main = "Yield of three varieties of oats",
       sub = "A 3 x 4 split plot experiment with 6 blocks")

#' # Scale and Axes
#' ## Figure 2.8
barchart(Class ~ Freq | Sex + Age, data = as.data.frame(Titanic), 
         groups = Survived, stack = TRUE, layout = c(4, 1),
         auto.key = list(title = "Survived", columns = 2))

#' ## Figure 2.9
barchart(Class ~ Freq | Sex + Age, data = as.data.frame(Titanic), 
         groups = Survived, stack = TRUE, layout = c(4, 1), 
         auto.key = list(title = "Survived", columns = 2),
         scales = list(x = "free"))

#' # The Panel function
#' ## Figure 2.10
bc.titanic <- 
  barchart(Class ~ Freq | Sex + Age, as.data.frame(Titanic), 
           groups = Survived, stack = TRUE, layout = c(4, 1),
           auto.key = list(title = "Survived", columns = 2),
           scales = list(x = "free"))
update(bc.titanic, 
       panel = function(...) {
         panel.grid(h = 0, v = -1)
         panel.barchart(...)
       })

#' ## Figure 2.11
update(bc.titanic, 
       panel = function(..., border) {
         panel.barchart(..., border = "transparent")
       })
