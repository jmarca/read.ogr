library(rgdal)

psqlenv <- Sys.getenv(c("PGHOST", "PGUSER", "PGPASSWORD", "PGDATABASE","PGPORT"))


readOgr <- function ( viewname
                    ,host=psqlenv[1]
                    ,user=psqlenv[2]
                    ,password=psqlenv[3]
                    ,dbname=psqlenv[4]
                    ,port=psqlenv[5]
                    ,...) {
    require(rgdal)
    require(RPostgreSQL)
    require(stringr)

    m <- dbDriver("PostgreSQL")
    con <-  dbConnect(m
                     ,user=user
                     ,password=password
                     ,host=host
                     ,port=port
                     ,dbname=dbname)

    dsn <- paste("PG:dbname='",dbname,"'"
                ," host='",host,"'"
                ," port='",port,"'"
                ," user='",user,"'"
                ," password='",password,"'"
                 ,sep='')
    temp = readOGR(dsn = dsn, layer = viewname,
        stringsAsFactors=FALSE,verbose=FALSE,...)
    dbDisconnect(con)
    return(temp)

}
