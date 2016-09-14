library(R2jags)

setwd("U:\\Courses\\Workshops\\DOD 2016\\Examples for Workshop\\SBP Example")

##############################################################
#### Default settings for the JAGS function   ################
##############################################################

#jags(data, inits, parameters.to.save, model.file="model.bug",
#n.chains=3, n.iter=2000, n.burnin=floor(n.iter/2),
#n.thin=max(1, floor((n.iter - n.burnin) / 1000)),
#DIC=TRUE, working.directory=NULL, jags.seed = 123,
#refresh = n.iter/50, progress.bar = "text", digits=5,
#RNGname = c("Wichmann-Hill", "Marsaglia-Multicarry",
#"Super-Duper", "Mersenne-Twister"),
#jags.module = c("glm","dic")
#)

##############################################################
#### Create Initial Values as a funtion       ################
##############################################################


jags.inits<-function(){list("mu"=50,sd=20}


##############################################################
#### Specify the parameters to be monitored   ################
##############################################################

jags.params<-c("disconnect.prob")

##############################################################
#### Save and display MCMC results            ################
##############################################################

jagsfit<-jags("data.bugs.txt",jags.inits,jags.params,model.file="model.bugs.txt",n.chains=3,n.iter=10000,n.burnin=1000)
jagsfit

##############################################################
#### Plots of the MCMC Results                ################
##############################################################

plot(jagsfit)
traceplot(jagsfit)     #need to click on the output window to cycle through the plots