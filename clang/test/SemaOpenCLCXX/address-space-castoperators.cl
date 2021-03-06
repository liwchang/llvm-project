//RUN: %clang_cc1 %s -cl-std=clc++ -pedantic -ast-dump -verify | FileCheck %s

void nester_ptr() {
  local int * * locgen;
  constant int * * congen;
  int * * gengen;

  gengen = const_cast<int**>(locgen); //expected-error{{const_cast from '__local int *__generic *' to '__generic int *__generic *' is not allowed}}
  gengen = static_cast<int**>(locgen); //expected-error{{static_cast from '__local int *__generic *' to '__generic int *__generic *' is not allowed}}
// CHECK-NOT: AddressSpaceConversion
  gengen = reinterpret_cast<int**>(locgen); //expected-warning{{reinterpret_cast from '__local int *__generic *' to '__generic int *__generic *' changes address space of nested pointers}}
}
