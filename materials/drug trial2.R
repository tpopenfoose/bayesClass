library(R2jags)
library(mcmcplots)

#setwd("U:\\Courses\\Workshops\\DOD 2016\\Examples for Workshop\\SBP Example")


##############################################################
#### Create Initial Values as a funtion       ################
##############################################################


jags.inits<-list(list("mu"=50,"sd"=20),list("mu"=100,"sd"=3))


##############################################################
#### Specify the parameters to be monitored   ################
##############################################################

jags.params<-c("mu","sd","tau","sbp19")

##############################################################
#### Another way to define the data           ################
##############################################################

dat<-list(N=19,sbp=c(121,94,119,122,142,168,116,172,155,107,180,119,157,
                     101,145,148,120,147,NA))

#############################################################
####  put the BUGS model in the code          ###############
#############################################################

cat('
   model
      {
  
  #likelihood
      for(i in 1:N)
       {
          sbp[i]~dnorm(mu,tau)  #note this uses precision not variance
       }
  
  #priors
  
       mu~dnorm(120,0.0001)        #diffuse prior on mean
       sd~dunif(0,500)               #diffuse prior on sd
       tau<-1/(sd*sd)		  #compute precision from sd
  #vari<-1/tau
  
  #missing data value
  
      sbp19~dnorm(mu,tau)
  
  }', 
  fill =TRUE,
  file = "spb.bugs.missing.txt")

##############################################################
#### Save and display MCMC results            ################
##############################################################
jagsfit<-jags(data=dat,
              inits = jags.inits,
              parameters.to.save=jags.params,
              model.file="spb.bugs.missing.txt",
              n.chains=2,
              n.iter=10000,
              n.burnin=1000,
              n.thin=1)
jagsfit

jagsfit.mcmc<-as.mcmc(jagsfit)
##############################################################
#### Plots of the MCMC Results                ################
##############################################################

plot(jagsfit.mcmc)
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
