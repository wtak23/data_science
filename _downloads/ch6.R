#' ---
#' title: "Ch6 - Trivariate Displays"
#' author:
#' date: 
#' output:
#'    html_document:
#'      keep_md: true
#'      toc: true
#'      toc_depth: 2
#' ---

library(lattice)


#' Topics covered:
#'
#' -  Three dimensional scatter plots
#' -  Surfaces and two-way tables
#' -  Level plots and contour plots
#' -  Wireframe rendering
#' -  Parameterized surfaces

quakes$Magnitude <- equal.count(quakes$mag, 4)

#' ## Figure 6.1
cloud(depth ~ lat * long | Magnitude, data = quakes, 
      zlim = rev(range(quakes$depth)),
      screen = list(z = 105, x = -70), panel.aspect = 0.75,
      xlab = "Longitude", ylab = "Latitude", zlab = "Depth")

#' ## Figure 6.2
cloud(depth ~ lat * long | Magnitude, data = quakes, 
      zlim = rev(range(quakes$depth)), panel.aspect = 0.75,
      screen = list(z = 80, x = -70), zoom = 0.7,
      scales = list(z = list(arrows = FALSE, distance = 2)), 
      xlab = "Longitude", ylab = "Latitude", 
      zlab = list("Depth\n(km)", rot = 90))

p <-
  cloud(depth ~ long + lat, quakes, zlim = c(690, 30),
        pch = ".", cex = 1.5, zoom = 1,
        xlab = NULL, ylab = NULL, zlab = NULL,
        par.settings = list(axis.line = list(col = "transparent")),
        scales = list(draw = FALSE))
npanel <- 4
rotz <- seq(-30, 30, length = npanel)
roty <- c(3, 0)

#' ## Figure 6.3
update(p[rep(1, 2 * npanel)], 
       layout = c(2, npanel),
       panel = function(..., screen) {
         crow <- current.row()
         ccol <- current.column()
         panel.cloud(..., screen = list(z = rotz[crow], 
                                        x = -60,
                                        y = roty[ccol]))
       })

state.info <-
  data.frame(name = state.name,
             long = state.center$x,
             lat = state.center$y,
             area = state.x77[, "Area"],
             population = 1000 * state.x77[, "Population"])
state.info$density <- with(state.info, population / area)

#' ## Figure 6.4
cloud(density ~ long + lat, state.info,
      subset = !(name %in% c("Alaska", "Hawaii")),
      type = "h", lwd = 2, zlim = c(0, max(state.info$density)),
      scales = list(arrows = FALSE))

library("maps")
state.map <- map("state", plot=FALSE, fill = FALSE)
panel.3dmap <- function(..., rot.mat, distance, xlim, ylim, zlim,
                        xlim.scaled, ylim.scaled, zlim.scaled)
{
  scaled.val <- function(x, original, scaled) {
    scaled[1] + (x - original[1]) * diff(scaled) / diff(original)
  }
  m <- ltransform3dto3d(rbind(scaled.val(state.map$x, xlim, xlim.scaled),
                              scaled.val(state.map$y, ylim, ylim.scaled),
                              zlim.scaled[1]), 
                        rot.mat, distance)
  panel.lines(m[1,], m[2,], col = "grey76")
}

#' ## Figure 6.5
cloud(density ~ long + lat, state.info,
      subset = !(name %in% c("Alaska", "Hawaii")),
      panel.3d.cloud = function(...) {
        panel.3dmap(...)
        panel.3dscatter(...)
      }, 
      type = "h", scales = list(draw = FALSE), zoom = 1.1,
      xlim = state.map$range[1:2], ylim = state.map$range[3:4],
      xlab = NULL, ylab = NULL, zlab = NULL,
      aspect = c(diff(state.map$range[3:4]) / diff(state.map$range[1:2]), 0.3),
      panel.aspect = 0.75, lwd = 2, screen = list(z = 30, x = -60),
      par.settings = list(axis.line = list(col = "transparent"),
                          box.3d = list(col = "transparent", alpha = 0)))

data(Cars93, package = "MASS")
cor.Cars93 <- 
  cor(Cars93[, !sapply(Cars93, is.factor)], use = "pair")
data(Chem97, package = "mlmRev")
Chem97$gcd <-
  with(Chem97, 
       cut(gcsescore,
           breaks = quantile(gcsescore, ppoints(11, a = 1))))
ChemTab <- xtabs(~ score + gcd + gender, Chem97)
ChemTabDf <- as.data.frame.table(ChemTab)
env <- environmental
env$ozone <- env$ozone^(1/3)
env$Radiation <- equal.count(env$radiation, 4)

#' ## Figure 6.6
cloud(ozone ~ wind + temperature | Radiation, env)

#' ## Figure 6.7
splom(env[1:4])

fm1.env <- lm(ozone ~ radiation * temperature * wind, env)
fm2.env <- 
  loess(ozone ~ wind * temperature * radiation, env,
        span = 0.75, degree = 1)
fm3.env <- 
  loess(ozone ~ wind * temperature * radiation, env,
        parametric = c("radiation", "wind"), 
        span = 0.75, degree = 2)
library("locfit")
fm4.env <- locfit(ozone ~ wind * temperature * radiation, env)
w.mesh <- with(env, do.breaks(range(wind), 50))
t.mesh <- with(env, do.breaks(range(temperature), 50))
r.mesh <- with(env, do.breaks(range(radiation), 3))
grid <- 
  expand.grid(wind = w.mesh, 
              temperature = t.mesh,
              radiation = r.mesh)
