library(R2jags)

setwd("G:\\DOD 2016\\Examples for Workshop\\SBP Example")


##############################################################
#### Create Initial Values as a funtion       ################
##############################################################

#inits if not indexing
#jags.inits<-list(list("b0"=50,"b1"=20,"b2"=1,"vari"=2),list("b0"=1,"b1"=300,"b2"=50,"vari"=100))

#inits if using indexing
#jags.inits<-list(list("b0"=50,"b1"=20,"b2"=c(1,NA),"vari"=2),list("b0"=1,"b1"=300,"b2"=c(50,NA),"vari"=100))


##############################################################
#### Specify the parameters to be monitored   ################
##############################################################

jags.params<-c("b0","b1","b2","vari","prec")

##############################################################
#### Another way to define the data           ################
##############################################################
#data if not indexing
#dat<-list(y=c(0.27,0.14,0.29,0.30,0.44,0.35,0.25,0.65,0.46,0.60), x1=c(79.68,89.49,69.99,66.97,44.34,44.44,79.98,11.11,31.03,29.82),x2=c(0,0,0,0,1,1,0,1,1,1))

#data if using indexing
#dat<-list(y=c(0.27,0.14,0.29,0.30,0.44,0.35,0.25,0.65,0.46,0.60), x1=c(79.68,89.49,69.99,66.97,44.34,44.44,79.98,11.11,31.03,29.82),x2=c(1,1,1,1,2,2,1,2,2,2))

##############################################################
#### Save and display MCMC results            ################
##############################################################
#bugs file to use if not indexting
#bugs.file<-"smoking2.bugs.txt"

#bugs file if indexing
#bugs.file<-"smoking3.bugs.txt"

jagsfit<-jags(data=dat,jags.inits,jags.params,model.file=bugs.file,n.chains=2,n.iter=10000,n.burnin=1000,n.thin=1)
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
