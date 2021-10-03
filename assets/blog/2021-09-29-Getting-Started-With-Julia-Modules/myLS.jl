"""
myLS(y, X)

A simple least squares implementation.
"""
struct myLS
    β::Array{Float64} # coefficient
    y::Array{Float64} # response
    X::Array{Float64} # features

    # Define constructor function
    function myLS(y::Array{Float64}, X::Array{Float64})

    # Calculate LS
    β = (X' * X) \ (X' * y)

    # Organize and return output
    new(β, y, X)
    end #MYLS
end #MYLS

# Methods ======================================================================
"""
coef(fit::myLS)

A method to retrieve the coefficient from a myLS object.
"""
function coef(fit::myLS)
    return fit.β
end #COEF.MYLS

"""
predict(fit::myLS; data)

A method to calculate predictions of a myLS object.
"""
function predict(fit::myLS; data = nothing)
    # Return predicted values
    if isnothing(data)
        return fit.X * fit.β
    else
        return data * fit.β
    end
end #PREDICT.MYLS

"""
inference(fit::myLS; heteroskedastic, print_df)

A method to calculate standard errors of a myLS object.
"""
function inference(fit::myLS; heteroskedastic::Bool=false, print_df::Bool=true)
    # Obtain data parameters
    N = length(fit.y)
    K = size(fit.X, 2)

    # Calculate the covariance matrix
    u = fit.y - predict(fit) # residuals
    XX_inv = inv(fit.X' * fit.X)
    if !heteroskedastic
        # homoskedastic se
        covar = sum(u.^2) * XX_inv
	    covar = covar .* (1 / (N - K)) # dof adjustment
    else
        # heteroskedastic se
        covar = XX_inv * ((fit.X .* (u.^2))' * fit.X) * XX_inv
		covar = covar .* (N / (N - K)) # dof adjustment
    end

    # Get standard errors, t-statistics and p-values
    se = sqrt.(covar[diagind(covar)])
    t_stat = fit.β ./ se
    p_val = 2 * cdf.(Normal(), -abs.(t_stat))

    # Print estimates
    if print_df
        out_df = DataFrame(hcat(fit.β, se, t_stat, p_val), :auto)
        rename!(out_df, ["coef", "se", "t-stat", "p-val"])
        display(out_df)
    end

    # Organize and return output
    output = (β = fit.β, se = se, t = t_stat, p = p_val)
    return output
end #INFERENCE.MYLS
