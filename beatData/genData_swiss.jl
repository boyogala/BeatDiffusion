### ================== START ======================== ###
## Generating Swiss Roll Dataset
## using Random,Statistics
function genData_swiss(::Type{T}; n_samples::Int=3000) where T <: AbstractFloat
    # genenrate rand number with the type of T
    theta = sqrt.(rand(T, n_samples)) .* (T(4) * T(pi))
    # radius of spin
    r = T(2) .* theta .+ T(pi)
    # x-axis and y-axis
    x = r .* cos.(theta)
    y = r .* sin.(theta)
    # matrix{T} with 2 * n_samples
    data = [reshape(x,(1,n_samples));reshape(y,(1,n_samples))]
    
    # normalize to the range of [-1, 1]
    mu = mean(data, dims=2)
    sig = max.(std(data, dims=2), eps(T))
    data = (data .- mu) ./ sig
    # return the generated data
    return data
end
## Add two methods into genData_swiss
genData_swiss(n_samples::Int=3000) = genData_swiss(Float64; n_samples)
### ==================  END ======================== ###

using Random,Statistics,Plots

## Type of DATA
genDataType = Float64;
## Generate DATA
real_data = genData_swiss(genDataType;n_samples = 2000)
## Plot DATA
p1 = scatter(real_data[1,:], real_data[2,:], 
    label="Real Data", title="Ground Truth", 
    ms=2, alpha=0.5, c=:blue, aspect_ratio=:equal, 
    xlims=(-2.5, 2.5), ylims=(-2.5, 2.5)
)