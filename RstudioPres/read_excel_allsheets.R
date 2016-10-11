read_excel_allsheets <- function(filename) {
        sheets <- readxl::excel_sheets(filename)
        x <- lapply(sheets, 
                    function(X) read_excel(filename, 
                                           sheet = X, 
                                           skip = 1, 
                                           col_names = TRUE))
        names(x) <- sheets
        x
}