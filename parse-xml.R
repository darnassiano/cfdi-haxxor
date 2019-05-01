# @darnassiano
# Usage: Load to your env with `source("cfdi-hx.R")`
library(XML)

parseFact <- function(file){
		dat = xmlParse(file)
		xmld = xmlToList(dat)

		EM=unlist(unname(xmld$Emisor["Nombre"]))

		EM=ifelse(is.null(EM),yes=unlist(unname(xmld$Emisor$.attrs["Nombre"])),no=EM)
		message(file)
		#EM=unname(xmld$Emisor["Nombre"])
		message(EM)
		ST = unlist(unname(xmld$.attrs["SubTotal"][1]) )
		message(ST)
		IT= unlist( unname(xmld$Impuestos$.attrs) )
		message(IT)

		IT=ifelse(is.null(IT),yes=0,no=IT)

		TT= unlist( unname(xmld$.attrs["Total"][1]) )
		message(TT)
		dfb=data.frame(EM,ST=as.numeric(ST),IT=as.numeric(IT),TT=as.numeric(TT),stringsAsFactors = FALSE,check.names = FALSE)
		return(dfb)
	}


parseFactBatch <- function(vector_files){
		dfa = data.frame(EM=character(),ST=numeric(),IT=numeric(),TT=numeric(), check.names = FALSE, stringsAsFactors = FALSE)
		for(i in vector_files){
			dfb=parseFact(i)
			dfa=rbind(dfa,dfb)
		}
	return(dfa)
	}
