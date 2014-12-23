# Inverse Congruences By Congruence Pair
DeclareCategory("SEMIGROUPS_CONG_INVERSE",
        IsSemigroupCongruence and IsAttributeStoringRep);
DeclareGlobalFunction("InverseSemigroupCongruenceByCongruencePair");
DeclareGlobalFunction("InverseSemigroupCongruenceByCongruencePairNC");

DeclareAttribute("TraceOfSemigroupCongruence", IsSemigroupCongruence);
DeclareAttribute("KernelOfSemigroupCongruence", IsSemigroupCongruence);
DeclareAttribute("AsInverseSemigroupCongruenceByCongruencePair",
        IsSemigroupCongruence);

DeclareGlobalFunction("INVERSECONG_FROM_PAIRS");

# Congruence Classes
DeclareCategory("SEMIGROUPS_CONGCLASS_INVERSE",
        IsEquivalenceClass and IsAttributeStoringRep and IsAssociativeElement);
DeclareOperation("InverseSemigroupCongruenceClass",
        [SEMIGROUPS_CONG_INVERSE, IsAssociativeElement] );
DeclareOperation("InverseSemigroupCongruenceClassNC",
        [SEMIGROUPS_CONG_INVERSE, IsAssociativeElement] );
