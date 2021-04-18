library(igraph)
library(tidyverse)
library(data.table)
library(httr)
library(jsonlite)
library(tidyverse)
library(stringr)
library(plyr)

# clean environment
rm(list = ls())

io <- str_to_lower(c("ioc", "isa", "imo", "cbd", "unep", "fao"))
io <- sort(io)
igo <-       str_to_lower(c("NEAFC", "ISA", 
                            "HELCOM", "CPPS", "NAFO",
                            "NPFC","OSPAR", "SPREP", "WCPFC", "AALCO",
                            "ICES", "Commonwealth", "Iccat", "SPC", "IPBES", "IATTC", "Medfund", "GCF", "SEAFO",
                            "Pacific Island Forum", "SICA", "WTO", "Nauru Agreement", "ILO", "IWC", "ATS",
                            "Benguela", "PEMSEA", "IPCC", "CCAMLR", "APFIC",
                            "GLFC", "IOTC", "IPHC", "NASCO", "PSC",
                            "SEAFDEC", "NACA", "PICES", "IAEA", "WMO", "world bank","UNIDO", "UNSD", "UNCLOS", "UNDESA", 
                            "UNECE", "UNFCCC", "UNEP", "UNDP", "UNFF", "Commission on the limits of the continental shelf",
                            "ITLOS", "GESAMP", "CMS", "Abidjan", "Minamata","CBD", "cites", "Barcelona convention",
                            "FAO", "WIPO", "IMO", "IOC", "GFCM", "GEF", "the WHO"))

igo <- sort(igo)

url_list_fao <- read.csv("url_list_fao.csv")
url_list_cbd <- read.csv("url_list_cbd.csv")
url_list_imo <- read.csv("url_list_imo.csv")
url_list_ioc <- read.csv("url_list_ioc.csv")
url_list_isa <- read.csv("url_list_isa.csv")
url_list_unep <- read.csv("url_list_unep.csv")


url_list_total <- rbind(url_list_cbd, url_list_fao, url_list_imo, url_list_ioc, url_list_isa, url_list_unep)

nrow(url_list_total)

#################### IOC
ioc <- read.csv("out_ioc.csv")
DT <- as.data.table(ioc)
#text
x <- c()
for (i in igo){ x = c(x, igo = length(grep(paste("\\b",i,"\\b"), DT$text)))}
df_ioc1 <- data.frame(ioc1 = matrix(unlist(x), nrow=length(x), byrow=T))
#links
x <- c()
for (i in igo){ x = c(x, igo = length(grep(i, DT$link)))}
df_ioc2 <- data.frame(ioc2 = matrix(unlist(x), nrow=length(x), byrow=T))

df_ioc <- cbind(df_ioc1, df_ioc2)
df_ioc <- df_ioc %>% mutate(ioc = ioc1 + ioc2) %>% select(ioc)
row.names(df_ioc) <- igo


df_ioc_s <- df_ioc
paste0
i <- "ioc"


grep(paste("\\b",i,"\\b"), DT$text)

########################### ISA
isa <- read.csv("out_isa.csv")
DT <- as.data.table(isa)
# text
x <- c()
for (i in igo){ x = c(x, igo = length(grep(paste("\\b",i,"\\b"), DT$text)))}
df_isa1 <- data.frame(isa1 = matrix(unlist(x), nrow=length(x), byrow=T))
# link
x <- c()
for (i in igo){ x = c(x, igo = length(grep(i, DT$link)))}
df_isa2 <- data.frame(isa2 = matrix(unlist(x), nrow=length(x), byrow=T))

df_isa <- cbind(df_isa1, df_isa2)
df_isa <- df_isa %>% mutate(isa = isa1 + isa2) %>% select(isa)
row.names(df_isa) <- igo


######################## UNEP
unep <- read.csv("out_unep.csv")
DT <- as.data.table(unep)
# text
x <- c()
for (i in igo){ x = c(x, igo = length(grep(paste("\\b",i,"\\b"), DT$text)))}
df_unep1 <- data.frame(unep1 = matrix(unlist(x), nrow=length(x), byrow=T))
# links
x <- c()
for (i in igo){ x = c(x, igo = length(grep(i, DT$link)))}
df_unep2 <- data.frame(unep2 = matrix(unlist(x), nrow=length(x), byrow=T))

df_unep <- cbind(df_unep1, df_unep2)
df_unep <- df_unep %>% mutate(unep = unep1 + unep2) %>% select(unep)
row.names(df_unep) <- igo



######################## cbd
cbd <- read.csv("out_cbd.csv")
DT <- as.data.table(cbd)
# text
x <- c()
for (i in igo){ x = c(x, igo = length(grep(paste("\\b",i,"\\b"), DT$text)))}
df_cbd1 <- data.frame(cbd1 = matrix(unlist(x), nrow=length(x), byrow=T))
# links
x <- c()
for (i in igo){ x = c(x, igo = length(grep(i, DT$link)))}
df_cbd2 <- data.frame(cbd2 = matrix(unlist(x), nrow=length(x), byrow=T))

df_cbd <- cbind(df_cbd1, df_cbd2)
df_cbd <- df_cbd %>% mutate(cbd = cbd1 + cbd2) %>% select(cbd)
row.names(df_cbd) <- igo





