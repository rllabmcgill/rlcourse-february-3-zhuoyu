# task 2

u <- pnorm(0.9)-pnorm(0.7)


target_policy_density <- function(x, u){
	if(x>=0.7& x<=0.9){
		return(u*behavior_policy(x))
	} else {
		return(0)
	}
}

Return <- function(x){
	return(x)
}

behavior_policy_density <- function(x) {
# normal
	return(dnorm(x))
} 

sampling_behavior_policy <- function(n) {
# normal
	return(rnorm(n))
} 

n=10000
sample_var <- matrix(NA, nrow=200, ncol=500-1)
left <- 0
current <- 1
for(i in 1:200) {
	for (j in 2:500){
		while(left<j) {
			temp <- sampling_behavior_policy(n)
			x <- c(x[current:length(x)],temp[(temp<0.9)&(temp>0.7)])
			left <- length(x)
			current <- 1
		}
		returns <- Return(x[current+(1:j)]/u)
		current <- current+j
		left <- left - j
		sample_var[i,j-1] <- var(returns)	
	}
}

n=10000
sample_var2 <- matrix(NA, nrow=200, ncol=500-1)
left <- 0
current <- 1
for(i in 1:200) {
	for (j in 2:500){
		while(left<j) {
			temp <- sampling_behavior_policy(n)
			x <- c(x[current:length(x)],temp[(temp<0.9)&(temp>0.7)])
			left <- length(x)
			current <- 1
		}
		returns <- Return(x[current+(1:j)]*5/(behavior_policy_density(x[current+(1:j)])))
		current <- current+j
		left <- left - j
		sample_var2[i,j-1] <- var(returns)	
	}
}

df1 <- data.frame(Variance<-c(colMeans(sample_var),colMeans(sample_var2)),Type=rep(c("Uniform Target", "Recognizer"),each=499)， Sample_Size=c(2:500, 2:500))
library("ggplot2")
ggplot(df1, aes(x=Sample_Size, y=Variance, group=Type, color=Type)) + geom_point()




a <- c(2,seq(20,500, by=20))
sample_var <- matrix(NA, nrow=200, ncol=length(a))

for(i in 1:200) {
	for (j in 1:length(a)){
		temp <- sampling_behavior_policy(a[j])
		x <- c(temp[(temp<0.9)&(temp>0.7)])
		returns <- Return(x/u)
		sample_var[i,j] <- var(returns,na.rm=TRUE)	
	}
}


sample_var2 <- matrix(NA, nrow=200, ncol=length(a))
for(i in 1:200) {
	for (j in 1:length(a)){
		temp <- sampling_behavior_policy(a[j])
		x <- c(temp[(temp<0.9)&(temp>0.7)])
		returns <- Return(x*5/(behavior_policy_density(x)))
		sample_var2[i,j] <- var(returns,na.rm=TRUE)	
	}
}

df1 <- data.frame(Variance<-c(colMeans(sample_var,na.rm=TRUE),colMeans(sample_var2,na.rm=TRUE)),Type=rep(c("Uniform Target", "Recognizer"),each=length(a))， Sample_Size=c(a, a))
library("ggplot2")
ggplot(df1, aes(x=Sample_Size, y=Variance, group=Type, color=Type)) + geom_line() + geom_point()
