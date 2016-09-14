############################################
#    Demonstrate Metropolis                #
#    Algorithm  Using the Beta Dist        #
############################################

alpha<-15
beta<-15
y<-7
n<-24


x<-seq(0,1,length=1000)  #these are the theta values.

g<-function(theta) theta^(alpha-1+y)*(1-theta)^(n-y+beta-1)

#Plot g(x)   where the x values are the possible theta values.
curve(g(x),0,1,lwd=2,col="green")


met<-function(iters){
   old<-NULL
   count<-0
   old[1]<-1
   for(i in 2:iters){
      old[i]<-old[i-1]
      cand<-rbeta(1,old[i-1],old[i-1])  #can use Metropolis-Hastings for asymetric dist
      r<-g(cand)/g(old[i-1])
      if(runif(1,0,1)<r){
          old[i]<-cand
          count<-count+1
      }
   }
return(list(old=old,count=count,accept.rate=count/iters))
}

#Now use Metroplis function to get estimate of f(x) from g(x)
metout<-met(10000)

#####################################
#Plotting the Metropolis Sample
#####################################

#Plot Metropolis estimate of f(x)
plot(density(metout$old),col="blue")

#####################################
#Plotting the True Posterior Density
#####################################

p<-function(theta) dbeta(theta,alpha+y,n-y+beta)

#Plot p(x)  where the x are the possible theta values.
curve(p(x),0,1,add=T,lwd=2)

#####################################
#Plotting the non normalized posterior
#####################################

#Plot g(x)   where the x values are the possible theta values.
curve(g(x),0,1,add=T,lwd=2,col="green") #add g(x) to the same plot

legend(0.65,4,c("Beta(22,39)","Original","Metropolis"),col=c("black","green","blue"),lty=c(1,1,1),lwd=c(2,2,1),bty="n")




#####################################
#Plotting the prior
#####################################

a<-15
b<-15

pr<-function(theta) dbeta(theta,a,b)

lines(x,pr(x),lwd=2, col="light gray")

legend(0.65,4,c("Beta(22,39)","Original","Metropolis","Prior Beta(15,15)"),col=c("black","green","blue","light gray"),lty=c(1,1,1),lwd=c(2,2,1),bty="n")






