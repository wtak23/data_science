#' ---
#' title: "Controlling Confounds (with xtable)"
#' author: Takanori Watanabe
#' date: Nov 1, 2016
#' output:
#'    html_document:
#'      keep_md: true
#'      toc: true
#'      toc_depth: 2
#' ---

#'
#'
#' Demo from http://stats.stackexchange.com/questions/3944/explain-model-adjustment-in-plain-english
#' 
#' Here I'll use `xtable` to format output from `summary`
#'

library(xtable)
set.seed(69)

#+ results = 'asis'

#' # set variables
# set variables -----------------------------------------------------------
# x = weight, y = height
weight <- rep(1:10,2)
height <- c(jitter(1:10, factor=4), (jitter(1:10, factor=4)+2))
sex <- rep(c("f", "m"), each=10)
df1 <- data.frame(weight,height,sex)

#' # regression
with(df1, plot(height~weight, col=c(1,2)[sex]))

#' ## lm1: without controlling for weight(weight)
#' (so according to this result, gender has no impact on height...which likely isn't true)
lm1 <- lm(height~sex, data=df1)

#+ results = 'asis'
print(xtable(anova(lm1)), type='html')
anova(lm1)

print(xtable(summary(lm1)), type='html')
summary(lm1)

#' ## lm2: here we control for weight 
#' (now gender should have an effect on height as expected)
lm2 <- lm(height~sex+weight, data=df1)

print(xtable(anova(lm2)), type='html')

#' ```{r, results = 'asis'}
#' print(xtable(anova(lm2)), type='html')
#' ```   
anova(lm2)

print(xtable(summary(lm2)), type='html')
summary(lm2)

#' ## In case you want to add the fitted lines to the plot
coefs2 <- coef(lm2)
# abline(coefs2[1], coefs2[3], col=1)
# abline(coefs2[1]+coefs2[2], coefs2[3], col=2)

# below dash controls table header level
# ---- 
# Try test --------------------------------------------------------------------


plot(weight,c(height[1:10],height[11:20] - coefs2[2]))
yy = c(height[1:10],height[-(1:10)] - coefs2[2])
plot(weight,yy,col='red')


plot(weight[1:10],height[1:10],ylim=range(c(0,12)))
par(new=TRUE)
plot(weight[-(1:10)],height[-(1:10)] - coefs2[2],col='red',axes=FALSE,xlab="",ylab="",ylim=range(c(0,12)))

plot(weight[1:10],height[1:10])
par(new=TRUE)
plot(weight[-(1:10)],height[-(1:10)],col='red',axes=FALSE,xlab="",ylab="")
