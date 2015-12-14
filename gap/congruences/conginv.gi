############################################################################
##
#W  congruences/conginv.gi
#Y  Copyright (C) 2015                                   Michael C. Torpey
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##
## This file contains methods for congruences on inverse semigroups, using the
## "kernel and trace" representation - see Howie 5.3
##

InstallGlobalFunction(InverseSemigroupCongruenceByKernelTrace,
[IsInverseSemigroup and IsFinite, IsInverseSemigroup, IsDenseList],
function(S, kernel, traceBlocks)
  local a, x, traceClass, f, l, e;
  # Check that the kernel is an inverse subsemigroup
  if not IsInverseSubsemigroup(S, kernel) then
    ErrorMayQuit("Semigroups: InverseSemigroupCongruenceByKernelTrace: ",
                 "usage,\nthe second arg <kernel> must be an inverse ",
                 "subsemigroup of the\nfirst arg <S>,");
  fi;
  # CHECK KERNEL IS NORMAL:
  # (1) Must contain all the idempotents of S
  if NrIdempotents(kernel) <> NrIdempotents(S) then
    ErrorMayQuit("Semigroups: InverseSemigroupCongruenceByKernelTrace: ",
                 "usage,\n",
                 "the second arg <kernel> must contain all the\n",
                 "idempotents of the first arg <S>,");
  fi;
  # (2) Must be self-conjugate
  for a in kernel do
    for x in GeneratorsOfSemigroup(S) do
      if not a ^ x in kernel then
        ErrorMayQuit("Semigroups: InverseSemigroupCongruenceByKernelTrace: ",
                     "usage,\nthe second arg <kernel> must be self-conjugate,");
      fi;
    od;
  od;
  # Check conditions for a congruence pair: Howie p.156
  for traceClass in traceBlocks do
    for f in traceClass do
      l := LClass(S, f);
      for a in l do
        if a in kernel then
          # Condition (C2): aa' related to a'a
          if not a * a ^ -1 in traceClass then
            ErrorMayQuit("Semigroups: ",
                         "InverseSemigroupCongruenceByKernelTrace:\n",
                         "not a valid congruence pair (C2),");
          fi;
        else
          # Condition (C1): (ae in kernel && e related to a'a) => a in kernel
          for e in traceClass do
            if a * e in kernel then
              ErrorMayQuit("Semigroups: ",
                           "InverseSemigroupCongruenceByKernelTrace:\n",
                           "not a valid congruence pair (C1),");
            fi;
          od;
        fi;
      od;
    od;
  od;
  return InverseSemigroupCongruenceByKernelTraceNC(S, kernel, traceBlocks);
end);

#

InstallGlobalFunction(InverseSemigroupCongruenceByKernelTraceNC,
[IsInverseSemigroup and IsFinite, IsSemigroup, IsDenseList],
function(S, kernel, traceBlocks)
  local traceLookup, i, elm, fam, cong;
  # Calculate lookup table for trace
  # Might remove lookup - might never be better than blocks
  traceLookup := [];
  for i in [1 .. Length(traceBlocks)] do
    for elm in traceBlocks[i] do
      traceLookup[Position(Idempotents(S), elm)] := i;
    od;
  od;
  # Construct the object
  fam := GeneralMappingsFamily(ElementsFamily(FamilyObj(S)),
                               ElementsFamily(FamilyObj(S)));
  cong := Objectify(NewType(fam, IsInverseSemigroupCongruenceByKernelTrace),
                    rec(kernel := kernel,
                        traceBlocks := traceBlocks,
                        traceLookup := traceLookup));
  SetSource(cong, S);
  SetRange(cong, S);
  return cong;
end);

#

InstallMethod(ViewObj,
"for inverse semigroup congruence",
[IsInverseSemigroupCongruenceByKernelTrace],
function(cong)
  Print("<semigroup congruence over ");
  ViewObj(Range(cong));
  Print(" with congruence pair (",
        Size(cong!.kernel), ",",
        Size(cong!.traceBlocks), ")>");
end);

#

InstallMethod(\=,
"for two inverse semigroup congruences",
[IsInverseSemigroupCongruenceByKernelTrace,
 IsInverseSemigroupCongruenceByKernelTrace],
function(cong1, cong2)
  return(Range(cong1) = Range(cong2) and
         cong1!.kernel = cong2!.kernel and
         cong1!.traceBlocks = cong2!.traceBlocks);
end);

#

