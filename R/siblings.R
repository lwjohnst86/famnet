
fmn_siblings_tv <- function(.data, .personid, .motherid, .fatherid) {
    same_mother <- fmn_sibling_same_mother_tv(.data, .personid, .motherid)
    same_father <- fmn_sibling_same_father_tv(.data, .personid, .fatherid)
    union(
        same_mother %>%
            mutate(RelativeType = "sibling") %>%
            select(.personid, RelativeID, RelativeType),
        same_father %>%
            mutate(RelativeType = "sibling") %>%
            select(.personid, RelativeID, RelativeType)
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
                  select("RelativeID" = .personid, .parentid)) %>%
        filter_at(.parentid, all_vars(!is.na(.))) %>%
        filter(!!rlang::sym("RelativeID") != !!rlang::sym(.personid)) %>%
        mutate(RelativeType = paste0("sibling, same ", .relation)) %>%
        select("PersonID", "RelativeID", "RelativeType", everything())
}

# fmn_full_siblings_tv <- function(.data, .personid, .motherid, .fatherid) {
#     full_join(
#         .data,
#         .data %>%
#             select("RelativeID" = .personid, .motherid, .fatherid)
#     ) %>%
#         filter(complete.cases(.), RelativeID != PersonID) %>%
#         mutate(RelativeType = "Sibling") %>%
#         select(PersonID, RelativeID, RelativeType, everything())
# }
#


#' Title
#'
#' @param .data
#' @param .personid
#' @param .motherid
#' @param .fatherid
#'
#' @return
#' @export
#'
#' @examples
#'
#' fmn_siblings_dt(fmn_df, "PersonID", "MotherID", "FatherID")
fmn_siblings_dt <- function(.data, .personid, .motherid, .fatherid) {
    .data <- data.table(.data)
    original_data <- .data[, c(.personid, .motherid), with = FALSE]
    mother_data <- .data[, c(.personid, .motherid), with = FALSE]
    setnames(mother_data, .personid, "RelativeID")
    same_mother <-
        original_data[mother_data,
                      on = .motherid,
                      allow.cartesian = TRUE,
                      nomatch = NA]
    same_mother <- same_mother[!is.na(get(.motherid)), ]
    set(same_mother, j = "RelativeType", value = "sibling")
    print(same_mother)

    #     merge(
    #     .data[, c(.personid, .motherid), with = FALSE],
    #     .data[, c(.personid, .motherid), with = FALSE][, c(RelativeID = .personid), with = FALSE],
    #     by = .motherid
    # )

    # same_mother
    # .data[!is.na(.data[[.fatherid]]) |
    #           !is.na(.data[[.motherid]]),
    #       data.table::CJ(PersonID = .data[[.personid]], RelativeID = .data[[.personid]])[PersonID != RelativeID],
    #       by = c(.motherid, .fatherid)]

    # [
    #           is.na(MotherID) | is.na(FatherID)
    #       ]
}
