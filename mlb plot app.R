setwd("C:/Users/tedhe/Onedrive/Documents/analytics")

library(ggplot2)
library(ggimage)

batting <- read.csv(file = 'Team Batting WAR 2018.csv', fill = T, stringsAsFactors = F, fileEncoding="UTF-8-BOM")
pitching <- read.csv(file = 'Team Pitching WAR 2018.csv', fill = T, stringsAsFactors = F, fileEncoding="UTF-8-BOM")


mlb <- merge(x = batting, y = pitching, by = 'Team')
mlb$TotalWAR <- mlb$WAR.x + mlb$WAR.y


prospects <- read.csv(file = 'fangraphs prospects.csv', fill = T, stringsAsFactors = F)
prospects <- prospects[5:nrow(prospects),]
farmrating <- aggregate(prospects$FV, list(Team = prospects$Team), sum)

MLB <- mlb

teams <- "ANA=Anaheim Angels
ARI=Diamondbacks
ATL=Braves
BAL=Orioles
BOS=Red Sox
CHC=Cubs
CHW=White Sox
CIN=Reds
CLE=Indians
COL=Rockies
DET=Tigers
MIA=Marlins
HOU=Astros
KCR=Royals
LAA=Angels
LAD=Dodgers
MIA= Marlins
MIL=Brewers
MIN=Twins
NYM=Mets
NYY=Yankees
OAK=Athletics
PHI=Phillies
PIT=Pirates
SDP=Padres
SEA=Mariners
SFG=Giants
STL=Cardinals
TBR=Rays
TEX=Rangers
TOR=Blue Jays
WSN=Nationals"
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


for(i in 1:length(MLB$Team)){
  if(!(is.element(MLB[i, "Team"], farmrating$Team))){
    nofarmdata <- data.frame(Team = MLB[i, "Team"], x = 0)
    farmrating <- rbind(nofarmdata, farmrating)
  }
}
print(farmrating)
graphic <- merge(MLB, farmrating, by = "Team")



##graph and shiny portion###
logoframe <- data.frame(Team = c(0), Logo = c(0))

