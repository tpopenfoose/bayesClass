#############################################
#Means of bivtnormal
#############################################
mu.x<-921
mu.y<-5


#############################################
#variances and covariances of bivtnormal
#############################################
s.x<-100^2
s.y<-3^2
s.xy<-15^2


#############################################
#Plotting the contours of this bivtnormal
#############################################
library(mvtnorm)
x <- seq(610, 1227, by= 1)
y <- seq(0,10,length=length(x))

z<-array(0,dim=c(length(x),length(y)))
Sigma<- matrix(c(s.x,s.xy,s.xy, s.y), 2)

for (i in 1:length(x)){
      for (j in 1:length(y)){
        z[i,j]<-dmvnorm(x=c(x[i],y[j]),mean=c(mu.x,mu.y),sigma=Sigma)
      }
    }

contour(x,y,z,xlab="MPH", ylab="Radial Accuracy",main="F-35 Speed vs Accuracy")
abline(v=mu.x)
abline(h=mu.y)


#############################################
#Writing a simple Gibbs sampler
#############################################

mph<-0    #initial values
rad<-0    #initial values
B<-10000
pts<-matrix(0,ncol=2,nrow=B)
pts[1,]<-c(mph,rad)
for (i in 2:B) {
                  mph<-rnorm(1,mu.x+s.xy*solve(s.y)*(rad-mu.y),sqrt(s.x-s.xy*solve(s.y)*s.xy))
			rad<-rnorm(1,mu.y+s.xy*solve(s.x)*(mph-mu.x),sqrt(s.y-s.xy*solve(s.x)*s.xy))
			
                pts[i, ] <- c(mph, rad)
        }


#############################################
#plotting the samples points
#############################################


#############################################
#showing the random walk
#############################################

for(i in 2:1000){

    		points(pts[i-1,1],pts[i-1,2],pch=16)
		time<-Sys.time()
		while(Sys.time()<time+1/sqrt(i)){}

            lines(c(pts[i-1,1], pts[i,1]), c(pts[i-1,2], pts[i-1,2]))
		time<-Sys.time()
		while(Sys.time()<time+1/sqrt(i)){}


		points(pts[i,1],pts[i-1,2],pch=16)
            time<-Sys.time()
		while(Sys.time()<time+1/sqrt(i)){}

		lines(c(pts[i,1], pts[i,1]), c(pts[i-1,2], pts[i,2]))
		time<-Sys.time()
		while(Sys.time()<time+1/sqrt(i)){}


}




#############################################
#showing just the points 
#############################################

contour(x,y,z,xlab="MPH", ylab="Radial Accuracy",main="F-35 Speed vs Accuracy")
abline(v=mu.x)
abline(h=mu.y)


for(i in 2:10000){

    		points(pts[i-1,1],pts[i-1,2],pch=16)
		
		points(pts[i,1],pts[i-1,2],pch=16)
            


}
