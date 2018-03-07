
# Load in test data 1, along with expected output
devtools::load_data()
testdata1 <- fmn_df
testdata1_mother <-
    read.csv("testdata1-expected-mother.csv",
             stringsAsFactors = FALSE, na.strings = "")[1:3]
testdata1_father <-
    read.csv("testdata1-expected-father.csv",
             stringsAsFactors = FALSE, na.strings = "")[1:3]

# Load in test data 2
# TODO: Add expected output data files
testdata2 <- read.csv("testdata2.csv", stringsAsFactors = FALSE)
