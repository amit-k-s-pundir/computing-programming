BASE_DIR=/opt/lisp/cl/sources/ecls

pushd $BASE_DIR
ADDRESS=anonymous@ecls.cvs.sourceforge.net:/cvsroot/ecls
cvs -z3 -d:pserver:$ADDRESS checkout ecl
cvs -z3 -d:pserver:$ADDRESS checkout ecl-doc
popd
