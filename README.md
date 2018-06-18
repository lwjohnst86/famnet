
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
#> # A tibble: 40 x 3
#>    PersonID RelativeID RelativeType
#>       <int>      <int> <chr>       
#>  1       49         47 sibling     
#>  2       47         48 sibling     
#>  3       44         43 sibling     
#>  4       44         42 sibling     
#>  5       43         44 sibling     
#>  6       42         44 sibling     
#>  7       50         49 sibling     
#>  8       50         48 sibling     
#>  9       49         50 sibling     
#> 10       49         48 sibling     
#> # ... with 30 more rows
```

Which indicates all the sibling connections in the `fmn_df` dataset.
