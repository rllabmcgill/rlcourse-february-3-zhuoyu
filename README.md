# rlcourse-february-3-zhuoyu
rlcourse-february-3-zhuoyu created by GitHub Classroom

# Off-policy Learning with Recognizers By Precup et al., 2005.

In this task, I:
- explained the importance sampling and the recognizer from statistical point of view. 
- derived the expection and variance of the return estimator under the target policy, and showed the relationship of them with those under the behavior policy.
- showed how to get u.
- proved Theorem 1 and explained what is the interpretation of Theorem 1.
- explained the reasons for the differences in the variance plot.

R code to run the simulation similar to the one in the paper is provided. The behavior policy is a standard normal density. The first target policy is the same as the uniform one in the paper: uniform on (0.7, 0.9). The second target policy is a recognizer between (0.7 and 0.9). The retrun function r(x) is simiplized to return x.
