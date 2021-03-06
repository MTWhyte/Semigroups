############################################################################
##
##  congruences/conginv.gd
##  Copyright (C) 2015                                   Michael C. Torpey
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##
## This file contains methods for congruences on inverse semigroups, using the
## "kernel and trace" representation - see Howie 5.3
##

# Inverse Congruences By Kernel and Trace
DeclareCategory("IsInverseSemigroupCongruenceByKernelTrace",
                IsSemigroupCongruence and IsAttributeStoringRep and IsFinite);
DeclareGlobalFunction("InverseSemigroupCongruenceByKernelTrace");
DeclareGlobalFunction("InverseSemigroupCongruenceByKernelTraceNC");

DeclareAttribute("TraceOfSemigroupCongruence", IsSemigroupCongruence);
DeclareAttribute("KernelOfSemigroupCongruence", IsSemigroupCongruence);
DeclareAttribute("AsInverseSemigroupCongruenceByKernelTrace",
                 IsSemigroupCongruence);
DeclareAttribute("InverseSemigroupCongruenceClassByKernelTraceType",
                 IsInverseSemigroupCongruenceByKernelTrace);

# Congruence Classes
DeclareCategory("IsInverseSemigroupCongruenceClassByKernelTrace",
                IsCongruenceClass and IsAttributeStoringRep and
                IsMultiplicativeElement);

# Special congruences
DeclareAttribute("MinimumGroupCongruence",
                 IsInverseSemigroup and IsGeneratorsOfInverseSemigroup);
