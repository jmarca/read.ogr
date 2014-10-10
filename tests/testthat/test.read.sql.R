test_that("can get data from arbitrary sql, no geo stuff", {

    df <- readOgrSQL('select * from smartsig. limit 100'
                 ## ,host="127.0.0.1"
                 ## ,user="someuser"
                 ## ,password="somepass"
                 ## ,dbname="sometable"
                 ## ,port="someport"
                     )

    expect_that(dim(df),equals(c(100,15)))
    expect_that(df, is_a("SpatialPointsDataFrame"))
    expect_that(dim(coordinates(df)),equals(c(100,2)))
})
