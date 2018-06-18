context("Siblings")

test_that("(unspecified) siblings are determined (tidyverse and data.table)", {
    expected <- read.csv(
        "testdata1-expected-siblings.csv",
        stringsAsFactors = FALSE,
        na.strings = ""
    )[1:3]
    actual <- fmn_siblings_tv(fmn_df, "PersonID", .motherid = "MotherID", .fatherid = "FatherID") %>%
        dplyr::select(PersonID, RelativeID, RelativeType) %>%
        dplyr::arrange(PersonID, RelativeID)
    expect_equivalent(actual, expected)

    expected <- data.table::data.table(expected)
    actual <- fmn_siblings_dt(fmn_df, "PersonID", .motherid = "MotherID", .fatherid = "FatherID") %>%
        dplyr::select(PersonID, RelativeID, RelativeType) %>%
        dplyr::arrange(PersonID, RelativeID)
    expect_equivalent(actual, expected)
})
