context('validity checking')

test_that('check internal validity of NHI check digits', {

    # this is a valid NHI (not assigned to a real person):
    expect_equal(nhi_valid('JBX3656'), TRUE)

    # therefore none of these could be valid NHIs, as
    # the check digit of JBX365 must be 6:
    expect_equal(nhi_valid('JBX3650'), FALSE)
    expect_equal(nhi_valid('JBX3651'), FALSE)
    expect_equal(nhi_valid('JBX3652'), FALSE)
    expect_equal(nhi_valid('JBX3653'), FALSE)
    expect_equal(nhi_valid('JBX3654'), FALSE)
    expect_equal(nhi_valid('JBX3655'), FALSE)
    expect_equal(nhi_valid('JBX3657'), FALSE)
    expect_equal(nhi_valid('JBX3658'), FALSE)
    expect_equal(nhi_valid('JBX3659'), FALSE)

    # a valid test case, but we aren't allowing test cases:
    expect_equal(nhi_valid('ZZZ0016'), FALSE)
    # the same valid test case, which we now permit:
    expect_equal(nhi_valid('ZZZ0016', allow_test_cases = TRUE), TRUE)
    # an invalid test case:
    expect_equal(nhi_valid('ZZZ0017', allow_test_cases = TRUE), FALSE)

})

test_that('check that lower case is tolerated', {
    expect_equal(nhi_valid('JBX3656'), nhi_valid('jbx3656'))
})

test_that('check that single cases and vectors are handled', {

    expect_equal(length(nhi_valid('JBX3656')), 1)
    expect_equal(length(nhi_valid(c('JBX3656'))), 1)
    expect_equal(length(nhi_valid(c('JBX3656', 'JBX3657', NA))), 3)

})
