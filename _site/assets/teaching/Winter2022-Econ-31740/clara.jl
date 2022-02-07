# %%

# ECON 31740 (Pouliot): problem set 2, question 8 only
# Clara Kyung 
# with help from Thomas' TA session code (thanks!)



using Statistics
using DataFrames
using JuMP, GLPK
using CSV
using Plots
pyplot()
# %% 

# Question 8 ########################################################

# import data
df = CSV.read("assets\\teaching\\Winter2022-Econ-31740\\data_pset3.csv", DataFrame)
nobs = length(df[!,:age])
df[!,:age2] = df[!,:age].^2
df[!,:weightgain2] = df[!,:weightgain].^2
df[!,:cons] = ones(nobs, 1)[:]

X = Matrix(df)
Y = X[:,1]
X = X[:, 1:end .!= 1] # remove Y column

nk = size(X, 2)

# initialize model
m = Model(GLPK.Optimizer)

# initialize variables
@variable(m, u[1:nobs] >= 0) # +ve part of error
@variable(m, v[1:nobs] >= 0) # -ve part of error
@variable(m, β[1:nk])

@constraint(m, c[i = 1:nobs], X[i,:]'*β + u[i] - v[i] == Y[i])

τ = 0.4 
@objective(m, Min, τ*sum(u[1:nobs]) + (1-τ)*sum(v[1:nobs]))

MOI.set(m, MOI.Silent(), true)
optimize!(m)

value.(m[:β])

dual_objective_value(m)
is_active = (dual.(c) .<τ - 1e-10) .& 
   (dual.(c) .> -(1 - τ) + 1e-10)
sum(is_active)

histogram(dual.(c))

# how do I print the final betas? 
# how to access dual results? 


# question 8 in problem set 

# model = rq(@formula(birthweight ~ age + age2 + boy + married + black + 
#     highschool + somecollege + college + prenone + presecond + prethird + 
#     smoker + cigsdaily + weightgain + weightgain2), df; 
#     τ=0.50)


models = rq(@formula(birthweight ~ boy + married + black + age + age2 + highschool +
                            somecollege + college + prenone + presecond + prethird + smoker
                            + cigsdaily + weightgain + weightgain2), df, τ=[0.25:0.25:0.75;],
                   fitmethod="br")

models[0.5].fit.dual
length(unique(models[0.5].fit.dual[]))