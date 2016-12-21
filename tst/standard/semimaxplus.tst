#############################################################################
##
#W  standard/semimaxplus.tst
#Y  Copyright (C) 2015                                  James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##
gap> START_TEST("Semigroups package: standard/semimaxplus.tst");
gap> LoadPackage("semigroups", false);;

#
gap> SEMIGROUPS.StartTest();

# semimaxplus: C++ code working, for max-plus matrix semigroup
gap> S := Semigroup(Matrix(IsMaxPlusMatrix, [[0, -4], [-4, -1]]),
>                   Matrix(IsMaxPlusMatrix, [[0, -3], [-3, -1]]));
<semigroup of 2x2 max-plus matrices with 2 generators>
gap> Size(S);
26
gap> NrDClasses(S);
23
gap> NrRClasses(S);
24
gap> NrLClasses(S);
24
gap> NrHClasses(S);
26
gap> NrIdempotents(S);
4
gap> MultiplicativeZero(S);
fail
gap> AsSemigroup(IsMaxPlusMatrixSemigroup, S) = S;
true

# semimaxplus: C++ code working, for natural matrix semigroup
gap> S := Monoid(Matrix(IsNTPMatrix, [[0, 1, 0], [1, 1, 0], [0, 1, 0]], 1, 2),
>                Matrix(IsNTPMatrix, [[1, 0, 0], [1, 0, 1], [1, 0, 0]], 1, 2));
<monoid of 3x3 ntp matrices with 2 generators>
gap> Size(S);
37
gap> Length(RelationsOfFpMonoid(Range(IsomorphismFpMonoid(S))));
12
gap> NrDClasses(S);
8
gap> NrRClasses(S);
14
gap> NrLClasses(S);
17
gap> NrHClasses(S);
35
gap> NrIdempotents(S);
20
gap> MultiplicativeZero(S);
fail

#T# helper functions
gap> BruteForceIsoCheck := function(iso)
>   local x, y;
>   if not IsInjective(iso) or not IsSurjective(iso) then
>     return false;
>   fi;
>   for x in Generators(Source(iso)) do
>     for y in Generators(Source(iso)) do
>       if x ^ iso * y ^ iso <> (x * y) ^ iso then
>         return false;
>       fi;
>     od;
>   od;
>   return true;
> end;;
gap> BruteForceInverseCheck := function(map)
> local inv;
>   inv := InverseGeneralMapping(map);
>   return ForAll(Source(map), x -> x = (x ^ map) ^ inv)
>     and ForAll(Range(map), x -> x = (x ^ inv) ^ map);
> end;;

# IsomorphismSemigroup: for semigroup of same type
gap> S := Semigroup(Matrix(IsTropicalMaxPlusMatrix, [[0, 4], [4, 1]], 10));
<commutative semigroup of 2x2 tropical max-plus matrices with 1 generator>
gap> AsSemigroup(IsTropicalMaxPlusMatrixSemigroup, 10, S) = S;
true
gap> map := IsomorphismSemigroup(IsTropicalMaxPlusMatrixSemigroup, 11, S);;
gap> T := Range(map);;
gap> T = S;
false
gap> Size(S) = Size(T);
true
gap> NrDClasses(S) = NrDClasses(T);
true
gap> NrRClasses(S) = NrRClasses(T);
true
gap> NrLClasses(S) = NrLClasses(T);
true
gap> NrIdempotents(S) = NrIdempotents(T);
true
gap> BruteForceIsoCheck(map);
true
gap> BruteForceInverseCheck(map);
true
gap> S := Semigroup(Matrix(IsNTPMatrix, [[0, 0], [1, 3]], 2, 2));
<commutative semigroup of 2x2 ntp matrices with 1 generator>
gap> AsSemigroup(IsNTPMatrixSemigroup, 2, 2, S) = S;
true
gap> map := IsomorphismSemigroup(IsNTPMatrixSemigroup, 3, 3, S);;
gap> T := Range(map);;
gap> T = S;
false
gap> Size(S) = Size(T);
true
gap> NrDClasses(S) = NrDClasses(T);
true
gap> NrRClasses(S) = NrRClasses(T);
true
gap> NrLClasses(S) = NrLClasses(T);
true
gap> NrIdempotents(S) = NrIdempotents(T);
true
gap> BruteForceIsoCheck(map);
true
gap> BruteForceInverseCheck(map);
true

