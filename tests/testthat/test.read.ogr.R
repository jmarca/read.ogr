library(testthat)

##source('../R/read.ogr.R',chdir=TRUE)

test_that("can get data from a view", {

    df <- readOgr('vds_current_view'
                 ## ,host="127.0.0.1"
                 ## ,user="someuser"
                 ## ,password="somepass"
                 ## ,dbname="sometable"
                 ## ,port="someport"
                  )

    expect_that(dim(df),equals(c(15324,15)))
    expect_that(df, is_a("SpatialPointsDataFrame"))
    expect_that(dim(coordinates(df)),equals(c(15324,2)))
})
