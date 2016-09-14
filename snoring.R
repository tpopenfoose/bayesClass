library(R2jags)

setwd("G:\\DOD 2016\\Examples for Workshop\\SBP Example")


##############################################################
#### Create Initial Values as a funtion       ################
##############################################################


jags.inits<-list(list("alpha"=-0.5,"b.snore"=c(NA,10,20,30)),list("alpha"=.5,"b.snore"=c(NA,1,100,50)))

##############################################################
#### Specify the parameters to be monitored   ################
##############################################################

jags.params<-c("alpha","b.snore","or.snore")

##############################################################
#### Another way to define the data           ################
##############################################################

#This is a large data set so 
#we will read this in from the data file
#labeled "snoring.data.txt"
dat<-read.table("snoring.data.txt")

##############################################################
#### Save and display MCMC results            ################
##############################################################

bugs.file<-"snoring.bugs.txt"



jagsfit<-jags("snoring.data.txt",jags.inits,jags.params,model.file=bugs.file,n.chains=2,n.iter=10000,n.burnin=1000,n.thin=1)
jagsfit

jagsfit.mcmc<-as.mcmc(jagsfit)
##############################################################
#### Plots of the MCMC Results                ################
##############################################################
head(jagsfit.mcmc)
plot(jagsfit.mcmc[,1:3])
library(mcmcplots)
caterplot(jagsfit.mcmc)
traceplot(jagsfit.mcmc)     #need to click on the output window to cycle through the plots


raftery.diag(jagsfit.mcmc)
geweke.diag(jagsfit.mcmc)
gelman.diag(jagsfit.mcmc)
gelman.plot(jagsfit.mcmc)
heidel.diag(jagsfit.mcmc)
autocorr.plot(jagsfit.mcmc)
effectiveSize(jagsfit.mcmc)



jagsfit<-update(jagsfit,10000)
jagsfit
