;;;; various array operations that are too expensive (in space) to do
;;;; inline

;;;; This software is part of the SBCL system. See the README file for
;;;; more information.
;;;;
;;;; This software is derived from the CMU CL system, which was
;;;; written at Carnegie Mellon University and released into the
;;;; public domain. The software is in the public domain and is
;;;; provided with absolutely no warranty. See the COPYING and CREDITS
;;;; files for more information.

(in-package "SB!VM")

;;;; Note: On other platforms ALLOCATE-VECTOR is an assembly routine,
;;;; but on X86 it is a VOP.

;;;; Note: CMU CL had assembly language primitives for hashing strings,
;;;; but SBCL doesn't.
