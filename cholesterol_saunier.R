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
melted.all = melt(cholcsv[-5], id.vars="ID")
melted.typeA = melt(typeA[-5], id.vars="ID")
melted.typeB = melt(typeB[-5], id.vars="ID")

# Création des plots. Pour ce faire, on utilise les données sous format 'tall'
ggplot(melted.all, aes(ID,value, col=variable)) + 
  geom_point()
#   +stat_smooth()

ggplot(melted.typeA, aes(ID,value, col=variable)) + 
  geom_point()


ggplot(melted.typeB, aes(ID,value, col=variable)) + 
  geom_point()


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