#T# AsSemigroup:
#   convert from IsPBRSemigroup to IsMaxPlusMatrixSemigroup
gap> S := Semigroup( [ PBR([ [ -2 ], [ -3 ], [ -4 ], [ -5 ], [ -6 ], [ -7 ], [ -8 ], [ -8 ], [ -1 ] ], [ [ 9 ], [ 1 ], [ 2 ], [ 3 ], [ 4 ], [ 5 ], [ 6 ], [ 7, 8 ], [ ] ]) ] );
<commutative pbr semigroup of degree 9 with 1 generator>
gap> T := AsSemigroup(IsMaxPlusMatrixSemigroup, S);
<commutative semigroup of size 8, 9x9 max-plus matrices with 1 generator>
gap> Size(S) = Size(T);
true
gap> NrDClasses(S) = NrDClasses(T);
true
gap> NrRClasses(S) = NrRClasses(T);
true
gap> NrLClasses(S) = NrLClasses(T);
true
gap> NrIdempotents(S) = NrIdempotents(T);
true
gap> map := IsomorphismSemigroup(IsMaxPlusMatrixSemigroup, S);;
gap> BruteForceIsoCheck(map);
true
gap> BruteForceInverseCheck(map);
true

#T# AsSemigroup:
#   convert from IsFpSemigroup to IsMaxPlusMatrixSemigroup
gap> F := FreeSemigroup(1);; AssignGeneratorVariables(F);;
gap> rels := [ [ s1^9, s1^8 ] ];;
gap> S := F / rels;
<fp semigroup on the generators [ s1 ]>
gap> T := AsSemigroup(IsMaxPlusMatrixSemigroup, S);
<commutative semigroup of 9x9 max-plus matrices with 1 generator>
gap> Size(S) = Size(T);
true
gap> NrDClasses(S) = NrDClasses(T);
true
gap> NrRClasses(S) = NrRClasses(T);
true
gap> NrLClasses(S) = NrLClasses(T);
true
gap> NrIdempotents(S) = NrIdempotents(T);
true
gap> map := IsomorphismSemigroup(IsMaxPlusMatrixSemigroup, S);;
gap> BruteForceIsoCheck(map);
true
gap> BruteForceInverseCheck(map);
true

#T# AsSemigroup:
#   convert from IsBipartitionSemigroup to IsMaxPlusMatrixSemigroup
gap> S := Semigroup( [ Bipartition([ [ 1, -2 ], [ 2, -3 ], [ 3, -4 ], [ 4, -5 ], [ 5, -6 ], [ 6, -7 ], [ 7, 8, -8 ], [ 9, -1 ], [ -9 ] ]) ] );
<commutative bipartition semigroup of degree 9 with 1 generator>
gap> T := AsSemigroup(IsMaxPlusMatrixSemigroup, S);
<commutative semigroup of 9x9 max-plus matrices with 1 generator>
gap> Size(S) = Size(T);
true
gap> NrDClasses(S) = NrDClasses(T);
true
gap> NrRClasses(S) = NrRClasses(T);
true
gap> NrLClasses(S) = NrLClasses(T);
true
gap> NrIdempotents(S) = NrIdempotents(T);
true
gap> map := IsomorphismSemigroup(IsMaxPlusMatrixSemigroup, S);;
gap> BruteForceIsoCheck(map);
true
gap> BruteForceInverseCheck(map);
true

#T# AsSemigroup:
#   convert from IsTransformationSemigroup to IsMaxPlusMatrixSemigroup
gap> S := Semigroup( [ Transformation( [ 2, 3, 4, 5, 6, 7, 8, 8, 1 ] ) ] );
<commutative transformation semigroup of degree 9 with 1 generator>
gap> T := AsSemigroup(IsMaxPlusMatrixSemigroup, S);
<commutative semigroup of 9x9 max-plus matrices with 1 generator>
gap> Size(S) = Size(T);
true
gap> NrDClasses(S) = NrDClasses(T);
true
gap> NrRClasses(S) = NrRClasses(T);
true
gap> NrLClasses(S) = NrLClasses(T);
true
gap> NrIdempotents(S) = NrIdempotents(T);
true
gap> map := IsomorphismSemigroup(IsMaxPlusMatrixSemigroup, S);;
gap> BruteForceIsoCheck(map);
true
gap> BruteForceInverseCheck(map);
true

