// Isn't the function f in the response above just a mapping from a domain of lists of some type which
// satisfies the equations of the typeclass Num a to the range of 2-tuples of Double and Int?  Wouldn't be
// such a thing almost trivial with something like templates in C++ and probably any language with the
// facility for OO paradigm and perhaps the facility for metaprogramming too?

template<class A = List<TypclassA>, class FirstArgumentOfTuple, class SecondArgumentOfTuple> class f {
  Tuple<FirstArgumentOfTuple,SecondArgumentOfTuple> result(A x)
