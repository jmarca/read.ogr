

library(RPostgreSQL)
library(rgeos)
library(sp)

readOgrSQL <- function ( sql
                       ,host=psqlenv[1]
                       ,user=psqlenv[2]
                       ,password=psqlenv[3]
                       ,dbname=psqlenv[4]
                       ,port=psqlenv[5]
                       ,...) {
    m <- dbDriver("PostgreSQL")
    print (paste('connecting with'
                ,user=user
                ,password=password
                ,host=host
                ,port=port
                ,dbname=dbname))
    con <-  dbConnect(m
                     ,user=user
                     ,password=password
                     ,host=host
                     ,port=port
                     ,dbname=dbname)

    viewname <- paste('tempview',paste(rpois(10,lambda=4),sep='',collapse=''),sep='_')
    strCreateView = paste("CREATE VIEW",viewname,"AS", sql)
    make.temp.view <- dbSendQuery(con, strCreateView)
    temp = dbGetQuery(conn, "select * from "+viewname)
    dbSendQuery(con, paste("DROP VIEW",viewname))
    dbDisconnect(con)
    return(temp)
}
