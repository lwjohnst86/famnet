context("Siblings")

test_that("Full siblings are determined", {
    expected <- read.csv(
        "testdata1-expected-full-siblings.csv",
        stringsAsFactors = FALSE,
        na.strings = ""
    )[1:3]
    expected <- data.table::data.table(expected)
    actual <- na.omit(fmn_full_siblings_tv(fmn_df, "PersonID", .motherid = "MotherID", .fatherid = "FatherID"))
    expect_equal(actual, expected)
})
