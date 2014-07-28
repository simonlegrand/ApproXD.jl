
module BSplines_test

using BSplines
using Base.Test 


deg    = 3
nKnots = 7
lb     = 0.0
ub     = 10.0

b = BSpline(nKnots,deg,lb,ub)

@test BSplines.getNumKnots(b) + 2*deg == length(b.knots)
@test b.degree == deg
@test b.numKnots == nKnots
@test b.lower == lb
@test b.upper == ub

@test_throws ArgumentError BSpline(nKnots,deg,ub,lb)
@test_throws ArgumentError BSpline(nKnots,-1,lb,ub)
nKnots=2
@test_throws ArgumentError BSpline(nKnots,deg,lb,ub)



# test that when x == upper/lower, first/last basis is 1
@test nonzeros(getBasis(lb,b)) == [1.0]
@test nonzeros(getBasis(ub,b)) == [1.0]


# compare computed basis to R splineDesign()

nKnots = 15
lb     = -1.1
ub     = 17.4

points = linspace(lb,ub,18)

# R data
# in R:
# points = seq(lb,ub,length=5)
# Rbase = as.numeric(splineDesign(knots=knots,x=points,ord=deg+1))
Rbase = Dict{Int,Vector}()
Rbase[1] = [1.00000000, 0.17647086, 0.00000000, 0.00000000, 0.00000000, 0.00000000,
0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000,
0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000,
0.00000000, 0.82352914, 0.35294269, 0.00000000, 0.00000000, 0.00000000,
0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000,
0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000,
0.00000000, 0.00000000, 0.64705731, 0.52941444, 0.00000000, 0.00000000,
0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000,
0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000,
0.00000000, 0.00000000, 0.00000000, 0.47058556, 0.70588369, 0.00000000,
0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000,
0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000,
0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.29411631, 0.88234983,
0.05882130, 0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000,
0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000,
0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.11765017,
0.94117870, 0.23529278, 0.00000000, 0.00000000, 0.00000000, 0.00000000,
0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000,
0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000,
0.00000000, 0.76470722, 0.41176426, 0.00000000, 0.00000000, 0.00000000,
0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000,
0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000,
0.00000000, 0.00000000, 0.58823574, 0.58823574, 0.00000000, 0.00000000,
0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000,
0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000,
0.00000000, 0.00000000, 0.00000000, 0.41176426, 0.76471434, 0.00000000,
0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000,
0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000,
0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.23528566, 0.94120763,
0.11766041, 0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000,
0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000,
0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.05879237,
0.88233959, 0.29411320, 0.00000000, 0.00000000, 0.00000000, 0.00000000,
0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000,
0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000,
0.00000000, 0.70588680, 0.47056598, 0.00000000, 0.00000000, 0.00000000,
0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000,
0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000,
0.00000000, 0.00000000, 0.52943402, 0.64704547, 0.00000000, 0.00000000,
0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000,
0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000,
0.00000000, 0.00000000, 0.00000000, 0.35295453, 0.82354722, 0.00000000,
0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000,
0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000,
0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.17645278, 1.00000000
]


