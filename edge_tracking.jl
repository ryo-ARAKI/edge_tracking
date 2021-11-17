#=
Compute the 2D system
    ẋ = -x + 10 y
    ẏ = y (10 e^(-0.01 x²) - y) (y - 1)
and investigate its edge state.

Cf.[Rich Kerswell, "Edge Tracking - Walking the Tightrope"](https://gfd.whoi.edu/wp-content/uploads/sites/18/2018/03/rich8_131207.pdf)
=#


"""
Module to define ODEs
"""
module ODE

"""
ODE function of the 2D system
    ẋ = -x + 10 y
    ẏ = y (10 e^(-0.01 x²) - y) (y - 1)
"""
function ODE_2D_system(dX, X, p, t)
    # Set variables
    x, y = X

    dX[1] = (  # ẋ
        -x + 10.0 * y
    )
    dX[2] = (  # ẏ
        y * (10.0 * exp(-0.01 * x^2) - y) * (y - 1.0)
    )
end

end
