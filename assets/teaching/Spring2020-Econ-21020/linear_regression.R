# Linear Regression in R =======================================================
# Author: Thomas Wiemann

# This R script provides an illustration of linear regression in R.

# Preliminaries ================================================================

# Install required packages
library(sandwich)
library(lmtest)

# No random seed required.

# Data =========================================================================

# Import data from csv file
link <- "https://thomaswiemann.github.io/assets/data/Econ21020/reg_data.csv"
df <- read.csv(url(link))

# Summary Statistics ===========================================================

# Print first 10 rows to get a first look at the variables. It looks like y, X1,
#     and X2 are continious but X3 is discrete. Also, get a sense of the
#     dimension of the data.

head(df, 10)

dim(df) # 1620 observations with 4 variables

# Calculate summary statistics for each variable. First, use the `summary`
#     command. Then, replicate the mean with the `apply` function. Also
#     calculate the 10th, and 90th quantile of each  vaiable, as well as their
#     standard deviation. Combine the summary statistics in a dataframe.

summary(df)

var_mean <- apply(X = df, MARGIN = 2, FUN = mean)
var_sd <- apply(X = df, MARGIN = 2, FUN = sd)
var_quantiles <- apply(X = df, MARGIN = 2,
                       FUN = function(x) {
                         quantile(x, c(0.1, 0.9))
                       })#APPLY

df_sumstats <- data.frame(rbind(var_mean, var_sd, var_quantiles))
df_sumstats

# The summary statistics calculated so far may not be particularly informative
#     about X3, the discrete variable. Here, a tabulation may give better
#     insights. It looks like the five distinct values of X3 are approximately
#     uniformly distributed in the sample.

table(df$X.3) # frequency of values within the data

table(df$X.3) / dim(df)[1] # relative frequencies

# Descriptive regression analysis ==============================================

# As a last part of the analysis here, we characterize the conditional
#     distribution distribution of y given X via linear regression. R's built-in
#     command for linear regression is `lm`, which we use here first. To obtain
#     the coefficient values and corresponding standard errors, we use the
#     `summary` method (also built-in).

fit_lm <- lm(y ~ 1 + X.1 + X.2 + X.3,
             data = df) # linear regression of y on X and a constant
summary(fit_lm) # get coefficient values and classical standard errors

# Note that the built-in procedure only gives standard errors under
#     homoskedasticity. These are seldomly of interest. To compute
#     heteroskedasticity robust standard errors, we use `coeftest` from the
#     lmtest package.
coeftest(fit_lm, vcov = vcovHC(fit_lm, type = "HC1"))

# Let us briefly check whether the regression output is sensible. For example,
#     let's plot the regression residuals against our three variables X1-X3. We
#     can use R's build in `plot` function for this.

plot(x = df$X.1, y = fit_lm$residuals,
     xlab = "X.1", ylab = expression(epsilon))
plot(x = df$X.2, y = fit_lm$residuals,
     xlab = "X.2", ylab = expression(epsilon))
plot(x = df$X.3, y = fit_lm$residuals,
     xlab = "X.3", ylab = expression(epsilon))

# The third plot, where we consider X3, suggests that we did not correctly
#     capture the relationship between y and X3 with the linear model considered
#     above. Note that we did not differentiate between the continious X1 and
#     X2, and the discrete X3. To allow for nonlinearities, it may be better to
#     use indicator variables for different levels of X3. To do so, first set
#     the variable type to factor. R will then include indicator variables when
#     calling `lm`.

df$X.3 <- as.factor(df$X.3)
fit_lm2 <- lm(y ~ 1 + X.1 + X.2 + X.3, data = df)
coeftest(fit_lm2, vcov = vcovHC(fit_lm2, type = "HC1"))

# Let us check whether the residuals look sensible now. Much better.

plot(x = df$X.1, y = fit_lm2$residuals,
     xlab = "X.1", ylab = expression(epsilon))