#T# AsSemigroup:
#   convert from IsBooleanMatSemigroup to IsMaxPlusMatrixSemigroup
gap> S := Semigroup( [ Matrix(IsBooleanMat, [ [ false, true, false, false, false, false, false, false, false ], [ false, false, true, false, false, false, false, false, false ], [ false, false, false, true, false, false, false, false, false ], [ false, false, false, false, true, false, false, false, false ], [ false, false, false, false, false, true, false, false, false ], [ false, false, false, false, false, false, true, false, false ], [ false, false, false, false, false, false, false, true, false ], [ false, false, false, false, false, false, false, true, false ], [ true, false, false, false, false, false, false, false, false ] ]) ] );
<commutative semigroup of 9x9 boolean matrices with 1 generator>
gap> T := AsSemigroup(IsMaxPlusMatrixSemigroup, S);
<commutative semigroup of 9x9 max-plus matrices with 1 generator>
gap> Size(S) = Size(T);
true
gap> NrDClasses(S) = NrDClasses(T);
true
gap> NrRClasses(S) = NrRClasses(T);
true
gap> NrLClasses(S) = NrLClasses(T);
true
gap> NrIdempotents(S) = NrIdempotents(T);
true
gap> map := IsomorphismSemigroup(IsMaxPlusMatrixSemigroup, S);;
gap> BruteForceIsoCheck(map);
true
gap> BruteForceInverseCheck(map);
true

#T# AsSemigroup:
#   convert from IsMaxPlusMatrixSemigroup to IsMaxPlusMatrixSemigroup
gap> S := Semigroup( [ Matrix(IsMaxPlusMatrix, [ [ -infinity, 0, -infinity, -infinity, -infinity, -infinity, -infinity, -infinity, -infinity ], [ -infinity, -infinity, 0, -infinity, -infinity, -infinity, -infinity, -infinity, -infinity ], [ -infinity, -infinity, -infinity, 0, -infinity, -infinity, -infinity, -infinity, -infinity ], [ -infinity, -infinity, -infinity, -infinity, 0, -infinity, -infinity, -infinity, -infinity ], [ -infinity, -infinity, -infinity, -infinity, -infinity, 0, -infinity, -infinity, -infinity ], [ -infinity, -infinity, -infinity, -infinity, -infinity, -infinity, 0, -infinity, -infinity ], [ -infinity, -infinity, -infinity, -infinity, -infinity, -infinity, -infinity, 0, -infinity ], [ -infinity, -infinity, -infinity, -infinity, -infinity, -infinity, -infinity, 0, -infinity ], [ 0, -infinity, -infinity, -infinity, -infinity, -infinity, -infinity, -infinity, -infinity ] ]) ] );
<commutative semigroup of 9x9 max-plus matrices with 1 generator>
gap> T := AsSemigroup(IsMaxPlusMatrixSemigroup, S);
<commutative semigroup of 9x9 max-plus matrices with 1 generator>
gap> Size(S) = Size(T);
true
gap> NrDClasses(S) = NrDClasses(T);
true
gap> NrRClasses(S) = NrRClasses(T);
true
gap> NrLClasses(S) = NrLClasses(T);
true
gap> NrIdempotents(S) = NrIdempotents(T);
true
gap> map := IsomorphismSemigroup(IsMaxPlusMatrixSemigroup, S);;
gap> BruteForceIsoCheck(map);
true
gap> BruteForceInverseCheck(map);
true

