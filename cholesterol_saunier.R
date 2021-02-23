"Le premier [exercice] a pour but de faire une analyse de
visualisation avec R pour présenter la problématique générale"

"
Readme sur le dataset :

A study tested whether cholesterol was reduced after using a certain brand of margarine as part of a low fat, low cholesterol diet.
The subjects consumed on average 2.31g of the active ingredient, stanol easter, a day. This data set contains information on 18 people
using margarine to reduce cholesterol over three time points.
"


#charger les données du csv dans une variable 'cholcsv'
cholcsv = read.csv("./data/Cholesterol_R.csv", header=TRUE, fileEncoding = 'UTF-8-BOM')


#avant de passer à la suite, il est iportant d'explorer un peu le CSV
#l'explorateur de variable de rstudio est bien pour cela.

#récuperer le header du fichier dans une variable 'header'
header = colnames(cholcsv)
header

#summary donne des stats rapides sur les colonnes
#la première colonne 'id' est exclue des stats (pas de sens de faire des stats sur un id autoincrémenté)
summary(cholcsv[-1])


"
Deux types de margarine sont dans le dataset.
il faut faire 3 jeux de data :
  - Un pour le type A
  - Un pour le type B
  - Un avec les deux types mélangés

Pour voir si on peut observer des différences
"

typeA = cholcsv[cholcsv$Margarine=="A",]
typeB = cholcsv[cholcsv$Margarine=="B",]

#passer les données en format "Tall" pour plotter
d = melt(cholcsv, id.vars="ID")


ggplot(data=cholcsv,x=x1, color=Margarine)
