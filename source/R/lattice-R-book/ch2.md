# Ch2 - A Technical Overview
Gives a "big picture" view of the system. 

**Topics covered**

- The formula interface
- object dimensions and physical layout
- Annotation
- Scales and Axes
- Panel functions







```r
library(lattice)

data(Oats, package = "MEMSS")
```

# Dimension and Physical Layout
## Figure 2.1 (A Trelis display of the **Data** Object)


```r
tp1.oats <- 
  xyplot(yield ~ nitro | Variety + Block, data = Oats, type = 'o')
print(tp1.oats)
```

![](ch2_files/figure-html/unnamed-chunk-3-1.png)<!-- -->

```r
dim(tp1.oats)
```

```
## [1] 3 6
```

```r
dimnames(tp1.oats)
```

```
## $Variety
## [1] "Golden Rain" "Marvellous"  "Victory"    
## 
## $Block
## [1] "I"   "II"  "III" "IV"  "V"   "VI"
```

```r
xtabs(~Variety + Block, data = Oats)
```

```
##              Block
## Variety       I II III IV V VI
##   Golden Rain 4  4   4  4 4  4
##   Marvellous  4  4   4  4 4  4
##   Victory     4  4   4  4 4  4
```

```r
summary(tp1.oats)
```

```
## 
## Call:
## xyplot(yield ~ nitro | Variety + Block, data = Oats, type = "o")
## 
## Number of observations:
##              Block
## Variety       I II III IV V VI
##   Golden Rain 4  4   4  4 4  4
##   Marvellous  4  4   4  4 4  4
##   Victory     4  4   4  4 4  4
```

```r
summary(tp1.oats[, 1])
```

```
## 
## Call:
## xyplot(yield ~ nitro | Variety + Block, data = Oats, type = "o", 
##     index.cond = new.levs)
## 
## Number of observations:
##              Block
## Variety       I
##   Golden Rain 4
##   Marvellous  4
##   Victory     4
```

## Figure 2.2 (subset display of the Trellis object)


```r
print(tp1.oats[, 1])
```

![](ch2_files/figure-html/unnamed-chunk-4-1.png)<!-- -->

## Figure 2.3 (aspect ratio control)


```r
update(tp1.oats, 
       aspect="xy")
```

![](ch2_files/figure-html/unnamed-chunk-5-1.png)<!-- -->

## Figure 2.4 


```r
update(tp1.oats, aspect = "xy",
       layout = c(0, 18))
```

![](ch2_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

## Figure 2.5 (fig 2.5 with spacing between column blocks)


```r
update(tp1.oats, aspect = "xy", layout = c(0, 18), 
       between = list(x = c(0, 0, 0.5), y = 0.5))
```

![](ch2_files/figure-html/unnamed-chunk-7-1.png)<!-- -->

# Grouped displays
## Figure 2.6 


```r
dotplot(variety ~ yield | site, barley, 
        layout = c(1, 6), aspect = c(0.7),
        groups = year, auto.key = list(space = 'right'))
```

![](ch2_files/figure-html/unnamed-chunk-8-1.png)<!-- -->

# Annotation: Captions, labels, and legends
## Figure 2.7


```r
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
```

![](ch2_files/figure-html/unnamed-chunk-9-1.png)<!-- -->

# Scale and Axes
## Figure 2.8


```r
barchart(Class ~ Freq | Sex + Age, data = as.data.frame(Titanic), 
         groups = Survived, stack = TRUE, layout = c(4, 1),
         auto.key = list(title = "Survived", columns = 2))
```

![](ch2_files/figure-html/unnamed-chunk-10-1.png)<!-- -->

## Figure 2.9


```r
barchart(Class ~ Freq | Sex + Age, data = as.data.frame(Titanic), 
         groups = Survived, stack = TRUE, layout = c(4, 1), 
         auto.key = list(title = "Survived", columns = 2),
         scales = list(x = "free"))
```

![](ch2_files/figure-html/unnamed-chunk-11-1.png)<!-- -->

# The Panel function
## Figure 2.10


```r
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
```

![](ch2_files/figure-html/unnamed-chunk-12-1.png)<!-- -->

## Figure 2.11


```r
update(bc.titanic, 
       panel = function(..., border) {
         panel.barchart(..., border = "transparent")
       })
```

![](ch2_files/figure-html/unnamed-chunk-13-1.png)<!-- -->


---
title: "ch2.R"
author: "takanori"
date: "Thu Nov  3 20:00:50 2016"
---