#T# AsSemigroup:
#   convert from IsMinPlusMatrixSemigroup to IsMaxPlusMatrixSemigroup
gap> S := Semigroup( [ Matrix(IsMinPlusMatrix, [ [ infinity, 0, infinity, infinity, infinity, infinity, infinity, infinity, infinity ], [ infinity, infinity, 0, infinity, infinity, infinity, infinity, infinity, infinity ], [ infinity, infinity, infinity, 0, infinity, infinity, infinity, infinity, infinity ], [ infinity, infinity, infinity, infinity, 0, infinity, infinity, infinity, infinity ], [ infinity, infinity, infinity, infinity, infinity, 0, infinity, infinity, infinity ], [ infinity, infinity, infinity, infinity, infinity, infinity, 0, infinity, infinity ], [ infinity, infinity, infinity, infinity, infinity, infinity, infinity, 0, infinity ], [ infinity, infinity, infinity, infinity, infinity, infinity, infinity, 0, infinity ], [ 0, infinity, infinity, infinity, infinity, infinity, infinity, infinity, infinity ] ]) ] );
<commutative semigroup of 9x9 min-plus matrices with 1 generator>
gap> T := AsSemigroup(IsMaxPlusMatrixSemigroup, S);
<commutative semigroup of size 8, 9x9 max-plus matrices with 1 generator>
gap> Size(S) = Size(T);
true
gap> NrDClasses(S) = NrDClasses(T);
true
gap> NrRClasses(S) = NrRClasses(T);
true
gap> NrLClasses(S) = NrLClasses(T);
true
gap> NrIdempotents(S) = NrIdempotents(T);
true
gap> map := IsomorphismSemigroup(IsMaxPlusMatrixSemigroup, S);;
gap> BruteForceIsoCheck(map);
true
gap> BruteForceInverseCheck(map);
true

#T# AsSemigroup:
#   convert from IsProjectiveMaxPlusMatrixSemigroup to IsMaxPlusMatrixSemigroup
gap> S := Semigroup( [ Matrix(IsProjectiveMaxPlusMatrix, [ [ -infinity, 0, -infinity, -infinity, -infinity, -infinity, -infinity, -infinity, -infinity ], [ -infinity, -infinity, 0, -infinity, -infinity, -infinity, -infinity, -infinity, -infinity ], [ -infinity, -infinity, -infinity, 0, -infinity, -infinity, -infinity, -infinity, -infinity ], [ -infinity, -infinity, -infinity, -infinity, 0, -infinity, -infinity, -infinity, -infinity ], [ -infinity, -infinity, -infinity, -infinity, -infinity, 0, -infinity, -infinity, -infinity ], [ -infinity, -infinity, -infinity, -infinity, -infinity, -infinity, 0, -infinity, -infinity ], [ -infinity, -infinity, -infinity, -infinity, -infinity, -infinity, -infinity, 0, -infinity ], [ -infinity, -infinity, -infinity, -infinity, -infinity, -infinity, -infinity, 0, -infinity ], [ 0, -infinity, -infinity, -infinity, -infinity, -infinity, -infinity, -infinity, -infinity ] ]) ] );
<commutative semigroup of 9x9 projective max-plus matrices with 1 generator>
gap> T := AsSemigroup(IsMaxPlusMatrixSemigroup, S);
<commutative semigroup of size 8, 9x9 max-plus matrices with 1 generator>
gap> Size(S) = Size(T);
true
gap> NrDClasses(S) = NrDClasses(T);
true
gap> NrRClasses(S) = NrRClasses(T);
true
gap> NrLClasses(S) = NrLClasses(T);
true
gap> NrIdempotents(S) = NrIdempotents(T);
true
gap> map := IsomorphismSemigroup(IsMaxPlusMatrixSemigroup, S);;
gap> BruteForceIsoCheck(map);
true
gap> BruteForceInverseCheck(map);
true

#T# AsSemigroup:
#   convert from IsIntegerMatrixSemigroup to IsMaxPlusMatrixSemigroup
gap> S := Semigroup( [ Matrix(IsIntegerMatrix, [ [ 0, 1, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 1, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 1, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 1, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 1, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 1, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 1, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 1, 0 ], [ 1, 0, 0, 0, 0, 0, 0, 0, 0 ] ]) ] );
<commutative semigroup of 9x9 integer matrices with 1 generator>
gap> T := AsSemigroup(IsMaxPlusMatrixSemigroup, S);
<commutative semigroup of size 8, 9x9 max-plus matrices with 1 generator>
gap> Size(S) = Size(T);
true
gap> NrDClasses(S) = NrDClasses(T);
true
gap> NrRClasses(S) = NrRClasses(T);
true
gap> NrLClasses(S) = NrLClasses(T);
true
gap> NrIdempotents(S) = NrIdempotents(T);
true
gap> map := IsomorphismSemigroup(IsMaxPlusMatrixSemigroup, S);;
gap> BruteForceIsoCheck(map);
true
gap> BruteForceInverseCheck(map);
true

