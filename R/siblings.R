
#' Determine who are siblings using only ID, mother ID, and father ID
#'
#' This function is best used with data on a very large population, that has
#' information on an individual as well as that person's parent's IDs. Common
#' datasets with this information would be population level register databases,
#' such as found in Denmark or Sweden.
#'
#' @param .data Data that contains columns of persons IDs, for the individual,
#'   mother, and father.
#' @param .personid Column with main person's ID.
#' @param .motherid Column with person's mother's ID.
#' @param .fatherid Column with person's father's ID.
#'
#' @return A dataset with at least:
#' * `PersonID`: An individual's ID
#' * `RelativeID`: An ID of one of the individual's relative or family member
#' * `RelativeType`: The type of relationship between the person and the relative
#'
#' @export
#'
#' @examples
#'
#' # Uses tidyverse under the hood. There is a data.table version available.
#' fmn_siblings(fmn_df, "PersonID", "MotherID", "FatherID")
fmn_siblings <- function(.data, .personid, .motherid, .fatherid) {
    fmn_siblings_tv(
        .data = .data,
        .personid = .personid,
        .motherid = .motherid,
        .fatherid = .fatherid
    )
}

#' @describeIn fmn_siblings Function to determine sibling relationships, using
#'   "[tidyverse](https://www.tidyverse.org/packages/)" functions (e.g.
#'   [dplyr](https://dplyr.tidyverse.org/)).
fmn_siblings_tv <- function(.data, .personid, .motherid, .fatherid) {
    same_mother <- fmn_sibling_same_mother_tv(.data, .personid, .motherid)
    same_father <- fmn_sibling_same_father_tv(.data, .personid, .fatherid)
    dplyr::union(
        same_mother %>%
            mutate(RelativeType = "sibling") %>%
            select(-.motherid),
        same_father %>%
            mutate(RelativeType = "sibling") %>%
            select(-.fatherid)
    )
}

fmn_sibling_same_father_tv <- function(.data, .personid, .fatherid) {
    fmn_sibling_same_parent_tv(
        .data,
        .personid = .personid,
        .parentid = .fatherid,
        .relation = "father"
    )
}

fmn_sibling_same_mother_tv <- function(.data, .personid, .motherid) {
    fmn_sibling_same_parent_tv(
        .data,
        .personid = .personid,
        .parentid = .motherid,
        .relation = "mother"
    )
}

fmn_sibling_same_parent_tv <- function(.data, .personid, .parentid, .relation = c("father", "mother")) {
    .relation <- match.arg(.relation)
    full_join(.data %>%
                  select(.personid, .parentid),
              .data %>%
                  select("RelativeID" = .personid, .parentid),
              by = .parentid) %>%
        filter_at(.parentid, all_vars(!is.na(.))) %>%
        filter(!!rlang::sym("RelativeID") != !!rlang::sym(.personid)) %>%
        mutate(RelativeType = paste0("sibling, same ", .relation)) %>%
        select("PersonID", "RelativeID", "RelativeType", everything())
}

#' @describeIn fmn_siblings Function to determine sibling relationships using
#'   [data.table](https://github.com/Rdatatable/data.table/wiki) functions.
fmn_siblings_dt <- function(.data, .personid, .motherid, .fatherid) {
    same_mother <- fmn_sibling_same_mother_dt(.data, .personid, .motherid)[, !.motherid, with = FALSE]
    set(same_mother, j = "RelativeType", value = "sibling")
    same_father <- fmn_sibling_same_father_dt(.data, .personid, .fatherid)[, !.fatherid, with = FALSE]
    set(same_father, j = "RelativeType", value = "sibling")
    funion(same_mother, same_father)
}

fmn_sibling_same_mother_dt <- function(.data, .personid, .motherid) {
        fmn_sibling_same_parent_dt(
            .data = .data,
            .personid = .personid,
            .parentid = .motherid,
            .relation = "mother"
        )
}

fmn_sibling_same_father_dt <- function(.data, .personid, .fatherid) {
        fmn_sibling_same_parent_dt(
            .data = .data,
            .personid = .personid,
            .parentid = .fatherid,
            .relation = "father"
        )
}

fmn_sibling_same_parent_dt <- function(.data, .personid, .parentid, .relation = c("mother", "father")) {
    .relation <- match.arg(.relation)
    .data <- data.table(.data)
    parent_data <- .data[, c(.personid, .parentid), with = FALSE]
    setnames(parent_data, .personid, "RelativeID")
    same_parent <-
        .data[, c(.personid, .parentid), with = FALSE][
            parent_data,
            on = .parentid,
            allow.cartesian = TRUE,
            nomatch = NA][
                !is.na(get(.parentid)),][
                    get(.personid) != get("RelativeID"), ]
    set(same_parent, j = "RelativeType", value = paste0("sibling, same ", .relation))
    return(same_parent)
}
