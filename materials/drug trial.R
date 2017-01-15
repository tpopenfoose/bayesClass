library(R2jags)

setwd("U:\\Courses\\Workshops\\DOD 2016\\Examples for Workshop\\SBP Example")


##############################################################
#### Create Initial Values as a funtion       ################
##############################################################


jags.inits<-list(list("propA"=.3,"propB"=.1),list("propA"=.05,"propB"=.95))


##############################################################
#### Specify the parameters to be monitored   ################
##############################################################

jags.params<-c("propA","propB","rrBA")

##############################################################
#### Another way to define the data           ################
##############################################################

dat<-list(numA=100,numB=100,drugAbenefit=60,drugBbenefit=75)

##############################################################
#### Save and display MCMC results            ################
##############################################################
jagsfit<-jags(data = dat,
              jags.inits,
              jags.params,
              model.file = "materials/drugtrial.bugs.txt",
              n.chains = 2,
              n.iter = 10000,
              n.burnin = 1000,
              n.thin = 1)
jagsfit

jagsfit.mcmc<-as.mcmc(jagsfit)
##############################################################
#### Plots of the MCMC Results                ################
##############################################################
library(mcmcplots)
plot(jagsfit.mcmc)
caterplot(jagsfit.mcmc)
R2jags::traceplot(jagsfit.mcmc)     #need to click on the output window to cycle through the plots


raftery.diag(jagsfit.mcmc)
geweke.diag(jagsfit.mcmc)
gelman.diag(jagsfit.mcmc)
gelman.plot(jagsfit.mcmc)
heidel.diag(jagsfit.mcmc)
autocorr.plot(jagsfit.mcmc)
effectiveSize(jagsfit.mcmc)



jagsfit<-update(jagsfit,10000)
jagsfit