#T# AsSemigroup:
#   convert from IsTropicalMaxPlusMatrixSemigroup to IsMaxPlusMatrixSemigroup
gap> S := Semigroup( [ Matrix(IsTropicalMaxPlusMatrix, [ [ -infinity, 0, -infinity, -infinity, -infinity, -infinity, -infinity, -infinity, -infinity ], [ -infinity, -infinity, 0, -infinity, -infinity, -infinity, -infinity, -infinity, -infinity ], [ -infinity, -infinity, -infinity, 0, -infinity, -infinity, -infinity, -infinity, -infinity ], [ -infinity, -infinity, -infinity, -infinity, 0, -infinity, -infinity, -infinity, -infinity ], [ -infinity, -infinity, -infinity, -infinity, -infinity, 0, -infinity, -infinity, -infinity ], [ -infinity, -infinity, -infinity, -infinity, -infinity, -infinity, 0, -infinity, -infinity ], [ -infinity, -infinity, -infinity, -infinity, -infinity, -infinity, -infinity, 0, -infinity ], [ -infinity, -infinity, -infinity, -infinity, -infinity, -infinity, -infinity, 0, -infinity ], [ 0, -infinity, -infinity, -infinity, -infinity, -infinity, -infinity, -infinity, -infinity ] ], 2) ] );
<commutative semigroup of 9x9 tropical max-plus matrices with 1 generator>
gap> T := AsSemigroup(IsMaxPlusMatrixSemigroup, S);
<commutative semigroup of size 8, 9x9 max-plus matrices with 1 generator>
gap> Size(S) = Size(T);
true
gap> NrDClasses(S) = NrDClasses(T);
true
gap> NrRClasses(S) = NrRClasses(T);
true
gap> NrLClasses(S) = NrLClasses(T);
true
gap> NrIdempotents(S) = NrIdempotents(T);
true
gap> map := IsomorphismSemigroup(IsMaxPlusMatrixSemigroup, S);;
gap> BruteForceIsoCheck(map);
true
gap> BruteForceInverseCheck(map);
true

#T# AsSemigroup:
#   convert from IsTropicalMinPlusMatrixSemigroup to IsMaxPlusMatrixSemigroup
gap> S := Semigroup( [ Matrix(IsTropicalMinPlusMatrix, [ [ infinity, 0, infinity, infinity, infinity, infinity, infinity, infinity, infinity ], [ infinity, infinity, 0, infinity, infinity, infinity, infinity, infinity, infinity ], [ infinity, infinity, infinity, 0, infinity, infinity, infinity, infinity, infinity ], [ infinity, infinity, infinity, infinity, 0, infinity, infinity, infinity, infinity ], [ infinity, infinity, infinity, infinity, infinity, 0, infinity, infinity, infinity ], [ infinity, infinity, infinity, infinity, infinity, infinity, 0, infinity, infinity ], [ infinity, infinity, infinity, infinity, infinity, infinity, infinity, 0, infinity ], [ infinity, infinity, infinity, infinity, infinity, infinity, infinity, 0, infinity ], [ 0, infinity, infinity, infinity, infinity, infinity, infinity, infinity, infinity ] ], 4) ] );
<commutative semigroup of 9x9 tropical min-plus matrices with 1 generator>
gap> T := AsSemigroup(IsMaxPlusMatrixSemigroup, S);
<commutative semigroup of size 8, 9x9 max-plus matrices with 1 generator>
gap> Size(S) = Size(T);
true
gap> NrDClasses(S) = NrDClasses(T);
true
gap> NrRClasses(S) = NrRClasses(T);
true
gap> NrLClasses(S) = NrLClasses(T);
true
gap> NrIdempotents(S) = NrIdempotents(T);
true
gap> map := IsomorphismSemigroup(IsMaxPlusMatrixSemigroup, S);;
gap> BruteForceIsoCheck(map);
true
gap> BruteForceInverseCheck(map);
true

#T# AsSemigroup:
#   convert from IsNTPMatrixSemigroup to IsMaxPlusMatrixSemigroup
gap> S := Semigroup( [ Matrix(IsNTPMatrix, [ [ 0, 1, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 1, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 1, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 1, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 1, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 1, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 1, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 1, 0 ], [ 1, 0, 0, 0, 0, 0, 0, 0, 0 ] ], 3, 4) ] );
<commutative semigroup of 9x9 ntp matrices with 1 generator>
gap> T := AsSemigroup(IsMaxPlusMatrixSemigroup, S);
<commutative semigroup of size 8, 9x9 max-plus matrices with 1 generator>
gap> Size(S) = Size(T);
true
gap> NrDClasses(S) = NrDClasses(T);
true
gap> NrRClasses(S) = NrRClasses(T);
true
gap> NrLClasses(S) = NrLClasses(T);
true
gap> NrIdempotents(S) = NrIdempotents(T);
true
gap> map := IsomorphismSemigroup(IsMaxPlusMatrixSemigroup, S);;
gap> BruteForceIsoCheck(map);
true
gap> BruteForceInverseCheck(map);
true

