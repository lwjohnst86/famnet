
fmn_siblings_tv <- function(.data, .personid, .motherid, .fatherid) {

}

fmn_full_sibling_dt <- function() {
    .data <- data.table::data.table(.data)
    .data[, data.table::CJ(from = PersonID, to = PersonID)[from < to],
          by = .(FatherID, MotherID)]

}