InstallMethod(IsSubrelation,
"for two inverse semigroup congruences",
[IsInverseSemigroupCongruenceByKernelTrace,
 IsInverseSemigroupCongruenceByKernelTrace],
function(cong1, cong2)
  # Tests whether cong2 is a subcongruence of cong1
  if Range(cong1) <> Range(cong2) then
    ErrorMayQuit("Semigroups: IsSubrelation: usage,\n",
                 "congruences must be defined over the same semigroup,");
  fi;
  return IsSubsemigroup(cong1!.kernel, cong2!.kernel)
         and ForAll(cong2!.traceBlocks,
                    b2 -> ForAny(cong1!.traceBlocks, b1 -> IsSubset(b1, b2)));
end);

#

InstallMethod(ImagesElm,
"for inverse semigroup congruence and associative element",
[IsInverseSemigroupCongruenceByKernelTrace, IsAssociativeElement],
function(cong, elm)
  local S, images, e, b;
  S := Range(cong);
  if not elm in S then
    ErrorMayQuit("Semigroups: ImagesElm: usage,\n",
                 "the first arg <cong> is not defined over the semigroup of ",
                 "the second\nargument <elm>,");
  fi;
  images := [];
  # Consider all idempotents trace-related to (a^-1 a)
  for e in First(cong!.traceBlocks, c -> (elm ^ -1 * elm) in c) do
    for b in LClass(S, e) do
      if elm * b ^ -1 in cong!.kernel then
        Add(images, b);
      fi;
    od;
  od;
  return images;
end);

#

InstallMethod(\in,
"for dense list and inverse semigroup congruence",
[IsDenseList, IsInverseSemigroupCongruenceByKernelTrace],
function(pair, cong)
  local S;
  if Size(pair) <> 2 then
    ErrorMayQuit("Semigroups: \\in: usage,\n",
                 "the first arg <pair> must be a list of length 2,");
  fi;
  S := Range(cong);
  if not (pair[1] in S and pair[2] in S) then
    ErrorMayQuit("Semigroups: \\in: usage,\n",
                 "the entries of the first arg <pair> must\n",
                 "belong to the semigroup of <cong>,");
  fi;
  # Is (a^-1 a, b^-1 b) in the trace?
  if pair[1] ^ -1 * pair[1] in
      First(cong!.traceBlocks, c -> pair[2] ^ -1 * pair[2] in c) then
    # Is ab^-1 in the kernel?
    if pair[1] * pair[2] ^ -1 in cong!.kernel then
      return true;
    fi;
  fi;
  return false;
end);

#

InstallMethod(EquivalenceClassOfElement,
"for inverse semigroup congruence and associative element",
[IsInverseSemigroupCongruenceByKernelTrace, IsAssociativeElement],
function(cong, elm)
  if not elm in Range(cong) then
    ErrorMayQuit("Semigroups: EquivalenceClassOfElement: usage,\n",
                 "the second arg <elm> must be in the\n",
                 "semigroup of the first arg <cong>,");
  fi;
  return EquivalenceClassOfElementNC(cong, elm);
end);

#

InstallMethod(EquivalenceClassOfElementNC,
"for inverse semigroup congruence and associative element",
[IsInverseSemigroupCongruenceByKernelTrace, IsAssociativeElement],
function(cong, elm)
  local fam, class;
  fam := FamilyObj(Range(cong));
  class := Objectify(NewType(fam,
                     IsInverseSemigroupCongruenceClassByKernelTrace),
                     rec(rep := elm));
  SetParentAttr(class, Range(cong));
  SetEquivalenceClassRelation(class, cong);
  SetRepresentative(class, elm);
  return class;
end);

#

InstallMethod(\=,
"for two inverse semigroup congruence classes",
[IsInverseSemigroupCongruenceClassByKernelTrace,
 IsInverseSemigroupCongruenceClassByKernelTrace],
function(c1, c2)
  return(EquivalenceClassRelation(c1) = EquivalenceClassRelation(c2) and
          [c1!.rep, c2!.rep] in EquivalenceClassRelation(c1));
end);

#

InstallMethod(\in,
"for associative element and inverse semigroup congruence class",
[IsAssociativeElement, IsInverseSemigroupCongruenceClassByKernelTrace],
function(elm, class)
  local cong;
  cong := EquivalenceClassRelation(class);
  return elm in Range(cong) and [elm, class!.rep] in cong;
end);

#

InstallMethod(\*,
"for two inverse semigroup congruence classes",
[IsInverseSemigroupCongruenceClassByKernelTrace,
 IsInverseSemigroupCongruenceClassByKernelTrace],
function(c1, c2)
  if not EquivalenceClassRelation(c1) = EquivalenceClassRelation(c2) then
    ErrorMayQuit("Semigroups: \\*: usage,\n",
                 "the arguments must be classes of the same congruence,");
  fi;
  return EquivalenceClassOfElementNC(EquivalenceClassRelation(c1),
                                     c1!.rep * c2!.rep);
end);