# Test RandomSemigroup
gap> RandomSemigroup(IsMaxPlusMatrixSemigroup);;
gap> RandomSemigroup(IsMaxPlusMatrixSemigroup, 2);;
gap> RandomSemigroup(IsMaxPlusMatrixSemigroup, 2, 5);;
gap> RandomSemigroup(IsTropicalMaxPlusMatrixSemigroup);;
gap> RandomSemigroup(IsTropicalMaxPlusMatrixSemigroup, 2);;
gap> RandomSemigroup(IsTropicalMaxPlusMatrixSemigroup, 2, 5);;
gap> RandomSemigroup(IsTropicalMaxPlusMatrixSemigroup, 2, 2, 2);;
gap> RandomSemigroup(IsTropicalMaxPlusMatrixSemigroup, "a");
Error, Semigroups: RandomSemigroup: usage,
the second argument (number of generators) must be a pos int,
gap> RandomSemigroup(IsTropicalMaxPlusMatrixSemigroup, 2, "a");;
Error, Semigroups: RandomSemigroup: usage,
the third argument (matrix dimension) must be a pos int,
gap> RandomSemigroup(IsTropicalMaxPlusMatrixSemigroup, 2, 2, "a");;
Error, Semigroups: RandomSemigroup: usage,
the fourth argument (semiring threshold) must be a pos int,
gap> RandomSemigroup(IsTropicalMaxPlusMatrixSemigroup, 2, 2, 2, 2);;
Error, Semigroups: RandomSemigroup: usage,
there must be at most four arguments,
gap> RandomMonoid(IsMaxPlusMatrixMonoid);;
gap> RandomMonoid(IsMaxPlusMatrixMonoid, 2);;
gap> RandomMonoid(IsMaxPlusMatrixMonoid, 2, 5);;
gap> RandomMonoid(IsTropicalMaxPlusMatrixMonoid);;
gap> RandomMonoid(IsTropicalMaxPlusMatrixMonoid, 2);;
gap> RandomMonoid(IsTropicalMaxPlusMatrixMonoid, 2, 5);;
gap> RandomMonoid(IsTropicalMaxPlusMatrixMonoid, 2, 2, 2);;
gap> RandomMonoid(IsTropicalMaxPlusMatrixMonoid, "a");
Error, Semigroups: RandomMonoid: usage,
the second argument (number of generators) must be a pos int,
gap> RandomMonoid(IsTropicalMaxPlusMatrixMonoid, 2, "a");;
Error, Semigroups: RandomMonoid: usage,
the third argument (matrix dimension) must be a pos int,
gap> RandomMonoid(IsTropicalMaxPlusMatrixMonoid, 2, 2, "a");;
Error, Semigroups: RandomMonoid: usage,
the fourth argument (semiring threshold) must be a pos int,
gap> RandomMonoid(IsTropicalMaxPlusMatrixMonoid, 2, 2, 2, 2);;
Error, Semigroups: RandomMonoid: usage,
there must be at most four arguments,
gap> RandomSemigroup(IsNTPMatrixSemigroup);;
gap> RandomSemigroup(IsNTPMatrixSemigroup, 2);;
gap> RandomSemigroup(IsNTPMatrixSemigroup, 2, 5);;
gap> RandomSemigroup(IsNTPMatrixSemigroup, 2, 2, 2);;
gap> RandomSemigroup(IsNTPMatrixSemigroup, 2, 2, 2, 2);;
gap> RandomSemigroup(IsNTPMatrixSemigroup, "a");
Error, Semigroups: RandomSemigroup: usage,
the second argument (number of generators) must be a pos int,
gap> RandomSemigroup(IsNTPMatrixSemigroup, 2, "a");;
Error, Semigroups: RandomSemigroup: usage,
the third argument (matrix dimension) must be a pos int,
gap> RandomSemigroup(IsNTPMatrixSemigroup, 2, 2, "a");;
Error, Semigroups: RandomSemigroup: usage,
the fourth argument (semiring threshold) must be a pos int,
gap> RandomSemigroup(IsNTPMatrixSemigroup, 2, 2, 2, "a");;
Error, Semigroups: RandomSemigroup: usage,
the fifth argument (semiring period) must be a pos int,
gap> RandomSemigroup(IsNTPMatrixSemigroup, 2, 2, 2, 2, 2);;
Error, Semigroups: RandomSemigroup: usage,
there must be at most five arguments,
gap> RandomMonoid(IsNTPMatrixMonoid);;
gap> RandomMonoid(IsNTPMatrixMonoid, 2);;
gap> RandomMonoid(IsNTPMatrixMonoid, 2, 5);;
gap> RandomMonoid(IsNTPMatrixMonoid, 2, 2, 2);;
gap> RandomMonoid(IsNTPMatrixMonoid, 2, 2, 2, 2);;
gap> RandomMonoid(IsNTPMatrixMonoid, "a");
Error, Semigroups: RandomMonoid: usage,
the second argument (number of generators) must be a pos int,
gap> RandomMonoid(IsNTPMatrixMonoid, 2, "a");;
Error, Semigroups: RandomMonoid: usage,
the third argument (matrix dimension) must be a pos int,
gap> RandomMonoid(IsNTPMatrixMonoid, 2, 2, "a");;
Error, Semigroups: RandomMonoid: usage,
the fourth argument (semiring threshold) must be a pos int,
gap> RandomMonoid(IsNTPMatrixMonoid, 2, 2, 2, "a");;
Error, Semigroups: RandomMonoid: usage,
the fifth argument (semiring period) must be a pos int,
gap> RandomMonoid(IsNTPMatrixMonoid, 2, 2, 2, 2, 2);;
Error, Semigroups: RandomMonoid: usage,
there must be at most five arguments,

