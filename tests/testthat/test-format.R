# these tests are only of the sequential format of digits and letters in the NHI.
# They do not assess the internal validity


test_that('check that NA is handled', {
    expect_equal(nhi_format(NA), NA)
})


test_that('check that lower case is tolerated', {
    expect_equal(nhi_format('JBX3656'), nhi_format('jbx3656'))
})

test_that('check some known results', {
    expect_equal(nhi_format('JBX3656'), 'original format')
    expect_equal(nhi_format('JBX3657'), 'original format') # even though invalid
    expect_equal(nhi_format('ZZZ00AX', allow_test_cases = TRUE), 'revised format')
    expect_equal(nhi_format('HELLO'), 'invalid format')
    expect_equal(nhi_format(NA), NA)
})

test_that('check handling cases that start with Z', {

    # typically NHIs starting with Z can be regarded as invalid:
    expect_equal(nhi_format('ZZZ9998'), 'invalid format')
    # equivalently:
    expect_equal(nhi_format('ZZZ9998', allow_test_cases = FALSE), 'invalid format')

    # strictly, Z NHIs are acceptable for testing purposes:
    expect_equal(nhi_format('ZZZ9998', allow_test_cases = TRUE), 'original format')
    # this would be internally valid if test cases were allowed:
    expect_equal(nhi_format('ZZZ00AX'), 'invalid format')
    # which we do here:
    expect_equal(nhi_format('ZZZ00AX', allow_test_cases = TRUE), 'revised format')

})
