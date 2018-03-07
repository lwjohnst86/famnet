context("test-parents.R")

test_that("Mothers are mothers", {
    expect_equal(fmn_mother_tv(testdata1, "PersonID", "MotherID"),
                 testdata1_mother)
})

test_that("fathers are fathers", {
    expect_equal(fmn_father_tv(testdata1, "PersonID", "FatherID"),
                 testdata1_father)
})