#T# IsFinite, IsTorsion, NormalizeSemigroup
gap> IsFinite(Semigroup(Matrix(IsMaxPlusMatrix,[[0,-3],[-2,-10]])));
true
gap> IsFinite(Semigroup(Matrix(IsMaxPlusMatrix, [[-infinity, 1, -infinity],
> [-infinity, -infinity, -infinity], [-infinity, 1, -infinity]])));
true
gap> IsFinite(Semigroup(Matrix(IsMaxPlusMatrix,
> [[1, -infinity, 2],[-2, 4, -infinity], [1, 0, 3]])));
false
gap> IsFinite(Semigroup(Matrix(IsMaxPlusMatrix, [[0, -infinity, -1],[0, -infinity, -4],
>  [-infinity, 0, -infinity]]), Matrix(IsMaxPlusMatrix, [[-2, -2, 0],[0, -infinity, -3],
>  [-5, 0, -infinity]]), Matrix(IsMaxPlusMatrix,
> [[-infinity, -infinity, -infinity],[0, 0, -infinity], [-5, 0, -infinity]])));
false
gap> IsFinite(Semigroup(Matrix(IsMinPlusMatrix, [[infinity, 0], [5, 4]])));
false
gap> IsFinite(Semigroup(Matrix(IsMinPlusMatrix, [[1, 0], [0, infinity]])));
true
gap> IsFinite(Semigroup(Matrix(IsMinPlusMatrix, [[infinity, -2], [2, 1]])));
true
gap> NormalizeSemigroup(Semigroup(Matrix(IsMaxPlusMatrix,[[0,-3],[-2,-10]])));
<commutative semigroup of 2x2 max-plus matrices with 1 generator>
gap> IsTorsion(Semigroup(Matrix(IsMaxPlusMatrix,[[0,-3],[-2,-10]])));
true
gap> IsTorsion(Semigroup(Matrix(IsMaxPlusMatrix,
> [[1, -infinity, 2],[-2, 4, -infinity], [1, 0, 3]])));
false

