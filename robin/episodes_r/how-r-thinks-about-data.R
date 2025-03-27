## ----setup, include=FALSE-----------------------------
knitr::opts_chunk$set(dpi = 200, out.height = 600, out.width = 600, R.options = list(max.print = 100))


## ----load-packages, message=FALSE---------------------
library(tidyverse)
library(ratdat)


## ----class--------------------------------------------
class(complete_old)


## ----head---------------------------------------------
head(complete_old)
tail(complete_old)


## ----head-help----------------------------------------
?head


## ----head-n-------------------------------------------
head(complete_old, n = 10)


## ----head-n-noname------------------------------------
head(complete_old, 10)


## ----head-reverse-------------------------------------
head(n = 10, x = complete_old)


## -----------------------------------------------------
summary(complete_old)


## -----------------------------------------------------
str(complete_old)


## ----dollar-subsetting--------------------------------
complete_old$year


## ----c-vector-----------------------------------------
c(1, 2, 5, 12, 4)


## ----assign-vector------------------------------------
num <- c(1, 2, 5, 12, 4)


## -----------------------------------------------------
class(num)


## -----------------------------------------------------
char <- c("apple", "pear", "grape")
class(char)


## -----------------------------------------------------
logi <- c(TRUE, FALSE, TRUE, TRUE)
class(logi)


## ----coercion-challenge-------------------------------
num_logi <- c(1, 4, 6, TRUE)
num_char <- c(1, 3, "10", 6)
char_logi <- c("a", "b", TRUE)


tricky <- c("a", "b", "1", FALSE)


## ----coercion-challenge-answer------------------------
class(num_logi)
class(num_char)
class(char_logi)
class(tricky)


## ----combined-logical-challenge-----------------------
combined_logical <- c(num_logi, char_logi)


## ----combined-logical-challenge-answer----------------
combined_logical
class(combined_logical)


## ----na-vec-------------------------------------------
weights <- c(25, 34, 12, NA, 42)


## ----func-na------------------------------------------
min(weights)


## ----func-na-rm---------------------------------------
min(weights, na.rm = TRUE)


## ----single-quantile----------------------------------
quantile(complete_old$weight, probs = 0.25, na.rm = TRUE)


## ----multi-quantile-----------------------------------
quantile(complete_old$weight, probs = c(0.25, 0.5, 0.75), na.rm = TRUE)


## ----seq----------------------------------------------
# generates a sequence of integers
1:10

# with seq() you can generate sequences with a combination of:
# from: starting value
# to: ending value
# by: how much should each entry increase
# length.out: how long should the resulting vector be
seq(from = 0, to = 1, by = 0.1)

seq(from = 0, to = 1, length.out = 50)

seq(from = 0, by = 0.01, length.out = 20)


## ----rep----------------------------------------------
# repeats "a" 12 times
rep("a", times = 12)

# repeats this whole sequence 4 times
rep(c("a", "b", "c"), times = 4)

# repeats each value 4 times
rep(1:10, each = 4)


## ----seq-chalenge, echo=FALSE-------------------------
rep(-3:3, 3)


## ----seq-challenge-answer-----------------------------
rep(-3:3, 3)

# this also works
rep(seq(from = -3, to = 3, by = 1), 3)

# you might also store the sequence as an intermediate vector

my_seq <- seq(from = -3, to = 3, by = 1)
rep(my_seq, 3)


## ----quantiles-challenge-answer-----------------------
quantile(complete_old$hindfoot_length, 
         probs = seq(from = 0, to = 1, by = 0.05),
         na.rm = T)


## ----factors------------------------------------------
sex <- factor(c("male", "female", "female", "male", "female", NA))

sex


## ----levels-------------------------------------------
levels(sex)


## ----forcats------------------------------------------
library(forcats)

# change the order of the levels
fct_relevel(sex, c("male", "female"))

# change the names of the levels
fct_recode(sex, "M" = "male", "F" = "female")

# turn NAs into an actual factor level (useful for including NAs in plots)
fct_na_value_to_level(sex, "(Missing)")



## ----factor-character---------------------------------
as.character(sex)


## ----factor-numeric-----------------------------------
f_num <- factor(c(1990, 1983, 1977, 1998, 1990))

# this will pull out the underlying integers, not the levels
as.numeric(f_num)

# if we first convert to characters, we can then convert to numbers
as.numeric(as.character(f_num))


## ----assignment-challenge, eval=FALSE-----------------
# x <- 5
# y <- x
# x <- 10


## ----assignment-challenge-answer----------------------
x <- 5
y <- x
x <- 10
y


## ----assignments--------------------------------------
x <- 5

# first, x gets evaluated to 5
# then 5/2 gets evaluated to 2.5
# then sqrt(2.5) is evaluated
sqrt(x/2)

# we can also store the evaluated value of x/2 
# in an object y before passing it to sqrt()
y <- x/2

sqrt(y)

# first, the x on the righthand side gets evaluated to 5
# then 5 gets squared
# then the resulting value is assigned to the object x

x <- x^2

x

