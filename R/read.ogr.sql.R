psqlenv <- Sys.getenv(c("PGHOST", "PGUSER", "PGPASSWORD", "PGDATABASE","PGPORT"))


readOgrSQL <- function ( sql
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
    viewname <- paste('tempview',paste(rpois(10,lambda=4),sep='',collapse=''),sep='_')
    strCreateView = paste("CREATE VIEW",viewname,"AS", sql)
    make.temp.view <- dbSendQuery(con, strCreateView)
    temp = readOGR(dsn = dsn, layer = viewname,
        stringsAsFactors=FALSE,verbose=FALSE,...)
    dbSendQuery(con, paste("DROP VIEW",viewname))
    dbDisconnect(con)
    return(temp)

}