plot(x = df$X.2, y = fit_lm2$residuals,
     xlab = "X.2", ylab = expression(epsilon))
plot(x = df$X.3, y = fit_lm2$residuals,
     xlab = "X.3", ylab = expression(epsilon))

# Optional: Creating your own `lm` object ======================================

# One of the benefits of R over readily packaged statistical software (such as
#     Stata or SPSS) is the ease with which statistical estimators can be
#     implemented (or improved upon) by hand. To see how easy this can be, try
#     writing your own `lm` function. I've written one called `myols`, which
#     supports basic regression analysis of a univariate outcome on a set of
#     regressors stored in a matrix. It does not have the helpful interface of
#     the `lm` object.

# My function takes a numerical vector y and a numerical matrix X, and will
#     return a list containing the inputs as well as a numerical vector of
#     coefficients. The list is assigned a new S3-class called `myols`. This
#     will be useful for constructing a summary method to calculate standard
#     errors.

myols <- function(y, X) {
  # Compute ols coefficient
  XX <- t(X) %*% X
  Xy <- t(X) %*% y
  coef <- solve(XX) %*% Xy

  # Organize and return output
  output <- list(coef = coef, y = y, X = X)
  class(output) <- "myols"
  return(output)
}#MYOLS

# We are not only interested in the point estimates but also want to compute
#     standard errors so that we can do inference. For this purpose, we write a
#     summary method that resembles that for the `lm` object but can also
#     readily provide robust standard error estimates.

summary.myols <- function(obj, robust = T) {
  # Get data parameters
  nobs <- length(obj$y)
  nX <- ncol(obj$X)

  # Calculate fitted values and residuals
  fitted <- obj$X %*% obj$coef
  residual <- as.numeric(obj$y - fitted)

  # Calculate standard errors (robust / non-robust)
  XX_inverse <- solve(t(obj$X) %*% obj$X)
  if (robust == T) {
    # Calculate robust standard errors
    XuuX <- t(obj$X * residual^2) %*% obj$X
    cov_mat <- nobs * XX_inverse %*% XuuX %*% XX_inverse
  } else {
    # Calculate standard errors under homoskedasticity assumption
    cov_mat <- nobs * mean(residual^2) * XX_inverse
  }#IFELSE
  cov_mat <- cov_mat / (nobs - nX) # dof adjustment
  se <- sqrt(diag(cov_mat)) # select standard errors

  # Compute t-statistic and p-values
  t_stat <- obj$coef / se
  p_val <- 2 * pnorm(-abs(t_stat))

  # Compile estimate and se
  res <- cbind(obj$coef, se, t_stat, p_val)
  rownames(res) <- rownames(obj$coef)
  colnames(res) <- c("Coef.", "S.E.", "t Stat.", "p-val.")

  # Compute R^2 and adjusted R^2
  R2 <- 1 - var(residual) / var(obj$y)
  R2_adj <- 1 - (1 - R2) * ((nobs - 1) / (nobs - nX - 1))

  # Compile and return output
  output <- list(res = res, nobs = nobs, R2 = R2, R2_adj = R2_adj)
  return(output)
}#SUMMARY.MYOLS

# First, let's get the full regression matrix where X3 is included as a set of
#     indicator variables.
X_mat <- model.matrix(y ~ 1 + X.1 + X.2 + X.3, data = df)
head(X_mat, 10) # see the last columns for the indicator variables

# We may then regress y on X_mat as before.
fit_ols <- myols(y = df$y, X = X_mat)

# Let's check our summary function. Notice that we don't need to use the
#     full name `summary.myols`. Given an object of class `myols`, R figures
#     out itself which summary method it should use -- that's pretty neat!
summary(fit_ols, robust = TRUE)

# So far so good. Let's check whether the results match that of the lmtest
#    package.
coeftest(fit_lm2, vcov = vcovHC(fit_lm2, type = "HC1"))

# It's the same! Not bad -- we just coded our own least squares object with
#    corresponding robust inference.
