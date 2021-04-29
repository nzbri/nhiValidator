
<!-- README.md is generated from README.Rmd. Please edit that file -->

# nhiValidator

<!-- badges: start -->

[![R-CMD-check](https://github.com/nzbri/nhiValidator/workflows/R-CMD-check/badge.svg)](https://github.com/nzbri/nhiValidator/actions)
<!-- badges: end -->

Each person who has contact with the New Zealand health system is issued
a unique 7 character [National Health Index number
(NHI)](https://www.health.govt.nz/our-work/health-identity/national-health-index/upcoming-changes-nhi-numbers).
The unique identification is actually provided by the first six
characters. The seventh is a checksum, which provides for an internal
validity check. This package can check NHIs for a valid checksum,
allowing for the detection of most typographical or other data errors.

## Installation

nhiValidator is not available from [CRAN](https://CRAN.R-project.org),
so you should install it from [GitHub](https://github.com/) with:

``` r
# install.packages('devtools')
devtools::install_github('nzbri/nhiValidator')
```

## NHI format

NHIs can be in one of two formats: the original `AAANNNC` (the
identifier of three letters and three digits, followed by a numerical
check digit) or the revised `AAANNAC` (three letters, two digits, one
letter, and an alphabetic check character). The final check digit or
character is calculated as a checksum based on the first six characters.
Thus it provides an internal validity check, to guard against data entry
errors. This package contains functions that check for the correct
sequence format of letters and characters. It can also conduct the
internal validity check, by calculating what the check digit should be,
and returning whether the calculated value matches the entered value.

## Revised NHI format

As the pool of original NHIs will soon be exhausted, the new format is
about to be introduced. This is of the same length as the original but
with the final two digits being replaced by letters. This provides for
more possible unique values and also improves the strength of the
checksum. This package can deal with either format.

Details on the new format can be found at the [Ministry of
Health](https://www.health.govt.nz/our-work/health-identity/national-health-index/upcoming-changes-nhi-numbers).

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
nhi_valid(c('JBX3650', 'JBX3651', 'JBX3652', 'JBX3653'))
#> [1] FALSE FALSE FALSE FALSE
```

Conversely, transpositions or substitutions among any of the other
characters are very unlikely to be consistent with the final check digit
of `6`:

``` r
nhi_valid(c('BJX3656', 'JBX3696', 'JBX6356', 'JBX3566'))
#> [1] FALSE FALSE FALSE FALSE
```

The other function the package provides is `nhi_format()`. This does not
do the internal validity check of the NHI, but merely reports whether
its sequence of letters and digits is consistent with the original or
revised NHI format, or is in another, invalid format:

``` r
# the second entry below would fail the internal validity check,
# but is still in the expected format of an original NHI
nhi_format(c('JBX3656', 'JBX3657', 'ZZZ00AX', 'HELLO', NA),
           allow_test_cases = TRUE)
#> [1] "original format" "original format" "revised format"  "invalid format" 
#> [5] NA
```

## Test cases

NHIs (of either format) that start with `Z` are reserved for testing
purposes (i.e. they will never be assigned to real people). These are
likely only of interest to software developers and system testers. This
package defaults to regarding such NHIs as invalid, because they are
only likely to be encountered in the wild as the result of a typo or
other data error. If, however, you would like to process such values,
you can override that behaviour by setting the `allow_test_cases = TRUE`
parameter in either the `nhi_format()` or `nhi_valid()` functions.

## Licence

This package was developed by [Michael
MacAskill](https://www.nzbri.org/people/macaskill/) at the New Zealand
Brain Research Institute. It is released as open-source software under
an [MIT licence](https://opensource.org/licenses/MIT). Note the
provisions under that licence about warranties and liability.

Please report any issues or suggestions using the [Github issues page
for this project](https://github.com/nzbri/nhiValidator/issues).
