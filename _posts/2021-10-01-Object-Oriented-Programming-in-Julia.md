---
layout: blog
title: Types and Multiple Dispatch in Julia
usemathjax: true
published: true
---

# {{ page.title }}

Three topics will be covered:
1. User-defined types
2. Multiple dispatch
3. Type hierarchy


## User-defined types

Recap of functions

```julia
function myLS(y::Array{Float64}, X::Array{Float64})

    # Calculate LS
    β = (X' * X) \ (X' * y)

    # Return the regression coefficient
    return β
end #MYLS
```


Introduction to ``struct``

```julia
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
```

objects are unmutable. but there are mutable types. could be interesting, also
for econometrics! For example, with local linear regression, where the coefficient
is computational intensive and x-dependent.

## Multiple Dispatch
introduction to methods.

## Super types

Type structure for my estimators

suppose we want to introduce a TSLS object. Some things will be shared with the OLS object! E.g., the coefficient function and the prediction function!

```julia
abstract type myEstimators end
```

```julia
struct myLS <: myEstimators
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
```

```julia
struct myTSLS <: myEstimators
    β::Array{Float64} # coefficient
    y::Array{Float64} # response
	Z::Array{Float64} # combined first stage variables
    X::Array{Float64} # combined second stage variables
	FS::Array{Float64} # first stage coefficients

	# Define constructor function
	function myTSLS(y::Array{Float64}, D::Array{Float64},
                    instrument::Array{Float64}, control = nothing)
        # Add constant if no control is passed
        if isnothing(control) control = ones(length(y)) end

		# Define data matrices
		Z = hcat(control, instrument) # combined first stage variables
		X = hcat(D, control) # combined second stage variables

		# Calculate matrix products
		ZZ = Z' * Z
		DZ = X' * Z
		Zy = Z' * y
		FS = inv(ZZ) * DZ'

		# Calculate TSLS coefficient
		β = (DZ * FS)' \ (FS' * Zy)

		# Return output
		new(β, y, Z, X, FS)
	end #MYTSLS
end #MYTSLS
```



Methods are

```julia
function coef(fit::myEstimators)
    return fit.β
end #COEF.MYESTIMATORS

function predict(fit::myEstimators, data = nothing)
  # Calculate and return predictions
  isnothing(data) ? fitted = fit.X * fit.β : fitted = data * fit.β
  return(fitted)
end #PREDICT.MYESTIMATORS
```
