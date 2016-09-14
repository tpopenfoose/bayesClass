library(R2jags)

setwd("U:\\Courses\\Workshops\\DOD 2016\\Examples for Workshop\\SBP Example")


##############################################################
#### Create Initial Values as a funtion       ################
##############################################################


jags.inits<-list(list("mu"=50,"sd"=20),list("mu"=100,"sd"=3))


##############################################################
#### Specify the parameters to be monitored   ################
##############################################################

jags.params<-c("mu","sd","tau")

##############################################################
#### Save and display MCMC results            ################
##############################################################

jagsfit<-jags("sbp.data.txt",jags.inits,jags.params,model.file="sbp.bugs.txt",n.chains=2,n.iter=10000,n.burnin=1000)
jagsfit

jagsfit.mcmc<-as.mcmc(jagsfit)
##############################################################
#### Plots of the MCMC Results                ################
##############################################################

plot(jagsfit.mcmc)
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