######################## imo
imo <- read.csv("out_imo.csv")
DT <- as.data.table(imo)
# text
x <- c()
for (i in igo){ x = c(x, igo = length(grep(paste("\\b",i,"\\b"), DT$text)))}
df_imo1 <- data.frame(imo1 = matrix(unlist(x), nrow=length(x), byrow=T))
# links
x <- c()
for (i in igo){ x = c(x, igo = length(grep(i, DT$link)))}
df_imo2 <- data.frame(imo2 = matrix(unlist(x), nrow=length(x), byrow=T))

df_imo <- cbind(df_imo1, df_imo2)
df_imo <- df_imo %>% mutate(imo = imo1 + imo2) %>% select(imo)
row.names(df_imo) <- igo




######################## fao
fao <- read.csv("out_fao.csv")
DT <- as.data.table(fao)
# text
x <- c()
for (i in igo){ x = c(x, igo = length(grep(paste("\\b",i,"\\b"), DT$text)))}
df_fao1 <- data.frame(fao1 = matrix(unlist(x), nrow=length(x), byrow=T))
# links
x <- c()
for (i in igo){ x = c(x, igo = length(grep(i, DT$link)))}
df_fao2 <- data.frame(fao2 = matrix(unlist(x), nrow=length(x), byrow=T))

df_fao <- cbind(df_fao1, df_fao2)
df_fao <- df_fao %>% mutate(fao = fao1 + fao2) %>% select(fao)
row.names(df_fao) <- igo




inc_net <- cbind(df_cbd, df_fao, df_imo, df_ioc, df_isa, df_unep)
write.csv(inc_net, "inc_net.csv")


### delete self-references
inc_net[sapply(colnames(inc_net), `==`, rownames(inc_net))] <- 0



## create adjacency matrix with only IOs that are in the sample

## for a first graph with only core IOs
ad_net <- inc_net %>% subset(rownames(inc_net) %in% io) %>% as.matrix.data.frame() 
  
ad_net <- graph_from_adjacency_matrix(ad_net, weighted = TRUE)

## unfortunately direction is oppposite. therefore -> edgelist -> back

weights <- E(ad_net)$weight


### first create an edgelist 
el <- as_edgelist(ad_net )
## change direction
el <- el %>% as.data.frame %>% plyr::rename(c("V1" = "V2", "V2" = "V1")) %>% select(V1, V2)
#el$weight <- E(ad_net)$weight


## back to matrix
el <- as.matrix(el)
## to make an incident matrix a graph that is not bipartite
ad_net <- graph_from_edgelist(el)

E(ad_net)$weight <- weights

ad_net
V(ad_net)$name

Isolated = which(degree(ad_net)==0)
ad_net2 = delete.vertices(ad_net, Isolated)

V(ad_net2)$degree <- degree(ad_net2)
V(ad_net2)$name <- str_to_upper(V(ad_net2)$name)

png("ad_net.png", width = 2100, height = 2100, res = 150, units = "px")
set.seed(12345)
plot(ad_net2,
     main = "Core Marine Biodiversity Regime Complex IOs",
     layout = layout_with_dh(ad_net2),
     #vertex.size = V(fc)$type*10,
     vertex.size = V(ad_net2)$degree,
      edge.width = E(ad_net2)$weight / 5,
     edge.curved = 0.3, 
     edge.arrow.size = 3,
     sub = "By reference to each other on their homepages"
)
dev.off()



#### 
net <- graph_from_incidence_matrix(inc_net, weighted = TRUE)

weight <- E(net)$weight

### first create an edgelist 
el <- as_edgelist(net)
## change direction
el <- el %>% as.data.frame %>% plyr::rename(c("V1" = "V2", "V2" = "V1")) %>% select(V1, V2)
## back to matrix
el <- as.matrix(el)
## to make an incident matrix a graph that is not bipartite
net <- graph_from_edgelist(el)

## color direction of graphs
E(net)$dir <- which_mutual(net)
E(net)$dir
E(net)$dir <- as.factor(E(net)$dir)
E(net)$dir
col <- c("grey", "indianred1")
E(net)$dircol <- col[E(net)$dir]
E(net)$dircol


## delete isolates
Isolated = which(degree(net)==0)
net2 = delete.vertices(net, Isolated)


V(net2)$degree <- degree(net2, mode =  "in")
E(net2)$weight <- weight
V(net2)$name <- str_to_upper(V(net2)$name)





png("net.png", width = 2100, height = 2100, res = 150, units = "px")
set.seed(12345)
plot(net2,
     main = "All Marine Biodiversity Regime Complex IOs",
     layout = layout_with_dh(net2),
     #vertex.size = V(fc)$type*10,
     vertex.size = V(net2)$degree*3,
     edge.width = E(net2)$weight / 5,
     edge.color = E(net2)$dircol,
     sub = "By reference on the homepages of core IOs"
)
dev.off()


#### communities

com_net2 <- walktrap.community(net2)

png("com_net.png", width = 2100, height = 2100, res = 150, units = "px")
set.seed(1)
plot(com_net2, net2, 
     layout = layout_nicely(net2),
     #vertex.size = V(fc)$type*10,
     vertex.size = 5,
     # edge.width = E(auth_net1)$Freq/10,
     edge.color = "grey",
     edge.arrow.size = 0.2)
dev.off()
