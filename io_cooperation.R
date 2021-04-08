library(igraph)

igo <-       str_to_lower(c("NEAFC", "ISA", 
                            "HELCOM", "CPPS", "NAFO",
                            "NPFC","OSPAR", "SPREP", "WCPFC", "AALCO",
                            "ICES", "Commonwealth", "Iccat", "SPC", "IPBES", "IATTC", "Medfund", "GCF", "SEAFO",
                            "Pacific Island Forum", "SICA", "WTO", "Nauru Agreement", "ILO", "IWC", "ATS",
                            "Benguela", "PEMSEA", "IPCC", "CCAMLR", "APFIC",
                            "GLFC", "IOTC", "IPHC", "NASCO", "PSC",
                            "SEAFDEC", "NACA", "PICES", "IAEA", "WMO", "world bank"))

ioc <- read.csv("out_ioc.csv")
DT <- as.data.table(ioc)

x <- c()
ioc$text[1]
for (i in igo){ x = c(x, igo = length(grep(i, DT$text)))}

df_ioc <- data.frame(ioc = matrix(unlist(x), nrow=length(x), byrow=T))

row.names(df_ioc) <- igo

net_ioc <- graph_from_incidence_matrix(df_ioc)

plot(net_ioc)

isa <- read.csv("out_isa.csv")
DT <- as.data.table(isa)


x <- c()

for (i in igo){ x = c(x, igo = length(grep(i, DT$link)))}

df <- data.frame(isa = matrix(unlist(x), nrow=length(x), byrow=T))

row.names(df) <- igo

net <- graph_from_incidence_matrix(df)

plot(net)



