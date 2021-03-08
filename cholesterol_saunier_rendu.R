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

#summary donne des stats rapides sur les colonnes
#la première colonne 'id' est exclue des stats (pas de sens de faire des stats sur un id autoincrémenté)
summary(cholcsv[-1])

#utilisation de la fonction table pour voir les catégories de la colonne 'Margarine'
table(cholcsv$Margarine)

# Feature engineering :
#ajout de deux colonnes pour voir le changement de cholestérolémie:
# change4w : After4weeks - Before
# change8w : After8weeks - Before

cholcsv$change4w = with(cholcsv, After4weeks - Before)
cholcsv$change8w = with(cholcsv, After8weeks - Before)


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

mypalette <- c("#331E38", "#662A51", "#FF65C8")

# Première visualisation : diagramme en barres du changement de cholestérolémie pour chaque patient

# Passage des données en format "tall":
# myvars = c("ID", "change4w", "change8w")
# melted.all = melt(cholcsv[myvars], id.vars="ID")
# 
# ggplot(melted.all, aes(ID,value, col=variable)) + 
#   geom_bar(position="dodge", stat="identity")


ggplot(mapping = aes(x, y)) +
  geom_bar(data = data.frame(x = cholcsv$ID, y = cholcsv$change8w),
           width = 0.9,
           stat = 'identity',
           fill = mypalette[1])+
  
  geom_bar(data = data.frame(x = cholcsv$ID, y = cholcsv$change4w),
           width = 0.5, 
           stat = 'identity',
           fill = mypalette[2]) +
  
  theme_classic()+
  xlab("Identifiant de patient")+
  ylab("Variation de la Cholestérolémie (mmol/L)")+ 
  scale_x_discrete(breaks = c(seq(1,18)),
                   labels=c(seq(1,18)), 
                   limits=c(seq(1,18)))+
  scale_y_reverse(expand = expansion(mult = c(0, .1)))+
  coord_flip()+ 
  ggtitle("Variation de la cholestérolémie après 4 et 8 semaines par patient.")+
  theme(axis.text.y = element_text(size = 10),
        axis.text.x = element_text(size = 10))


# bp = barplot(t(cholcsv[c("change4w", "change8w")]),
#         main="Evolution de la cholestérolémie par patient après 4 et 8 semaines",
#         ylab=" Variation de la Cholestérolémie (mmol/L)",
#         # border = "white",
#         # beside = TRUE,
#         las=1,
#         legend=rownames(data),
#         space=0.04)




boxplot(cholcsv$change4w, typeA$change4w, typeB$change4w,
        las=1,
        main="Variation de cholestérolémie à 8 semaines par type de margarine",
        varwidth = TRUE,
        ylab= "Variation de Cholestérolémie",
        names = c("Types A et B", "Type A", "Type B"),
        boxwex = 0.8,
        ylim=c(-1.1,0)+
        theme_classic()
)


boxplot(cholcsv$change8w, typeA$change8w, typeB$change8w,
        las = 1,
        main ="Variation de cholestérolémie à 8 semaines par type de margarine",
        varwidth = TRUE,
        ylab = "Variation de Cholestérolémie",
        names = c("Types A et B", "Type A", "Type B"),
        boxwex = 0.8,
        ylim = c(-1.1,0)+
        theme_classic()
        
        )



one.way = aov(change8w ~Margarine, data = cholcsv)
summary(one.way)

one.way = aov(change4w ~Margarine, data = cholcsv)
summary(one.way)

# Faire une ANOVA pour chercher différence type A et type B ?
# Faire une petite comparaison aux amélioration moyennes attendues avec statines ?


