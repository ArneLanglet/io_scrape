library(igraph)

igo <-       str_to_lower(c("NEAFC", "ISA", 
                            "HELCOM", "CPPS", "NAFO",
                            "NPFC","OSPAR", "SPREP", "WCPFC", "AALCO",
                            "ICES", "Commonwealth", "Iccat", "SPC", "IPBES", "IATTC", "Medfund", "GCF", "SEAFO",
                            "Pacific Island Forum", "SICA", "WTO", "Nauru Agreement", "ILO", "IWC", "ATS",
                            "Benguela", "PEMSEA", "IPCC", "CCAMLR", "APFIC",
                            "GLFC", "IOTC", "IPHC", "NASCO", "PSC",
                            "SEAFDEC", "NACA", "PICES", "IAEA", "WMO", "world bank"))



#################### IOC
ioc <- read.csv("out_ioc.csv")
DT <- as.data.table(ioc)
#text
x <- c()
for (i in igo){ x = c(x, igo = length(grep(i, DT$text)))}
df_ioc1 <- data.frame(ioc1 = matrix(unlist(x), nrow=length(x), byrow=T))
#links
x <- c()
for (i in igo){ x = c(x, igo = length(grep(i, DT$link)))}
df_ioc2 <- data.frame(ioc2 = matrix(unlist(x), nrow=length(x), byrow=T))

df_ioc <- cbind(df_ioc1, df_ioc2)
df_ioc <- df_ioc %>% mutate(ioc = ioc1 + ioc2) %>% select(ioc)
row.names(df_ioc) <- igo


########################### ISA
isa <- read.csv("out_isa.csv")
DT <- as.data.table(isa)
# text
x <- c()
for (i in igo){ x = c(x, igo = length(grep(i, DT$text)))}
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
for (i in igo){ x = c(x, igo = length(grep(i, DT$text)))}
df_unep1 <- data.frame(unep1 = matrix(unlist(x), nrow=length(x), byrow=T))
# links
x <- c()
for (i in igo){ x = c(x, igo = length(grep(i, DT$link)))}
df_unep2 <- data.frame(unep2 = matrix(unlist(x), nrow=length(x), byrow=T))

df_unep <- cbind(df_unep1, df_unep2)
df_unep <- df_unep %>% mutate(unep = unep1 + unep2) %>% select(unep)
row.names(df_unep) <- igo


inc_net <- cbind(df_ioc, df_isa, df_unep)

net <- graph_from_incidence_matrix(inc_net)

Isolated = which(degree(net)==0)
net2 = delete.vertices(net, Isolated)

plot(net2)
