
<!-- README.md is generated from README.Rmd. Please edit that file -->

# famnet

[![Travis build
status](https://travis-ci.org/lwjohnst86/famnet.svg?branch=master)](https://travis-ci.org/lwjohnst86/famnet)
[![Coverage
status](https://codecov.io/gh/lwjohnst86/famnet/branch/master/graph/badge.svg)](https://codecov.io/github/lwjohnst86/famnet?branch=master)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

The goal of famnet is to characterize a family network, based on having
an individual’s ID, and their mother’s and father’s ID.

# Installation

Install the developmental version.

``` r
# install.packages("remotes")
remotes::install_github("lwjohnst86/famnet")
```

# Usage

You can use the famnet functions to determine family relation links. For
instance, say you a dataset like this:

``` r
library(famnet)
head(fmn_df)
#>   PersonID FatherID MotherID Sex
#> 1        1       NA       NA   f
#> 2        2       NA       NA   m
#> 3        3       NA       NA   f
#> 4        4       NA       NA   m
#> 5        5       NA       NA   f
#> 6        6       NA       NA   m
tail(fmn_df)
#>    PersonID FatherID MotherID Sex
#> 45       45       NA       NA   f
#> 46       46       NA       NA   f
#> 47       47       38       45   m
#> 48       48       38       46   f
#> 49       49       38       46   m
#> 50       50       NA       46   f
```

And you want to determine sibling relations. You can use:

``` r
library(famnet)
fmn_siblings(fmn_df, "PersonID", "MotherID", "FatherID")
#>    PersonID RelativeID RelativeType
#> 1        49         47      sibling
#> 2        48         47      sibling
#> 3        47         49      sibling
#> 4        47         48      sibling
#> 5        44         43      sibling
#> 6        44         42      sibling
#> 7        43         44      sibling
#> 8        42         44      sibling
#> 9        50         49      sibling
#> 10       50         48      sibling
#> 11       49         50      sibling
#> 12       49         48      sibling
#> 13       48         50      sibling
#> 14       48         49      sibling
#> 15       43         42      sibling
#> 16       42         43      sibling
#> 17       40         39      sibling
#> 18       39         40      sibling
#> 19       34         33      sibling
#> 20       33         34      sibling
#> 21       31         30      sibling
#> 22       31         29      sibling
#> 23       30         31      sibling
#> 24       30         29      sibling
#> 25       29         31      sibling
#> 26       29         30      sibling
#> 27       27         26      sibling
#> 28       26         27      sibling
#> 29       24         23      sibling
#> 30       23         24      sibling
#> 31       16         15      sibling
#> 32       15         16      sibling
#> 33       14         13      sibling
#> 34       13         14      sibling
#> 35       12         11      sibling
#> 36       12         10      sibling
#> 37       11         12      sibling
#> 38       11         10      sibling
#> 39       10         12      sibling
#> 40       10         11      sibling
```

Which indicates all the sibling connections in the `fmn_df` dataset.
