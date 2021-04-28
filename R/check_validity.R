# Conduct internal validity check of an NHI.
#
# This hidden function checks only one scalar value. See the exported,
# vector-safe nhi_valid() function for documentation.
#
.is_valid_nhi <- function(nhi, nhi_type = 'original format') {

    checksum = 0
    nhi = toupper(nhi)
    characters = strsplit(nhi, split = '')[[1]][1:7]

    if (nhi_type == 'original format') {
        modulus = 11
    } else {
        modulus = 24 # for revised format
    }

    # multiply each character's looked-up numeric value by its reversed
    # position in the string (ie multiply the 1st by 7, the 2nd by 6, etc):
    for (j in 7:2) {
        checksum = (nhi_env$lookup[characters[8 - j]] * j) + checksum
    }

    checksum = checksum %% modulus
    if (checksum == 0) { # defined to be incorrect
        return(FALSE)
    } else {
        checksum = (modulus - checksum)

        if (nhi_type == 'original format') {
            # change 10 to 0, otherwise left unchanged:
            checksum = as.character(checksum %% 10)
        } else {
            # in the new format, convert it to a letter:
            checksum = names(nhi_env$lookup)[checksum]
        }

        # compare to the final check digit:
        if (checksum == characters[7]) {
            return(TRUE)
        } else {
            return(FALSE)
        }
    }
}

#' Conduct internal validity check of an NHI.
#'
#' \code{nhi_valid} Check whether the format and final check digit of a
#' New Zealand NHI (National Health Index number) are correct.
#'
#' @param nhi A character variable of the format \code{ZYX1234} (original)
#' or \code{ZYX00AX} (revised).
#'
#' @param allow_test_cases If \code{TRUE}, NHIs that start with \code{Z}
#' (reserved for testing purposes) are treated as valid. Otherwise, regard
#' them as invalid (almost certainly the right choice in real-world
#' situations).
#'
#' @return \code{TRUE} if the format is correct and the final check digit
#' matches the calculated value, \code{FALSE} otherwise.
#'
#' @examples
#' nhi_valid('JBX3656') # TRUE
#'
#' nhi_valid('JBX3657') # FALSE (check digit should be 6)
#'
#' nhi_valid('ZZZ00AX', allow_test_cases = TRUE) # TRUE
#'
#' nhi_valid('ZZZ00AX') # FALSE in real-world situations
#'
#' @export
nhi_valid <- function(nhi, allow_test_cases = FALSE) {

    # allow for more than one value to be processed:
    n = length(nhi)
    result = rep(NA, n) # create a same-length vector to return

    for (i in 1:n) {

        # check if empty:
        if (is.na(nhi[i])) {
            result[i] = NA

        } else {
            # check for the basic sequential structure of valid letters and digits:
            nhi_type = nhi_format(nhi[i], allow_test_cases = allow_test_cases)

            if (nhi_type == 'original format' | nhi_type == 'revised format') {
                result[i] = .is_valid_nhi(nhi[i], nhi_type) # TRUE or FALSE
            } else { # was invalid format:
                result[i] = FALSE
            }
            }
    }

    return(result)
}
