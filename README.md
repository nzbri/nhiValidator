
<!-- README.md is generated from README.Rmd. Please edit that file -->

# nhiValidator

<!-- badges: start -->

[![R-CMD-check](https://github.com/nzbri/nhiValidator/workflows/R-CMD-check/badge.svg)](https://github.com/nzbri/nhiValidator/actions)
[![R-CMD-check](https://github.com/nzbri/nhiValidator/workflows/R-CMD-check/badge.svg)](https://github.com/nzbri/nhiValidator/actions)
<!-- badges: end -->

Each person who has contact with the New Zealand health system is issued
a unique 7 character [National Health Index number
(NHI)](https://www.health.govt.nz/our-work/health-identity/national-health-index/upcoming-changes-nhi-numbers).
The unique identification is actually provided by the first six
characters. The seventh is a checksum, which provides for an internal
validity check. This package allows NHIs to be be checked for a valid
checksum, providing for the detection of most typographical errors.

## Installation

nhiValidator is not available from [CRAN](https://CRAN.R-project.org),
so you should install it from [GitHub](https://github.com/) with:

``` r
# install.packages('devtools')
devtools::install_github('nzbri/nhiValidator')
```

## NHI format

NHIs can be in one of two formats: `AAANNNC` (three letters, three
digits, and a numerical check digit) or `AAANNAC` (three letters, two
digits, one letter, and an alphabetic check character). The final check
digit or character is calculated as a checksum based on the first six
characters. Thus it provides an internal validity check, to guard
against data entry errors. This package contains functions that check
for the correct sequence format of letters and characters. It can also
calculate what the check digit should be, and returns whether the
calculated value matches the entered value.

## Example

`JBX3656` (a test value, not issued to a real person) is an example of
the original NHI format (3 letters followed by 4 digits). The
`nhi_valid()` function shows that the internal checksum is valid:

``` r
library(nhiValidator)

nhi_valid('JBX3656')
#> [1] TRUE
```

That is, the final digit, `6`, is calculated based on the preceding 6
characters. Therefore any other final character would yield an invalid
result:

``` r
nhi_valid(c('JBX3650', 'JBX3651', 'JBX3653', 'JBX3654'))
#> [1] FALSE FALSE FALSE FALSE
```

Conversely, transpositions or substitutions among any of the other
characters are very unlikely to be consistent with the final check digit
of `6`:

``` r
nhi_valid(c('BJX3656', 'JBX3696', 'JBX6356', 'JBX3566'))
#> [1] FALSE FALSE FALSE FALSE
```

## New NHI format

As the pool of original NHIs will soon be exhausted, a new format is
being introduced, of the same length but with the final two digits being
replaced by letters. This package can also deal with those.

Details on the new format can be found at the [Ministry of
Health](https://www.health.govt.nz/our-work/health-identity/national-health-index/upcoming-changes-nhi-numbers).
