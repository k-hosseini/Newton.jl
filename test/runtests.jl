using Newton
using Test


f1(x)=x^3
f1_prime(x)=3*x^2

f2(x) = sin(x)
f2_prime(x) = cos(x)

f3(x) = log(x)
f3_prime(x) = 1//x


fs=[f1,f2,f3]
f_primes=[f1_prime,f2_prime,f3_prime]
f_nc(x) = 2+ x^2
f_nc_prime(x) = 2*x

@testset "Newton.jl" begin
    
    for (f,f_prime) in zip(fs,f_primes) # Several test for the root of a known function,given f and analytical f′
        @test newtonroot(f,x₀=1).x≈newtonroot(f,f_prime,x₀=1).x 
    end

    for (f,f_prime) in zip(fs,f_primes)
        for i in 1:200:1000 # test to ensure that maxiter is working
            @test  newtonroot(f,f_prime,x₀=1, maxiter=i)===nothing || newtonroot(f,f_prime,x₀=1, maxiter=i).iteration <= i
        end
    end

    for (f,f_prime) in zip(fs,f_primes)
        for i in 1:200:1000 # test to ensure that maxiter is working
            @test  newtonroot(f,f_prime,x₀=1, maxiter=i)===nothing || newtonroot(f,f_prime,x₀=1, maxiter=i).iteration <= i
        end
    end

    @test newtonroot(f_nc,x₀=1) === nothing # Test of non-convergence
    @test newtonroot(f_nc,f_nc_prime,x₀=1)=== nothing # Test of non-convergence

    @test newtonroot(f1,f1_prime,x₀=BigFloat(1)).x |> typeof == BigFloat # BigFloat roots
    @test newtonroot(f1,x₀=BigFloat(1)).x |> typeof == BigFloat # BigFloat roots

    @test newtonroot(f1,x₀=1) == nothing ? true : newtonroot(f1,x₀=1).norm_dif <=1E-5
    @test newtonroot(f1,f1_prime, x₀=1) == nothing ? true : newtonroot(f1,x₀=1).norm_dif <=1E-5

end
