setwd('C:/Users/Pau/Documents/Universitat/PE/B7')
Dades <- read.table('result.txt',header=TRUE)

BlandAltman <- function(y1,y2,tit){
  Bmean <- (y1+y2)/2
  Bdif <- y2-y1
  ymax <- max(abs(Bdif))
  plot(Bmean ,Bdif ,ylim=c(-ymax,ymax),
       xlab="Mitjanes",
       ylab="Diferències",
       main=tit,pch=19)
  abline(h=0,lty=2)
  mtext("Y2 més gran",2,line= 0.5,
        at=1.1*ymax,adj=1,cex=0.7)
  mtext("Y1 més gran",2,line= 0.5,
        at=-1.1*ymax,adj=1,cex=0.7)
}

par(mfrow=c(1,1))

Y1 <- Dades$O0
Y2 <- Dades$O2

#Anexe
BlandAltman(Y1,Y2,"Diferencies vs. Mitjanes")

Y1 <- log(Dades$O0)
Y2 <- log(Dades$O2)


plot(Y1)
plot(Y2)

#Fixed

Dades <- subset(Dades, O0 < 1050)

Y1 <- Dades$O0
Y2 <- Dades$O2

Dades$Dif = Dades$O0 - Dades$O2

aux = paired(Y1,Y2)
plot(aux, type='BA')

boxplot(Dades$Diflog)

#Efecte additiu
BlandAltman(Dades$O0,Dades$O2,"Diferencies vs. Mitjanes")


#Normalitat
qqnorm(Y1-Y2)
qqline(Y1-Y2)
hist(Dades$Dif)


#B5
t.test.paired(aux)
qt(0.975, 659)
#Estadistic = 11.441
#p-valor < 2.2x10^(-16)
#punt critic = 1.96357
#IC95% = (26.75376, 37.84018)
#Podem rebujtar la hipotesi nul·la (obiament)

#B6

#Premises
Z <- log(Dades$c..) #Explicar logs
Y1 <- log(Dades$O0)
mod = lm(Z~Y1)
par(mfrow=c(1,1)) 
plot(Z~Y1)
abline(mod)
par(mfrow=c(2,2))
plot(mod,2:1)
hist(rstandard(mod))
plot(rstandard(mod), type='l')

#Estimacio dels parametres
summary(mod)
