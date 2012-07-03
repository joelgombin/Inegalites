library(foreign)
table1 <- read.dbf("/media/Data/Dropbox/Thèse/Données insee lasmas/enquête emploi 2009/indiv091.dbf")
table2 <- read.dbf("/media/Data/Dropbox/Thèse/Données insee lasmas/enquête emploi 2009/indiv092.dbf")
table3 <- read.dbf("/media/Data/Dropbox/Thèse/Données insee lasmas/enquête emploi 2009/indiv093.dbf")
library(dataframe)
EnqEmploi <- cbind(table1, table2, table3)
EnqEmploi09$ID <- paste(as.character(EnqEmploi09$ID), as.character(EnqEmploi09$NOI), as.character(EnqEmploi09$TRIM))
rm(table1,table2,table3)
gc()

ech <- EnqEmploi09[runif(10000, 1, dim(EnqEmploi09)[1]),]
ech <- transform(ech, Âge = as.integer(as.character(AG)), Sexe = factor(SEXE, labels=c("Homme", "Femme")))
EnqEmploi09 <- transform(EnqEmploi09, Âge = as.integer(as.character(AG)), Sexe = factor(SEXE, labels=c("Homme", "Femme")))
save(EnqEmploi09, file="/media/Data/Dropbox/Thèse/Données insee lasmas/enquête emploi 2009/Enquete Emploi 2009.Rdata")


library(ggplot2)
# qplot(as.integer(as.character(AG)), SALRED, data=ech, geom="smooth", facets= . ~ SEXE)
caption <- "Source : INSEE, Enquête Emploi 2009. \n Interpolation réalisée au moyen d'un modèle additif généralisé. \n Réalisation : Joël Gombin"
graphe <- ggplot(EnqEmploi09, aes(Âge, SALRED)) + geom_smooth() + facet_grid(. ~ Sexe) + ylab("Salaire mensuel net") + xlim(c(15,65)) + opts(title="Salaire mensuel net en fonction de l'âge pour les hommes et pour les femmes") +  geom_text(aes(x, y, label = caption), data = data.frame(x = 65, y = 500), hjust=1, vjust=1, size = 4)
save(graphe, file="/media/Data/Dropbox/Thèse/Données insee lasmas/enquête emploi 2009/graphe.Rdata") 
pdf("/media/Data/Dropbox/Thèse/Données insee lasmas/enquête emploi 2009/Graphique inégalités salariales.pdf", width=10, height=7)
print(graphe)
dev.off()
png("/media/Data/Dropbox/Thèse/Données insee lasmas/enquête emploi 2009/Graphique inégalités salariales.png", 2000, 1000, pointsize=20)
print(graphe)
dev.off()