
#' Determine the mother relationship.
#'
#' Fairly simple wrapper around an [dplyr::if_else()] condition. This function
#' is a tidyverse (`_tv`) version. The goal of the output data is to mimic a
#' network (start node, end node, edge type).
#'
#' @rdname parents_tv
#' @param .data Dataset with person and mother id, at least.
#' @param .personid Individual's ID.
#' @param .motherid Individual's mother's ID.
#' @param .fatherid Individual's father's ID.
#'
#' @return Dataset with the columns: person ID, RelativeID, RelativeType.
#' @export
#'
#' @examples
#'
#' fmn_mother_tv(fmn_df, "PersonID", "MotherID")
#' fmn_father_tv(fmn_df, "PersonID", "FatherID")
#'
fmn_mother_tv <- function(.data, .personid, .motherid) {
    relation_parent_tv(
        .data,
        .personid = .personid,
        .parentid = .motherid,
        .parent_type = "mother"
    )
}

#' @rdname parents_tv
#' @export
fmn_father_tv <- function(.data, .personid, .fatherid) {
    relation_parent_tv(
        .data,
        .personid = .personid,
        .parentid = .fatherid,
        .parent_type = "father"
    )
}

relation_parent_tv <- function(.data, .personid, .parentid, .parent_type) {
    .data %>%
        dplyr::mutate(RelativeType = dplyr::if_else(!is.na(.data[[.parentid]]), .parent_type, NA_character_)) %>%
        dplyr::rename_at(.parentid, dplyr::funs(paste0("RelativeID"))) %>%
        dplyr::select_at(c(.personid, "RelativeID", "RelativeType"))
}
