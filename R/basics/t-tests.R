# goal of this script is to demonstrate 
# running statistical tests in R - both manually and using inbuilt function(s)

# t-test: lets start doing it manually
sampleSize = 100 #*10

# one sample
observations.test = rnorm(sampleSize)
observations.test = rnorm(sampleSize, mean= 0.1)
observations.test = rnorm(sampleSize, mean= 0.25)

mean.null = 0
tStat = (mean(observations.test) - mean.null) / (sd(observations.test)/sqrt(sampleSize))
prob.oneSided = pt(tStat, df= sampleSize-1, lower.tail = F)

tCritical = qt(p= 0.95, df= sampleSize-1)
pt(tCritical, df= sampleSize-1, lower.tail = F)

?stderr()

# direct method
t.test(observations.test)
t.test(observations.test, alternative = "greater")


# two sample - equal sizes and variance
sampleSize = 100 #*10

observations.test = rnorm(sampleSize, mean = 0.2)
observations.control = rnorm(sampleSize)

grpdStdErr = sqrt((var(observations.test) + var(observations.control)) / 2)
tStat = (mean(observations.test) - mean(observations.control)) / (grpdStdErr * sqrt(2/sampleSize))
prob.oneSided = pt(tStat, df= 2*(sampleSize-1), lower.tail = F)

# direct 
t.test(x= observations.test, y= observations.control, alternative = 'greater')
t.test(x= observations.test, y= observations.control, alternative = 'greater', var.equal = T)

# two sample - generalized
t.test2 = function(x, y, m0= 0, equal.variance= F)
{
  m1 = mean(x)
  m2= mean(y)
  s1= sd(x)
  s2= sd(y)
  n1= length(x)
  n2= length(y)
  
  if(equal.variance==F) {
    se = sqrt( (s1^2/n1) + (s2^2/n2) )
    # welch-satterthwaite df
    df = ( (s1^2/n1 + s2^2/n2)^2 )/( (s1^2/n1)^2/(n1-1) + (s2^2/n2)^2/(n2-1) )
  } else {
    # pooled standard deviation, scaled by the sample sizes
    se = sqrt( (1/n1 + 1/n2) * ((n1-1)*s1^2 + (n2-1)*s2^2)/(n1+n2-2) ) 
    df = n1+n2-2
  }      
  
  t = (m1-m2-m0)/se 
  dat = c(m1-m2, se, t, pt(t, df, lower.tail = F))    
  names(dat) = c("Difference of means", "Std Error", "t", "p-value One Sided")
  return(dat) 
}

t.test2(x= observations.test, y= observations.control)



# calculating power of a t-test
sampleSize = 1000

observations.test = rnorm(sampleSize, mean = 0.1, sd = 1)
observations.control = rnorm(sampleSize, sd= 1)

t.power = function(x, y, alpha= 0.05, equal.variance= F)
{
  m1 = mean(x)
  m2= mean(y)
  s1= sd(x)
  s2= sd(y)
  n1= length(x)
  n2= length(y)
  
  if(equal.variance==F) {
    df = ( (s1^2/n1 + s2^2/n2)^2 )/( (s1^2/n1)^2/(n1-1) + (s2^2/n2)^2/(n2-1) )
  } else {
    df = n1+n2-2
  }  
  
  meanDiff = m1-m2
  tCritical = qt(1-alpha, df)
  nonCentrality = meanDiff/sqrt((s1^2/n1)+(s2^2/n2))
  power = 1-pt(tCritical, df, nonCentrality)
  
  dat = c(meanDiff, tCritical, df, nonCentrality, power)
  names(dat) = c('Mean Diff', 'T-Critical', 'DF', 'NCP', 'Power')
  return(dat) 
}

t.power(x= observations.test, y= observations.control)

power.t.test(n= sampleSize, delta= 0.31, sd= 1, sig.level= 0.05, 
             type= 'two.sample', alternative= 'one.sided')

power.t.test(delta= 0.1, sd= 1, sig.level= 0.05, power= 0.9,
             type= 'two.sample', alternative= 'one.sided')