logolist <- list('https://projects.fivethirtyeight.com/2018-mlb-predictions/images/LAA.png?v=d69bfd5d865068c592daeec642e916cb', 'https://projects.fivethirtyeight.com/2018-mlb-predictions/images/ARI.png?v=f472819cc49c2e111abb251dd1a1c97e', 
'https://projects.fivethirtyeight.com/2018-mlb-predictions/images/ATL.png?v=6bc66a3abb322d1440f5dd9fd2e0f446', 
'https://projects.fivethirtyeight.com/2018-mlb-predictions/images/CHC.png?v=08b17f154251aeafcadd61f9c98329ff', 
'https://projects.fivethirtyeight.com/2018-mlb-predictions/images/CIN.png?v=d8fe0488833ebb2825172c045a9394e8', 
'https://projects.fivethirtyeight.com/2018-mlb-predictions/images/CLE.png?v=3b4b6b70728260462e24056f5eb29fc8', 
'https://projects.fivethirtyeight.com/2018-mlb-predictions/images/COL.png?v=8d7b924b76d71b8a4addc2aee2cdfcc8', 
'https://projects.fivethirtyeight.com/2018-mlb-predictions/images/DET.png?v=6de3bf89fe440ef64df0fe742da0f440', 
'https://projects.fivethirtyeight.com/2018-mlb-predictions/images/HOU.png?v=c0d3ccbf73269339a8ef15b228fe5574',
'https://projects.fivethirtyeight.com/2018-mlb-predictions/images/TOR.png?v=70da0a292835c467cc52a2727f2ec8c0', 
'https://projects.fivethirtyeight.com/2018-mlb-predictions/images/OAK.png?v=f0a63e20a737a1d755c39eb6f08cffff',
'https://projects.fivethirtyeight.com/2018-mlb-predictions/images/MIL.png?v=41faa8b34b063ade7aea7965e5a2309d', 
'https://projects.fivethirtyeight.com/2018-mlb-predictions/images/STL.png?v=ca54a4ccff8a8f64e39a8b434aad5891', 
'https://projects.fivethirtyeight.com/2018-mlb-predictions/images/LAD.png?v=727d67dc0ed1ee2ca8d56d54e26ab5bd', 
'https://projects.fivethirtyeight.com/2018-mlb-predictions/images/SF.png?v=982fdece1db3218f796c3617ba2f64ed', 
'https://projects.fivethirtyeight.com/2018-mlb-predictions/images/SEA.png?v=afcb625a3fdd927776024fcffd2da75c', 
'https://projects.fivethirtyeight.com/2018-mlb-predictions/images/MIA.png?v=ac2e81dfd9998d1e4b0085768a00c8d3', 
'https://projects.fivethirtyeight.com/2018-mlb-predictions/images/NYM.png?v=9732d9703e675a5547b2529a786fc782', 
'https://projects.fivethirtyeight.com/2018-mlb-predictions/images/WSH.png?v=c7421be0f5ff04c0bf8ae23b16c86984', 
'https://projects.fivethirtyeight.com/2018-mlb-predictions/images/BAL.png?v=75d04fce4c006459fce78a4840b44c5d', 
'https://projects.fivethirtyeight.com/2018-mlb-predictions/images/SD.png?v=f85246a8511e3930358997c307347c6d', 
'https://projects.fivethirtyeight.com/2018-mlb-predictions/images/PHI.png?v=a65071707478aac4956f3f6d2cf853d1', 
'https://projects.fivethirtyeight.com/2018-mlb-predictions/images/PIT.png?v=ba5647e0d8e79a280190effce131c6cc', 
'https://projects.fivethirtyeight.com/2018-mlb-predictions/images/TEX.png?v=801b4dbcdf8d89095f86d2ef327dc0f5', 
'https://projects.fivethirtyeight.com/2018-mlb-predictions/images/TB.png?v=d2b850bb3d894daf174b919bf837ee5b', 
'https://projects.fivethirtyeight.com/2018-mlb-predictions/images/BOS.png?v=9f8639c4aff1eabad216244137df0ec7',
'https://projects.fivethirtyeight.com/2018-mlb-predictions/images/KC.png?v=05b045765fac9b816e6bd8f6d6fe8365', 
'https://projects.fivethirtyeight.com/2018-mlb-predictions/images/MIN.png?v=8c985d9efbe3617ee11a786dad96ad79', 
'https://projects.fivethirtyeight.com/2018-mlb-predictions/images/CHW.png?v=53a8327809a28c6d934ab363b5e10cb0', 
'https://projects.fivethirtyeight.com/2018-mlb-predictions/images/NYY.png?v=e608e2bce1be08dc1ba7f1a9c7210e69'
)

for(i in 1:length(logolist)){
  team <- strsplit(logolist[[i]][1], '.png', fixed = TRUE)
  team <- team[[1]][1]
  team <- strsplit(team, 'images/')
  team <- team[[1]][2]
  if(team == 'KC'){
    team <- 'KCR'
    
  }
  if(team == 'TB'){
    team <- 'TBR'
    
  }
  if(team == 'SD'){
    team <- 'SDP'
    
  }
  if(team == 'SF'){
    team <- 'SFG'
    
  }
  if(team == 'WSH'){
    team <- 'WSN'
    
  }
  logoframe[i, 'Team']<- team
  logoframe[i, 'Logo'] <- logolist[[i]][1]
}

graphic <- merge(graphic, logoframe, by = 'Team')

ggplot(data = graphic, mapping = aes(graphic$x, graphic$TotalWAR)) + 
  labs(title = "Farm Rating versus Current Rating") + 
  ylab(label = "TotalWAR") + xlab(label = "Farm Rating")  + 
  geom_image(aes(image=graphic$Logo), size=.05) + 
  geom_vline(xintercept = mean(graphic$x)) + geom_hline(yintercept = mean(graphic$TotalWAR))




