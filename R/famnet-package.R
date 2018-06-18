#' @import data.table
#' @importFrom dplyr select mutate filter full_join union filter_at all_vars
#'   everything
#' @keywords internal
"_PACKAGE"

#' IDs for persons and their mother and/or father.
#'
#' A dataset that contains a person's ID, as well as ID's for their mother
#' and/or father. This dataset is used to show how the famnet functions work.
#'
#' @format Dataframe with 50 rows and 4 variables:
#' * PersonID: Person's ID
#' * MotherID: Person's mother's ID
#' * PersonID: Person's father's ID
#' * Sex: Sex of the person
#'
"fmn_df"

if(getRversion() >= "2.15.1")  utils::globalVariables(c("."))
