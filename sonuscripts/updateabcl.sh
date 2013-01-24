BASEDIR="/opt/lisp/cl/"

pushd ${BASEDIR}
svn co svn://common-lisp.net/project/armedbear/svn/trunk/abcl abcl
#cp customizations.lisp.in customizations.lisp
pushd ${BASEDIR}/abcl
./sonubuildabcl.lisp
popd
popd
