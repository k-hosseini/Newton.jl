module Newton

# Write your package code here.
using Statistics, LinearAlgebra, ForwardDiff

function newtonroot(f,f′;x₀,tol=1E-7,maxiter=1000)
    println("the first dispach")
    x=zeros(maxiter+1)
    x_old=x₀
    i=1
    norm_dif=Inf
    while i <= maxiter &&  norm_dif>=tol 
        x_new=x_old - f(x_old)/f′(x_old)
        i+=1
        norm_dif=norm(x_new-x_old)
        x_old=x_new
    end
    if i == maxiter+1
        return nothing
    else 
        return (iteration=i, norm_dif=norm_dif, x=x_old)
    end
end


function newtonroot(f;x₀,tol = 1E-7,maxiter = 1000)
    println("the second dispach")
    x=zeros(maxiter+1)
    x_old=x₀
    i=1
    norm_dif=Inf
    f_prime(x)=ForwardDiff.derivative(f,x)
    while i <= maxiter &&  norm_dif>=tol 
        x_new=x_old - f(x_old)/f_prime(x_old)
        i+=1
        norm_dif=norm(x_new-x_old)
        x_old=x_new
    end
    if i == maxiter+1
        return nothing
    else 
        return (iteration=i, norm_dif=norm_dif, x=x_old)
    end
end

export newtonroot
end