#

InstallMethod(AsSSortedList,
"for inverse semigroup congruence class",
[IsInverseSemigroupCongruenceClassByKernelTrace],
function(class)
  return SSortedList(ImagesElm(EquivalenceClassRelation(class), class!.rep));
end);

#

InstallMethod(Size,
"for inverse semigroup congruence class",
[IsInverseSemigroupCongruenceClassByKernelTrace],
function(class)
  return Size(Elements(class));
end);

#

InstallMethod(TraceOfSemigroupCongruence,
"for semigroup congruence",
[IsSemigroupCongruence],
function(cong)
  local S, elms, trace, i, class, congClass, j;
  S := Range(cong);
  if not IsInverseSemigroup(S) then
    ErrorMayQuit("Semigroups: TraceOfSemigroupCongruence: usage,\n",
                 "the argument <cong> must be over an inverse semigroup,");
  fi;
  elms := ShallowCopy(Idempotents(S));
  trace := [];
  for i in [1 .. Size(elms)] do
    if elms[i] <> fail then
      class := [elms[i]];
      congClass := EquivalenceClassOfElementNC(cong, elms[i]);
      for j in [i + 1 .. Size(elms)] do
        if elms[j] in congClass then
          Add(class, elms[j]);
          elms[j] := fail;
        fi;
      od;
      Add(trace, class);
    fi;
  od;
  return trace;
end);

# FIXME this method should be updated, in case that the congruence is given by
# a congruence pair.

InstallMethod(KernelOfSemigroupCongruence,
"for semigroup congruence",
[IsSemigroupCongruence],
function(cong)
  local S, gens;
  S := Range(cong);
  if not IsInverseSemigroup(S) then
    ErrorMayQuit("Semigroups: KernelOfSemigroupCongruence: usage,\n",
                 "the first arg <cong> must be over an inverse semigroup,");
  fi;
  gens := Union(List(Idempotents(S),
                     e -> EquivalenceClassOfElementNC(cong, e)));
  return InverseSemigroup(gens, rec(small := true));
end);

#

