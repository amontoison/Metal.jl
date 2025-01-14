@testset "arrays" begin

let mtl_arr = MtlArray{Int}(undef, 1)
    arr = Array(mtl_arr)

    @test sizeof(arr) == 8
    @test length(arr) == 1
    @test eltype(arr) == Int
end

let mtl_arr = MtlArray{Int}(undef, 0)
    @test pointer(mtl_arr).buffer.handle == C_NULL
end

@testset "fill($T)" for T in [Int8, UInt8, Int16, UInt16, Int32, UInt32, Int64, UInt64,
                              Float32]
    A = MtlArray{T}(undef, (10, 10))
    b = rand(T)
    A = Metal.fill(b, (10, 10))
    @test all(Array(A) .== b)
end

@testset "fill!($T)" for T in [Int8, UInt8, Int16, UInt16, Int32, UInt32, Int64, UInt64,
                               Float32]
    A = MtlArray{T}(undef, (10, 10))
    b = rand(T)
    fill!(A, b)
    @test all(Array(A) .== b)
end

end
