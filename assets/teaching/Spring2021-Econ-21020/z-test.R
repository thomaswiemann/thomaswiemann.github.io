# z-Test in R ==================================================================
# Author: Thomas Wiemann

# This R script provides an illustration of z-tests for single and two-sample
#     means. First a custom implementation of a z-test is considered. After
#     illustrating the function with the cars dataset, the function is compared
#     to the t.test function in base R.

# Preliminaries ================================================================

# No packages required

# No random seed required

# Custom z-test implementation =================================================

# We begin by implementing custom functions for the one- and two-sample z-test.

# The implementation will take a numerical vector x for a one-sample test. For
#     a two-sample test, the function takes two numerical vectors, x and y. The
#     argument mu gives the hypothesized (difference) in mean.
my_z_test <- function(x, y = NULL,
                      mu = 0,
                      alternative = c("not equal", "less", "greater")) {
  # First, we check whether a one- or two-sample test should be calculated.
  calc_two_sample <- !is.null(y)

  # Second, we calculate the test statistic for our test. Notice that x_bar and
  #     sigma_x need to be calculated in any case, but that we only need to
  #     calculate the equivalents for y for the two-sample test.
  x_bar <- mean(x)
  sigma_x <- sd(x)
  n_x <- length(x)
  if (calc_two_sample == FALSE) {
    # Calculate one-sample test statistic
    test_stat <- sqrt(n_x) * (x_bar - mu) / sigma_x
  } else {
    # Calculate two-sample test statistic
    y_bar <- mean(y)
    sigma_y <- sd(y)
    n_y <- length(y)
    test_stat <- (x_bar - y_bar - mu) / sqrt(sigma_x^2/n_x + sigma_y^2/n_y)
  }#IFELSE

  # Finally, given our test statistic, we calculate the p-value of the test.
  #    This crucially depends on the alternative hypothesis.
  if (alternative[1] == "not equal") {
    # Two-sided test
    p_value <- 2 * pnorm(-abs(test_stat), mean = 0, sd = 1)
  } else if (alternative[1] == "less") {
    # One-sided test
    p_value <- pnorm(test_stat, mean = 0, sd = 1)
  } else if (alternative[1] == "greater") {
    # One-sided test
    p_value <- pnorm(-test_stat, mean = 0, sd = 1)
  } else {
    # Print an error if the alternative hypothesis does not math one of the
    #     three values.
    stop("Please specify a valid alternative hypothesis.")
  }#IFELSE

  # Return the p-value
  return(p_value)
}#MY_Z_TEST

# Testing differences in stopping distances ====================================

# To check whether the z-test implementation works, consider the cars dataset
#    contained in base R. For ease of notation, let x denote the sample of cars
#    with speed below 15, and let y denote the sample with speed of at least 15.
#    We want to check the stopping distances of cars given differences in speed.
#    Let's start with loading the dataset and creating the two numerical vectors
#    of car stopping distances by speed.

x <- cars$dist[cars$speed < 15]
y <- cars$dist[cars$speed >= 15]

# As illustrative examples, consider two tests:
#
#    a) H_0: mu_x = 15 vs H_1: mu_x != 15
#
#    b) H_0: mu_x = mu_y vs H_1: mu_x < mu_y
#
#    Notice that in a), we test whether the mean distance of the slow cars is
#    15 versus the alternative that it is not equal to 15. In b), we consider
#    instead whether slow cars have the same mean stopping distance as fast cars
#    versus the alternative that they have a lower mean stopping distance.

# First, let us consider a) H_0: mu_x = 15 vs H_1: mu_x != 15.
#     The test returns a p-value of approximately 0.0013. Would we reject? That
#     depends on the chosen significance level, of course.

my_z_test(x = x, mu = 15, alternative = "not equal")

# Second, let us consider b) H_0: mu_x = mu_y vs H_1: mu_x < mu_y.
#     The test returns a p-value of approximately 1.3e-7.

my_z_test(x = x, y = y, mu = 0, alternative = "less")

# Comparison with Base R t.test ================================================

# Unfortunately, base R does not include an off-the-shelf implementation for the
#    z-test. It does, however, implement a t-test. t-tests are based on the
#    Student's t-distribution. When the sample size diverges to infinity, the
#    t-test is equivalent to the z-test. A quick comparison between the
#    implemented t.test and our my_z_test function could thus be helpful.

# First, we consider a) H_0: mu_x = 15 vs H_1: mu_x != 15.
#    The test returns a p-value of approximately 0.0041. Notice that there is a
#    slight difference between the z-test and the t-test. This is due to the
#    relatively small sample size that we consider.

t.test(x = x, mu = 15, alternative = "two.sided")

# Second, we consider b) H_0: mu_x = mu_y vs H_1: mu_x < mu_y.
#    The test returns a p-value of approximately 2.6e-6. Again there is a small
#    difference between the z-test and the t-test, that can be attributed to the
#    small sample size.

t.test(x = x, y = y, mu = 0, alternative = "less")

# Notice that the t.test function returns a lot more information than just the
#    p-value. For example, it also prints the 95% confidence interval. That's
#    pretty helpful! To improve our z-test implementation, we could amend our
#    custom function to do the same. I leave this as an optional exercise to
#    avid student.
