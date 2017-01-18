#############################################################################
##
#W  properties.gd
#Y  Copyright (C) 2013-15                                James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

# This file contains methods for determining properties of arbitrary
# semigroups. There are not very many specialised methods for acting semigroups
# and so we only have a single file.

#DeclareProperty("IsAbundantSemigroup", IsSemigroup);
#DeclareProperty("IsAdequateSemigroup", IsSemigroup);

DeclareProperty("IsBlockGroup", IsSemigroup);
DeclareProperty("IsRTrivial", IsSemigroup);
DeclareProperty("IsLTrivial", IsSemigroup);
DeclareProperty("IsHTrivial", IsSemigroup);

DeclareSynonymAttr("IsDTrivial", IsRTrivial and IsLTrivial);
DeclareSynonymAttr("IsAperiodicSemigroup", IsHTrivial);
DeclareSynonymAttr("IsCombinatorialSemigroup", IsHTrivial);
DeclareProperty("IsFactorisableInverseMonoid", IsSemigroup);
DeclareProperty("IsLeftSimple", IsSemigroup);
DeclareProperty("IsMonogenicInverseSemigroup", IsSemigroup);
DeclareProperty("IsMonogenicMonoid", IsMonoid);
DeclareProperty("IsMonogenicInverseMonoid", IsMonoid);
DeclareOperation("IsRegularSemigroupElementNC",
                 [IsSemigroup, IsMultiplicativeElement]);
DeclareProperty("IsRightSimple", IsSemigroup);
DeclareProperty("IsSemigroupWithCommutingIdempotents", IsSemigroup);
DeclareProperty("IsUnitRegularMonoid", IsSemigroup);
DeclareProperty("IsZeroRectangularBand", IsSemigroup);
DeclareProperty("IsCongruenceFreeSemigroup", IsSemigroup);
DeclareProperty("IsEUnitaryInverseSemigroup", IsInverseSemigroup);
DeclareProperty("IsSemigroupWithAdjoinedZero", IsSemigroup);

DeclareSynonymAttr("IsRectangularGroup",
                   IsOrthodoxSemigroup and IsSimpleSemigroup);

InstallTrueMethod(IsGeneratorsOfInverseSemigroup, 
                  IsInverseSemigroup and IsPartialPermSemigroup);
InstallTrueMethod(IsGeneratorsOfInverseSemigroup, 
                  IsInverseSemigroup and IsBlockBijectionSemigroup);
InstallTrueMethod(IsGeneratorsOfInverseSemigroup, 
                  IsInverseSemigroup and IsPartialPermBipartitionSemigroup);

InstallTrueMethod(IsSemigroupWithCommutingIdempotents, IsCommutativeSemigroup);
InstallTrueMethod(IsSemigroupWithCommutingIdempotents, IsInverseSemigroup);
InstallTrueMethod(IsSemigroupWithCommutingIdempotents, IsPartialPermSemigroup);
InstallTrueMethod(IsSemigroupWithCommutingIdempotents, IsBlockBijectionSemigroup);
InstallTrueMethod(IsSemigroupWithCommutingIdempotents, IsNilpotentSemigroup);
InstallTrueMethod(IsBlockGroup, IsSemigroupWithCommutingIdempotents);
InstallTrueMethod(IsDTrivial, IsSemilattice);
InstallTrueMethod(IsHTrivial, IsLTrivial);
InstallTrueMethod(IsHTrivial, IsRTrivial);
InstallTrueMethod(IsInverseMonoid, IsInverseSemigroup and IsMonoid);
InstallTrueMethod(IsLeftSimple, IsInverseSemigroup and IsGroupAsSemigroup);
InstallTrueMethod(IsLeftZeroSemigroup, IsSemigroup and IsTrivial);
InstallTrueMethod(IsRightZeroSemigroup, IsSemigroup and IsTrivial);
InstallTrueMethod(IsZeroSemigroup, IsSemigroup and IsTrivial);
InstallTrueMethod(IsNilpotentSemigroup, IsZeroSemigroup);
InstallTrueMethod(IsNilpotentSemigroup, IsSemigroup and IsTrivial);
InstallTrueMethod(IsLTrivial, IsInverseSemigroup and IsRTrivial);
InstallTrueMethod(IsLTrivial, IsDTrivial);
InstallTrueMethod(IsRectangularBand,
                  IsHTrivial and IsCompletelySimpleSemigroup);
InstallTrueMethod(IsRegularSemigroup, IsBand);
InstallTrueMethod(IsRightSimple, IsInverseSemigroup and IsGroupAsSemigroup);
InstallTrueMethod(IsRTrivial, IsInverseSemigroup and IsLTrivial);
InstallTrueMethod(IsRTrivial, IsDTrivial);
InstallTrueMethod(IsSemilattice, IsDTrivial and IsInverseSemigroup);
InstallTrueMethod(IsMonogenicInverseSemigroup,
                  IsInverseSemigroup and IsMonogenicSemigroup);
InstallTrueMethod(IsZeroRectangularBand, IsZeroGroup);
InstallTrueMethod(IsZeroGroup, IsZeroRectangularBand and IsInverseSemigroup);
InstallTrueMethod(IsRegularSemigroup, IsRegularStarSemigroup);
InstallTrueMethod(IsInverseSemigroup, IsGroup);
InstallTrueMethod(IsInverseSemigroup, IsBlockGroup and IsRegularSemigroup);
InstallTrueMethod(IsCommutativeSemigroup, IsZeroSemigroup);
InstallTrueMethod(IsCommutativeSemigroup, IsCommutative);
InstallTrueMethod(IsCommutative, IsCommutativeSemigroup);
InstallTrueMethod(IsTrivial,
                  IsLeftZeroSemigroup and IsRightZeroSemigroup);
InstallTrueMethod(IsBand, IsRectangularBand);
InstallTrueMethod(IsCompletelySimpleSemigroup, IsSimpleSemigroup and IsFinite);
InstallTrueMethod(IsSemigroupWithAdjoinedZero, IsSemigroup and IsZeroGroup);