grid[["fit.linear"]] <- predict(fm1.env, newdata = grid)
grid[["fit.loess.1"]] <- as.vector(predict(fm2.env, newdata = grid))
grid[["fit.loess.2"]] <- as.vector(predict(fm3.env, newdata = grid))
grid[["fit.locfit"]] <- predict(fm4.env, newdata = grid)

#' ## Figure 6.8
wireframe(fit.linear + fit.loess.1 + fit.loess.2 + fit.locfit ~ 
            wind * temperature | radiation, 
          grid, outer = TRUE, shade = TRUE, zlab = "")

#' ## Figure 6.9
levelplot(fit.linear + fit.loess.1 + fit.loess.2 + fit.locfit ~ 
            wind * temperature | radiation, 
          data = grid)

#' ## Figure 6.10
contourplot(fit.locfit ~ wind * temperature | radiation, 
            data = grid, aspect = 0.7, layout = c(1, 4),
            cuts = 15, label.style = "align")

#' ## Figure 6.11
levelplot(volcano)
contourplot(volcano, cuts = 20, label = FALSE)
wireframe(volcano, panel.aspect = 0.7, zoom = 1, lwd = 0.01)

data(Chem97, package = "mlmRev")
Chem97$gcd <-
  with(Chem97, 
       cut(gcsescore,
           breaks = quantile(gcsescore, ppoints(11, a = 1))))
ChemTab <- xtabs(~ score + gcd + gender, Chem97)
ChemTabDf <- as.data.frame.table(ChemTab)
data(Cars93, package = "MASS")
cor.Cars93 <- cor(Cars93[, !sapply(Cars93, is.factor)], use = "pair")

#' ## Figure 6.12
levelplot(cor.Cars93, 
          scales = list(x = list(rot = 90)))

ord <- order.dendrogram(as.dendrogram(hclust(dist(cor.Cars93))))

#' ## Figure 6.13
levelplot(cor.Cars93[ord, ord], at = do.breaks(c(-1.01, 1.01), 20),
          scales = list(x = list(rot = 90)))

tick.at <- pretty(range(sqrt(ChemTabDf$Freq)))

#' ## Figure 6.14
levelplot(sqrt(Freq) ~ score * gcd | gender, ChemTabDf, 
          shrink = c(0.7, 1),
          colorkey = 
            list(labels = list(at = tick.at, labels = tick.at^2)),
          aspect = "iso")

library("latticeExtra")

#' ## Figure 6.15
cloud(Freq ~ score * gcd | gender, data = ChemTabDf,
      screen = list(z = -40, x = -25), zoom = 1.1,
      col.facet = "grey", xbase = 0.6, ybase = 0.6,
      par.settings = list(box.3d = list(col = "transparent")),
      aspect = c(1.5, 0.75), panel.aspect = 0.75,
      panel.3d.cloud = panel.3dbars)

library("copula")
grid <-
  expand.grid(u = do.breaks(c(0.01, 0.99), 25),
              v = do.breaks(c(0.01, 0.99), 25))
# grid$frank  <- with(grid, dcopula(frankCopula(2),    cbind(u, v)))
# grid$gumbel <- with(grid, dcopula(gumbelCopula(1.2), cbind(u, v)))
# grid$normal <- with(grid, dcopula(normalCopula(.4),  cbind(u, v)))
# grid$t      <- with(grid, dcopula(tCopula(0.4),      cbind(u, v)))

#' ## Figure 6.16
# wireframe(frank + gumbel + normal + t ~ u * v, grid, outer = TRUE, 
#           zlab = "", screen = list(z = -30, x = -50), lwd = 0.01)

#' ## Figure 6.17
# wireframe(frank + gumbel + normal + t ~ u * v, grid, outer = TRUE, 
#           zlab = "", screen = list(z = -30, x = -50), 
#           scales = list(z = list(log = TRUE)), lwd = 0.01)

kx <- function(u, v)
  cos(u) * (r + cos(u/2) * sin(t*v) - sin(u/2) * sin(2*t*v))
ky <- function(u, v) 
  sin(u) * (r + cos(u/2) * sin(t*v) - sin(u/2) * sin(2*t*v))
kz <- function(u, v) 
  sin(u/2) * sin(t*v) + cos(u/2) * sin(t*v)
n <- 50
u <- seq(0.3, 1.25, length = n) * 2 * pi
v <- seq(0, 1, length = n) * 2 * pi
um <- matrix(u, length(u), length(u))
vm <- matrix(v, length(v), length(v), byrow = TRUE)
r <- 2
t <- 1

#' ## Figure 6.18
wireframe(kz(um, vm) ~ kx(um, vm) + ky(um, vm), shade = TRUE,
          screen = list(z = 170, x = -60),
          alpha = 0.75, panel.aspect = 0.6, aspect = c(1, 0.4))

data(USAge.df, package = "latticeExtra")
str(USAge.df)
library("RColorBrewer")
brewer.div <-
  colorRampPalette(brewer.pal(11, "Spectral"),
                   interpolate = "spline")

#' ## Figure 6.19
levelplot(Population ~ Year * Age | Sex, data = USAge.df,
          cuts = 199, col.regions = brewer.div(200),
          aspect = "iso")

