teams <- "ANA=Anaheim Angels
ARI=Diamondbacks
ATL=Braves
BAL=Orioles 
BOR=Red Sox
CHC=Cubs
CWS=White Sox
CIN=Reds
CLE=Indians
COL=Rockies
DET=Tigers
FLA=Marlins
HOU=Astros
KC=Royals
LAA=Angels
LAD=Dodgers
MIA= Marlins
MIL=Brewers
MIN=Twins
YM=Mets
NYY=Yankees
OAK=Athletics
PHI=Phillies
PIT=Pirates
SD=Padres
SEA=Mariners
SF=Giants
STL=Cardinals
TB==Devil Rays
TEX=Rangers
TOR=Blue Jays
WSH=Nationals"
teams <- strsplit(teams,"\n")
teams <- strsplit(teams[[1]], "=")
abvlist <- list()
teamlist <- list()
for(i in 1:length(teams)){
  abv <- teams[[i]][1]
  abvlist <- append(abv, abvlist)
  fullname <- teams[[i]][2]
  teamlist <- append(fullname, teamlist)
}

for(i in 1:nrow(MLB)){
  if(is.element(MLB[i, "Team"], teamlist)){
    MLB[i, "Team"] <- abvlist[which(MLB[i, "Team"] == teamlist)]
  }
}


MLB <- 

graphic <- merge(MLB, new, by = "Team")

library(shiny)
print(graphic)