InstallMethod(AsInverseSemigroupCongruenceByKernelTrace,
"for semigroup congruence with generating pairs",
[IsSemigroupCongruence and HasGeneratingPairsOfMagmaCongruence],
function(cong)
  local S, idsmgp, idsdata, idslist, slist, pos, hashlen, ht, treehashsize, 
        right, left, genstoapply, NormalClosureInverseSemigroup, 
        enumerate_trace, enforce_conditions, compute_kernel, genpairs, 
        pairstoapply, kernelgenstoapply, nr, nrk, traceUF, kernel, oldLookup, 
        oldKernel, trace_unchanged, kernel_unchanged, traceBlocks;

  # Check that the argument makes sense
  S := Range(cong);
  if not IsInverseSemigroup(S) then
    ErrorMayQuit("Semigroups: AsInverseSemigroupCongruenceByKernelTrace: ",
                 "usage,\n",
                 "the argument <cong> must be over an inverse semigroup,");
  fi;

  # Setup some data structures for the trace
  idsmgp := IdempotentGeneratedSubsemigroup(S);
  idsdata := GenericSemigroupData(idsmgp);
  idslist := SEMIGROUP_ELEMENTS(idsdata, infinity);

  slist := SEMIGROUP_ELEMENTS(GenericSemigroupData(S), infinity);

  pos := 0;
  hashlen := SEMIGROUPS.OptionsRec(S).hashlen.L;
  ht := HTCreate([1, 1], rec(forflatplainlists := true,
                             treehashsize := hashlen));
  right := RightCayleyGraphSemigroup(idsmgp);
  left := LeftCayleyGraphSemigroup(idsmgp);
  genstoapply := [1 .. Length(right[1])];

  NormalClosureInverseSemigroup := function(S, K, coll)
    # This takes an inv smgp S, an inv subsemigroup K, and some elms coll,
    # then creates the *normal closure* of K with coll inside S.
    # It assumes K is already normal.
    local T, opts, x;
    T := ClosureInverseSemigroup(K, coll);
    while K <> T do
      K := T;
      opts := rec();
      opts.gradingfunc := function(o, x)
        return x in K;
      end;
      opts.onlygrades := function(x, data)
        return x = false;
      end;
      opts.onlygradesdata := fail;
      for x in K do
        T := ClosureInverseSemigroup(T, AsList(Orb(GeneratorsOfSemigroup(S),
                                                   x, POW, opts)));
      od;
    od;
    return K;
  end;

  enumerate_trace := function()
    local x, a, y, j;
    if pos = 0 then
      # Add the generating pairs themselves
      for x in pairstoapply do
        if x[1] <> x[2] and HTValue(ht, x) = fail then
          HTAdd(ht, x, true);
          UF_UNION(traceUF, x);
          # Add each pair's "conjugate" pairs
          for a in GeneratorsOfSemigroup(S) do
            y := [Position(idsdata, a ^ -1 * idslist[x[1]] * a),
                  Position(idsdata, a ^ -1 * idslist[x[2]] * a)];
            if y[1] <> y[2] and HTValue(ht, y) = fail then
              HTAdd(ht, y, true);
              nr := nr + 1;
              pairstoapply[nr] := y;
              UF_UNION(traceUF, y);
            fi;
          od;
        fi;
      od;
    fi;

    while pos < nr do
      pos := pos + 1;
      x := pairstoapply[pos];
      for j in genstoapply do
        # Add the pair's left-multiples
        y := [right[x[1]][j], right[x[2]][j]];
        if y[1] <> y[2] and HTValue(ht, y) = fail then
          HTAdd(ht, y, true);
          nr := nr + 1;
          pairstoapply[nr] := y;
          UF_UNION(traceUF, y);
        fi;

        # Add the pair's right-multiples
        y := [left[x[1]][j], left[x[2]][j]];
        if y[1] <> y[2] and HTValue(ht, y) = fail then
          HTAdd(ht, y, true);
          nr := nr + 1;
          pairstoapply[nr] := y;
          UF_UNION(traceUF, y);
        fi;
      od;
    od;
    UF_FLATTEN(traceUF);
  end;

  enforce_conditions := function()
    local traceTable, traceBlocks, a, e, f, classno;
    traceTable := UF_TABLE(traceUF);
    traceBlocks := UF_BLOCKS(traceUF);
    for a in slist do
      if a in kernel then
        e := Position(idsdata, LeftOne(a));
        f := Position(idsdata, RightOne(a));
        if traceTable[e] <> traceTable[f] then
          nr := nr + 1;
          pairstoapply[nr] := [e, f];
          #UF_UNION(traceUF, [e,f]);
        fi;
      else
        classno := traceTable[Position(idsdata, RightOne(a))];
        for e in traceBlocks[classno] do
          if a * idslist[e] in kernel then
            nrk := nrk + 1;
            AddSet(kernelgenstoapply, a);
          fi;
        od;
      fi;
    od;
  end;

  compute_kernel := function()
    # Take the normal closure inverse semigroup containing the new elements
    if kernelgenstoapply <> [] then
      kernel := NormalClosureInverseSemigroup(S, kernel,
                                              kernelgenstoapply);
      Elements(kernel);
      kernelgenstoapply := [];
      nrk := 0;
    fi;
  end;

  # Retrieve the initial information
  genpairs := GeneratingPairsOfSemigroupCongruence(cong);
  pairstoapply := List(genpairs, x -> [Position(idsdata, RightOne(x[1])),
                                       Position(idsdata, RightOne(x[2]))]);
  kernelgenstoapply := Set(genpairs, x -> x[1] * x[2] ^ -1);
  nr := Length(pairstoapply);
  nrk := Length(kernelgenstoapply);
  traceUF := UF_NEW(Length(idslist));
  kernel := IdempotentGeneratedSubsemigroup(S);
  Elements(kernel);

  # Keep applying the method until no new info is found
  repeat
    oldLookup := StructuralCopy(UF_TABLE(traceUF));
    oldKernel := kernel;
    compute_kernel();
    enforce_conditions();
    enumerate_trace();
    trace_unchanged := (oldLookup = UF_TABLE(traceUF));
    kernel_unchanged := (oldKernel = kernel);
    Info(InfoSemigroups, 2, "lookup: ", trace_unchanged);
    Info(InfoSemigroups, 2, "kernel: ", kernel_unchanged);
    Info(InfoSemigroups, 2, "nrk = 0: ", nrk = 0);
  until trace_unchanged and kernel_unchanged and (nrk = 0);

  # Convert traceLookup to traceBlocks
  traceBlocks := List(Compacted(UF_BLOCKS(traceUF)),
                      b -> List(b, i -> idslist[i]));

  #TODO: Change this to NC
  return InverseSemigroupCongruenceByKernelTrace(S, kernel, traceBlocks);
end);
