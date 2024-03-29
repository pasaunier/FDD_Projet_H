"Le premier [exercice] a pour but de faire une analyse de
visualisation avec R pour présenter la problématique générale"

"
Readme sur le dataset :

A study tested whether cholesterol was reduced after using a certain brand of margarine as part of a low fat, low cholesterol diet.
The subjects consumed on average 2.31g of the active ingredient, stanol easter, a day. This data set contains information on 18 people
using margarine to reduce cholesterol over three time points.
"
# installation des packages si besoin:
# install.packages("readr")
# install.packages("reshape2")
# install.packages("ggplot2")

#import des packages 
library(readr)      #lecteur de csv
library(reshape2)   #fonction melt 
library(ggplot2)    #plotting


#charger les données du csv dans une variable 'cholcsv'
cholcsv = read.csv("./data/Cholesterol_R.csv", header=TRUE, fileEncoding = 'UTF-8-BOM')
#si le path du csv n'est pas valide, utiliser file.choose()
# cholcsvfile = read.csv(file.choose(), header=TRUE, fileEncoding = 'UTF-8-BOM')


#avant de passer à la suite, il est important d'explorer un peu le CSV
#l'explorateur de variable de rstudio est bien pour cela.

#récupérer le header du fichier dans une variable 'header'
header = colnames(cholcsv)
header

#summary donne des stats rapides sur les colonnes
#la première colonne 'id' est exclue des stats (pas de sens de faire des stats sur un id autoincrémenté)
summary(cholcsv[-1])

#utilisation de la fonction table pour voir les catégories de la colonne 'Margarine'
table(cholcsv$Margarine)

"
Il y a deux types de margarine dans le dataset : A et B
il faut faire 3 jeux de data :
  - Un pour le type A
  - Un pour le type B
  - Un avec les deux types mélangés

Pour voir si on peut observer des différences
"

typeA = cholcsv[cholcsv$Margarine=="A",]
typeB = cholcsv[cholcsv$Margarine=="B",]

#passer les données en format "Tall" pour plotter
melted.all = melt(cholcsv[-5], id.vars="ID")
melted.typeA = melt(typeA[-5], id.vars="ID")
melted.typeB = melt(typeB[-5], id.vars="ID")


# Définition d'une palette custom pour les plots
mypalette <- c("#9593FA", "#DC77F6", "#FF65C8")

shapevector = c(3,4)

# Création des plots. Pour ce faire, on utilise les données sous format 'tall'
ggplot(melted.all, aes(ID,value, col=variable))+ 
  geom_point(shape=3) + 
  scale_colour_manual(values=mypalette) +
  ggtitle("Variation du taux de Cholestérol par patient, tous types de margarine confondu")


#   +stat_smooth()

ggplot(melted.typeA, aes(ID,value, col=variable)) + 
  geom_point(shape=3) + 
  scale_colour_manual(values=mypalette) +
  ggtitle("Variation du taux de Cholestérol par patient, margarine de type A")


ggplot(melted.typeB, aes(ID,value, col=variable)) + 
  geom_point(shape=3) + 
  scale_colour_manual(values=mypalette) +
  ggtitle("Variation du taux de Cholestérol par patient, margarine de type B")


# Faire une ANOVA pour chercher différence type A et type B ?
# Faire une petite comparaison aux amélioration moyennes attendues avec statines ?


# ********************************************
# Pour tous types de margarine confondus :
# Amélioration moyenne en 4 semaines :
mean(cholcsv$Before - cholcsv$After4weeks)

# écart-type d'amélioration moyenne en 4 semaines:
sd(cholcsv$Before - cholcsv$After4weeks)

# Amélioration moyenne en 8 semaines :
mean(cholcsv$Before - cholcsv$After8weeks)

# écart-type :
sd(cholcsv$Before - cholcsv$After8weeks)
# ********************************************


# ********************************************
# Pour Margarine de type A :
# Amélioration moyenne en 4 semaines :
mean(typeA$Before - typeA$After4weeks)

# écart-type d'amélioration moyenne en 4 semaines:
sd(typeA$Before - typeA$After4weeks)

# Amélioration moyenne en 8 semaines :
mean(typeA$Before - typeA$After8weeks)

# écart-type :
sd(typeA$Before - typeA$After8weeks)
# ********************************************


# ********************************************
# Pour Margarine de type B :
# Amélioration moyenne en 4 semaines :
mean(typeB$Before - typeB$After4weeks)

# écart-type d'amélioration moyenne en 4 semaines:
sd(typeB$Before - typeB$After4weeks)

# Amélioration moyenne en 8 semaines :
mean(typeB$Before - typeB$After8weeks)

# écart-type :
sd(typeB$Before - typeB$After8weeks)
# ********************************************
