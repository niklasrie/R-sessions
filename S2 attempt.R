#R-session No 2

#Reading CSVs from Data Hub
oda0 = read.csv("https://github.com/devinit/digital-platform/user-data/oda.2000/csv/oda.2000.csv")
oda1 = read.csv("https://github.com/devinit/digital-platform/blob/master/user-data/oda.2001/csv/oda.2001.csv")
#Does not work for some reason, it only gives me 135 obs of 1 variable, is this the wrong path?

#Setting folder as working directory
WD <- "//dipr-dc01/home$/niklasr/Desktop/R/Sessions/2/Session 2 data"
setwd(WD)

#Reading CSVs from desktop
oda0 = read.csv("oda.2000.csv", na = "")
oda1 = read.csv("oda.2001.csv", na = "")
entity = read.csv("entity.csv", na = "")

#Appending the two dataframes
oda = rbind(oda0,oda1)

#Keeping only name and id coloumns in entity
entity = subset(entity, select = c(1,13))

#Renaming coloumns in entity file
names(entity)[names(entity) == "id"] = "id.from"

#Merging oda and entity
oda = merge(entity, oda, by=c("id.from"))

#Renaming and merging again for id.to
names(entity)[names(entity) == "id.from"] = "id.to"
oda = merge(entity, oda, by=c("id.to"))
names(oda)[names(oda) == "name.x"] = "name.to"
names(oda)[names(oda) == "name.y"] = "name.from"

#Writing the output onto another csv
write.csv(oda,"ODA_2000_2001.csv")

#What do you reckon, there must be a quicker way to e.g. merge entity with the oda file so as to give both id coloumns their respective names in one step