Rbase[2] = [ 1.000000000, 0.031141963, 0.000000000, 0.000000000, 0.000000000, 0.000000000,
0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,
0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,
0.000000000,0.629758168,0.062284318,0.000000000,0.000000000,0.000000000,
0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,
0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,
0.000000000,0.339099869,0.728374021,0.140139769,0.000000000,0.000000000,
0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,
0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,
0.000000000,0.000000000,0.209341660,0.749134425,0.249134948,0.000000000,
0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,
0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,
0.000000000,0.000000000,0.000000000,0.110725806,0.707613013,0.389272080,
0.001729979,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,
0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,
0.000000000,0.000000000,0.000000000,0.000000000,0.043252039,0.603807138,
0.555361351,0.027681347,0.000000000,0.000000000,0.000000000,0.000000000,
0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,
0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.006920782,
0.442908669,0.679930089,0.084774903,0.000000000,0.000000000,0.000000000,
0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,
0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,
0.000000000,0.292388564,0.742214454,0.173010642,0.000000000,0.000000000,
0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,
0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,
0.000000000,0.000000000,0.173010642,0.742215737,0.292398436,0.000000000,
0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,
0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,
0.000000000,0.000000000,0.000000000,0.084773620,0.679921160,0.442924171,
0.006921803,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,
0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,
0.000000000,0.000000000,0.000000000,0.000000000,0.027680404,0.555347557,
0.603816624,0.043251286,0.000000000,0.000000000,0.000000000,0.000000000,
0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,
0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.001728271,
0.389261573,0.707610624,0.110716169,0.000000000,0.000000000,0.000000000,
0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,
0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,
0.000000000,0.249138090,0.749138941,0.209341841,0.000000000,0.000000000,
0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,
0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,
0.000000000,0.000000000,0.140144889,0.728367352,0.339102179,0.000000000,
0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,
0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,
0.000000000,0.000000000,0.000000000,0.062290807,0.629762237,0.000000000,
0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,
0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,
0.000000000,0.000000000,0.000000000,0.000000000,0.031135584,1.000000000]


Rbase[3] = [ 1.000000e+00, 5.495649e-03, 0.000000e+00, 0.000000e+00, 0.000000e+00,
0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,
0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,
0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,3.960926e-01,
1.099141e-02,0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,
0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,
0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,
0.000000e+00,0.000000e+00,5.053256e-01,3.797757e-01,2.473067e-02,
0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,
0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,
0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,
9.308614e-02,5.640807e-01,4.973204e-01,5.861979e-02,0.000000e+00,
0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,
0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,
0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,4.515215e-02,
4.605802e-01,5.928834e-01,1.144917e-01,3.391997e-05,0.000000e+00,
0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,
0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,
0.000000e+00,0.000000e+00,0.000000e+00,1.736870e-02,3.442564e-01,
6.536401e-01,1.977060e-01,2.171079e-03,0.000000e+00,0.000000e+00,
0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,
0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,
0.000000e+00,0.000000e+00,4.240355e-03,2.315968e-01,6.633080e-01,
3.054812e-01,1.163576e-02,0.000000e+00,0.000000e+00,0.000000e+00,
0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,
0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,
0.000000e+00,2.714104e-04,1.389521e-01,6.178172e-01,4.224164e-01,
3.392368e-02,0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,
0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,
0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,
0.000000e+00,7.453055e-02,5.320245e-01,5.320283e-01,7.453526e-02,
0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,
0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,
0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,
3.392334e-02,4.224124e-01,6.178178e-01,1.389577e-01,2.714672e-04,
0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,
0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,
0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,1.163555e-02,
3.054759e-01,6.633084e-01,2.316003e-01,4.240183e-03,0.000000e+00,
0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,
0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,
0.000000e+00,0.000000e+00,0.000000e+00,2.171011e-03,1.977000e-01,
6.536412e-01,3.442539e-01,1.736642e-02,0.000000e+00,0.000000e+00,
0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,
0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,
0.000000e+00,0.000000e+00,3.386972e-05,1.144870e-01,5.928863e-01,
4.605788e-01,4.515351e-02,0.000000e+00,0.000000e+00,0.000000e+00,
0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,
0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,
0.000000e+00,0.000000e+00,5.861962e-02,4.973229e-01,5.640748e-01,
9.308654e-02,0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,
0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,
0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,
0.000000e+00,2.473187e-02,3.797783e-01,5.053253e-01,0.000000e+00,
0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,
0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,
0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,
1.099333e-02,3.960942e-01,0.000000e+00,0.000000e+00,0.000000e+00,
0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,
0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,
0.000000e+00,0.000000e+00,0.000000e+00,0.000000e+00,5.493960e-03,
1.000000e+00]

for deg in 1:3

	b = BSpline(nKnots,deg,lb,ub)
	bs = getBasis(points,b)

	@test size(bs) == (length(points),BSplines.getNumCoefs(b))

	@test_approx_eq_eps maximum(abs(full(bs)[:] .- Rbase[deg])) 0.0 1e-4

end




end