# AsMonoid
gap> S := AsSemigroup(IsMaxPlusMatrixSemigroup,
> Semigroup(Transformation([1, 2, 3, 3, 3])));
<commutative semigroup of 5x5 max-plus matrices with 1 generator>
gap> AsMonoid(S);
<trivial group of 1x1 max-plus matrices with 1 generator>
gap> S := AsSemigroup(IsMaxPlusMatrixSemigroup,
> Semigroup(Transformation([1, 1]), Transformation([2, 2])));
<semigroup of 2x2 max-plus matrices with 2 generators>
gap> AsMonoid(S);
fail
gap> S := AsSemigroup(IsTropicalMaxPlusMatrixSemigroup, 3, 
> Semigroup(Transformation([1, 2, 3, 3, 3])));
<commutative semigroup of 5x5 tropical max-plus matrices with 1 generator>
gap> AsMonoid(S);
<trivial group of 1x1 tropical max-plus matrices with 1 generator>
gap> S := AsSemigroup(IsTropicalMaxPlusMatrixSemigroup, 3, 
> Semigroup(Transformation([1, 1]), Transformation([2, 2])));
<semigroup of 2x2 tropical max-plus matrices with 2 generators>
gap> AsMonoid(S);
fail
gap> S := AsSemigroup(IsNTPMatrixSemigroup, 3, 4, 
> Semigroup(Transformation([1, 2, 3, 3, 3])));
<commutative semigroup of 5x5 ntp matrices with 1 generator>
gap> AsMonoid(S);
<trivial group of 1x1 ntp matrices with 1 generator>
gap> S := AsSemigroup(IsNTPMatrixSemigroup, 3, 4, 
> Semigroup(Transformation([1, 1]), Transformation([2, 2])));
<semigroup of 2x2 ntp matrices with 2 generators>
gap> AsMonoid(S);
fail

# IsomorphismMonoid
gap> IsomorphismMonoid(IsMaxPlusMatrixMonoid,
> Semigroup(Transformation([1, 2, 3, 3, 3])));
MappingByFunction( <commutative transformation semigroup of degree 5 with 1 
 generator>, <trivial group of 1x1 max-plus matrices with 1 generator>
, function( x ) ... end, function( x ) ... end )
gap> IsomorphismMonoid(IsTropicalMaxPlusMatrixMonoid, 3,
> Semigroup(Transformation([1, 2, 3, 3, 3])));
MappingByFunction( <commutative transformation semigroup of degree 5 with 1 
 generator>, <trivial group of 1x1 tropical max-plus matrices with 1 generator
 >, function( x ) ... end, function( x ) ... end )
gap> IsomorphismMonoid(IsNTPMatrixMonoid, 3, 4,
> Semigroup(Transformation([1, 2, 3, 3, 3])));
MappingByFunction( <commutative transformation semigroup of degree 5 with 1 
 generator>, <trivial group of 1x1 ntp matrices with 1 generator>
, function( x ) ... end, function( x ) ... end )

# FullTropicalMaxPlusMonoid
gap> FullTropicalMaxPlusMonoid(3, 1);
Error, Semigroups: FullTropicalMaxPlusMonoid: usage,
the dimension must be 2,
gap> S := FullTropicalMaxPlusMonoid(2, 1);
<monoid of 2x2 tropical max-plus matrices with 6 generators>
gap> Size(S);
81
gap> S := FullTropicalMaxPlusMonoid(2, 2);
<monoid of 2x2 tropical max-plus matrices with 9 generators>
gap> Size(S);
256
gap> S := FullTropicalMaxPlusMonoid(2, 3);
<monoid of 2x2 tropical max-plus matrices with 13 generators>
gap> Size(S);
625

# FullTropicalMinPlusMonoid
gap> S := FullTropicalMinPlusMonoid(2, 1);
<monoid of 2x2 tropical min-plus matrices with 5 generators>
gap> Size(S);
81
gap> S := FullTropicalMinPlusMonoid(2, 2);
<monoid of 2x2 tropical min-plus matrices with 6 generators>
gap> Size(S);
256
gap> S := FullTropicalMinPlusMonoid(2, 3);
<monoid of 2x2 tropical min-plus matrices with 7 generators>
gap> Size(S);
625
gap> S := FullTropicalMinPlusMonoid(3, 1);
<monoid of 3x3 tropical min-plus matrices with 11 generators>
gap> Size(S);
19683
gap> S := FullTropicalMinPlusMonoid(4, 3);
Error, Semigroups: FullTropicalMinPlusMonoid: usage,
the dimension must be 2 or 3,

#T# SEMIGROUPS_UnbindVariables
gap> Unbind(S);

#E#
gap> STOP_TEST("Semigroups package: standard/semimaxplus.tst");
