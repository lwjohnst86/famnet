
# Generate a fake/play dataset of a family network.
fmn_df <- read.csv("data-raw/testdata1.csv", stringsAsFactors = FALSE)
devtools::use_data(fmn_df, overwrite = TRUE)
