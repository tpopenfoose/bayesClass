library(R2jags)

setwd("U:\\Courses\\Workshops\\DOD 2016\\Examples for Workshop\\SBP Example")


##############################################################
#### Create Initial Values as a funtion       ################
##############################################################


jags.inits<-list(list("mu"=c(0,0),"prec"=c(0.001,0.001)),list("mu"=c(0,0),"prec"=c(0.001,0.001)))


##############################################################
#### Specify the parameters to be monitored   ################
##############################################################

jags.params<-c("mu","prec","diff.mu1.mu2","ratio.var1.var2")

##############################################################
#### Another way to define the data           ################
##############################################################


dat<-list(N1=19,N2=14,a.tmt=c(121,94,119,122,142,168,116,172,155,107,180,119,157,101,145,148,120,147,125),b.tmt=c(126,125,130,130,122,118,118,111,123,126,127,111,112,121))



##############################################################
#### Save and display MCMC results            ################
##############################################################
jagsfit<-jags(data=dat,jags.inits,jags.params,model.file="sbp.2means.bugs.txt",n.chains=2,n.iter=10000,n.burnin=1000,n.thin=1)
jagsfit

jagsfit$model

jagsfit.mcmc<-as.mcmc(jagsfit)
##############################################################
#### Plots of the MCMC Results                ################
##############################################################
library(mcmcplots)
plot(jagsfit.mcmc)
    
raftery.diag(jagsfit.mcmc)
geweke.diag(jagsfit.mcmc)
gelman.diag(jagsfit.mcmc)
gelman.plot(jagsfit.mcmc)
heidel.diag(jagsfit.mcmc)
autocorr.plot(jagsfit.mcmc)
effectiveSize(jagsfit.mcmc)



#jagsfit<-update(jagsfit,10000)  #only need if diagnostics require
jagsfit


##############################################################
#### Compute Bayes P-value for one sided test ################
##############################################################

#After checking for model convergence we may want to computed areas from the posterior distribution
#The null hypothesis for this example assumes rrBA is <= 1
head(jagsfit.mcmc[[1]])
#column 5 corresponds to the samples from rrBA.  
#To compute P(H0|data) we just count how many samples were <=1 and divide by the number of samples
bayes.pval<-sum(ifelse(jagsfit.mcmc[[1]][,2]<=0,1,0))/9000  #could combine the two chains and use 18000
bayes.pval


plot(density(jagsfit.mcmc[[1]][,2]))

