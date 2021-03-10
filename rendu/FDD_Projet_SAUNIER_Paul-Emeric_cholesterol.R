# installation des packages si besoin:
## install.packages("readr")
## install.packages("reshape2")
## install.packages("ggplot2")

#import des packages 
library(readr)      #lecteur de csv
library(ggplot2)    #plotting


#charger les données du csv dans une variable 'cholcsv'
# cholcsv = read.csv("./data/Cholesterol_R.csv", header=TRUE, fileEncoding = 'UTF-8-BOM')

#si le path du csv n'est pas valide, utiliser file.choose()
cholcsv = read.csv(file.choose(), header=TRUE, fileEncoding = 'UTF-8-BOM')


#avant de passer à la suite, il est important d'explorer un peu le CSV
#l'explorateur de variable de rstudio est bien pour cela.

#summary donne des stats rapides sur les colonnes
#la première colonne 'id' est exclue des stats (pas de sens de faire des stats sur un id autoincrémenté)
summary(cholcsv[-1])

#utilisation de la fonction table pour voir les catégories de la colonne 'Margarine'
table(cholcsv$Margarine)

################################################################################
# Feature engineering :
#ajout de deux colonnes pour voir le changement de cholestérolémie:
# change4w : After4weeks - Before
# change8w : After8weeks - Before

cholcsv$change4w = with(cholcsv, After4weeks - Before)
cholcsv$change8w = with(cholcsv, After8weeks - Before)

################################################################################
# Première visualisation : 
# diagramme en barres du changement de cholestérolémie pour chaque patient

# couleurs:
mypalette = c("#331E38", "#662A51")

ggplot(mapping = aes(x, y)) +
  geom_bar(data = cholcsv, # Barres "dummy" pour forcer légende
           aes(ID, change8w, fill="dummy"),
           width = 0.9,
           stat = 'identity',
           color = "black",
           size=0.5) + 
  
  geom_bar(data = cholcsv,# Barres les plus longues pour le change8w
           aes(ID, change8w),
           width = 0.9,
           stat = 'identity',
           color = "black",
           fill = mypalette[1],
           size=0.5) + 
  
  geom_bar(data = cholcsv,# Barres les plus courtes pour le change4w
           aes(x = ID, y = change4w, fill='a'),
           width = 0.5, 
           stat = 'identity',
           fill = mypalette[2],
           color = "black",
           size=0.5) +
  
  scale_fill_manual(name = 'Durée de régime :',# Customisation légende: 
                    values =c(mypalette[2],mypalette[1]),
                    labels = c('4 semaines','8 semaines'),
                    limits = c('4 semaines','8 semaines')) +
  theme_classic()+
  xlab("Identifiant de patient") + # labels x et y
  ylab("Variation de la Cholestérolémie (mmol/L)") + 
  scale_x_discrete(breaks = factor(cholcsv$ID),  # scale axe x
                   labels= factor(cholcsv$ID), 
                   limits= factor(cholcsv$ID)) +
  
  scale_y_reverse(expand = expansion(mult = c(0, .1)))+ # reverse axe y (pour les valeurs négatives)
  coord_flip() +   # flip le graph
  
  ggtitle("Variation de la cholestérolémie après 4 et 8 semaines pour chaque patient.") +# tittle
  theme(axis.text.y = element_text(size = 10),  # font sizes
        axis.text.x = element_text(size = 10)) +
  
  theme(legend.position="bottom",
        legend.text=element_text(size=10),
        legend.title=element_text(size=11))
  
# le plot est trop grand pour r studio!
# l'export et le zoom marchent
################################################################################
# 2e et 3e visualisations : création des boxplots :

# Filtrer le dataset en fonction du type de margarine :
typeA = cholcsv[cholcsv$Margarine=="A",]
typeB = cholcsv[cholcsv$Margarine=="B",]



boxplot(cholcsv$change4w, typeA$change4w, typeB$change4w,
        las=1,
        main="Variation de cholestérolémie à 4 semaines en fonction du type de margarine",
        varwidth = TRUE,
        ylab= "Variation de Cholestérolémie (mmol/L)",
        names = c("Types A et B confondus", "Type A", "Type B"),
        ylim = c(-1,-0.2), #important de bien garder la même échelle
        boxwex = 0.7 +
        theme_classic()
)


boxplot(cholcsv$change8w, typeA$change8w, typeB$change8w,
        las = 1,
        main ="Variation de cholestérolémie à 8 semaines en fonction du type de margarine",
        varwidth = TRUE,
        ylab = "Variation de Cholestérolémie (mmol/L)",
        names = c("Types A et B confondus", "Type A", "Type B"),
        ylim = c(-1,-0.2),
        boxwex = 0.7+
        theme_classic()
        )



one.way = aov(change8w ~Margarine, data = cholcsv)
summary(one.way)

one.way = aov(change4w ~Margarine, data = cholcsv)
summary(one.way)

# Faire une petite comparaison aux amélioration moyennes attendues avec statines ?


