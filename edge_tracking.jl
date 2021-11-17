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
function ODE_2D_system!(dX, X, p, t)
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


using Printf
using DifferentialEquations
using Statistics
using Random
using .ODE: ODE_2D_system!

# ========================================
# Main function
# ========================================
function main()

    # Set initial condition for x and y
    init_cond = [5.0; 5.0]
    # Set time range to compute
    t_span = (0.0, 1000.0)

    # Stdout problem information
    println(
        "Solve:
        ẋ = -x + 10 y
        ẏ = y (10 e^(-0.01 x²) - y) (y - 1)\n"
    )
    println("Time range: ", t_span)

    # Set up strings
    filename_parameter = @sprintf "ic=%.2f_%.2f" init_cond[1] init_cond[2]

    # Set up the problem
    prob = ODEProblem(ODE_2D_system!, init_cond, t_span)

    # Solve the problem
    arg = RK4()
    sol = solve(prob, arg, adaptive = false, dt = 0.01)

    # Save result of the problem
    filename = "2dsystem_" * filename_parameter * ".d"

    open(filename, "w") do f
        for itr = 1:length(sol.t)
            println(
                f,
                @sprintf "%.3e %.5e %.5e" sol.t[itr] sol[1, itr] sol[2, itr]  # t, x, y
            )
        end
    end
    println("Save: ", filename)

end

main()
