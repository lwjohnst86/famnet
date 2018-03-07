
# Load in test data 1, along with expected output
testdata1 <- read.csv("testdata1.csv", stringsAsFactors = FALSE)
testdata1_mother <-
    read.csv("testdata1-expected-mother.csv",
             stringsAsFactors = FALSE, na.strings = "")
testdata1_father <-
    read.csv("testdata1-expected-father.csv",
             stringsAsFactors = FALSE, na.strings = "")

# Load in test data 2
# TODO: Add expected output data files
testdata1 <- read.csv("testdata1.csv", stringsAsFactors = FALSE)
