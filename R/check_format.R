#' Check NHIs for correct format.
#'
#' \code{nhi_format} Check whether NHIs have the basic
#' format of 3 valid letters (excluding \code{O} and \code{I} ), followed
#' by 2 digits, followed by either another two digits (the original format)
#' or two letters (the revised format). NHIs with \code{Z} in the first
#' position are for testing purposes only and so unless specified otherwise,
#' will be treated as invalid.
#'
#' @param nhi A character variable of the format \code{ZYX1234} (original)
#' or \code{ZYX00AX} (revised).
#'
#' @param allow_test_cases If \code{TRUE}, NHIs that start with \code{Z}
#' (reserved for testing purposes) are treated as valid. Otherwise, treat
#' them as invalid (almost certainly the right choice in real-world
#' situations).
#'
#' @return \code{'original format'}, \code{'revised format'}, or
#' \code{'invalid format'}.
#'
#' @examples
#' # assess a test value of the original format (not a real person):
#' nhi_format('JBX3656')
#'
#' # check a formal test case of the revised format:
#' nhi_format('ZZZ00AX', allow_test_cases = TRUE)
#'
#' @export
nhi_format <- function(nhi, allow_test_cases = FALSE) {

    if (is.na(nhi)) {
        return(NA)
    }

    nhi = toupper(nhi)

    if (allow_test_cases == TRUE) {
        # allow NHIs that start with Z (reserved for test cases).
        # Original format is 3 letters excluding O and I, followed by 4 digits.
        original_pattern = '^[A-HJ-NP-Z]{3}[0-9]{4}$'
        # Revised format is 3 letters followed by 2 digits followed 2 letters:
        revised_pattern  = '^[A-HJ-NP-Z]{3}[0-9]{2}[A-HJ-NP-Z]{2}$'
    } else { # don't allow Z in the first position (most common use case):
        original_pattern = '^[A-HJ-NP-Y][A-HJ-NP-Z]{2}[0-9]{4}$'
        revised_pattern  = '^[A-HJ-NP-Y][A-HJ-NP-Z]{2}[0-9]{2}[A-HJ-NP-Z]{2}$'
    }

    if (grepl(pattern = original_pattern, x = nhi)) {
        return('original format')
    }

    if (grepl(pattern = revised_pattern, x = nhi)) {
        return('revised format')
    } else {
        return('invalid format')
    }
}
