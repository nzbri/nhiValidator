#' @details To validate NHIs.
#'
#' @keywords internal
"_PACKAGE"
#> [1] "_PACKAGE"

# create a package environment to hold the character
# lookup table, so it isn't redefined on every comparison:
nhi_env <- new.env(emptyenv())

# define values for 24 letters (excluding I and O) and 10 digits:
nhi_env$lookup = c(1:24, 0:9)

# to look up values by name:
names(nhi_env$lookup) =
    strsplit('ABCDEFGHJKLMNPQRSTUVWXYZ0123456789', split =  '')[[1]]
