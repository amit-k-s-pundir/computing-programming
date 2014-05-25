# adjust to taste (if you choose a dir with spaces, adjust quoting)
basedir=$HOME/tools/gcc
version=4.8-20121209

set -e

sudo apt-get install libmpfr-dev libgmp-dev
mkdir -p $basedir $basedir/build $basedir/inst
cd $basedir
test -f gcc-$version.tar.bz2 || wget ftp://gcc.gnu.org/pub/gcc/snapshots/$version/gcc-$version.tar.bz2
tar xf gcc-$version.tar.bz2
cd build
../gcc-$version/configure -C --enable-languages=c,c++ --disable-bootstrap --disable-multilib --prefix=$basedir/inst
make -j2
make install

export PATH=$basedir/inst/bin:$PATH
if [ -n "$LD_LIBRARY_PATH" ]; then
    export LD_LIBRARY_PATH=$basedir/inst/lib64:$LD_LIBRARY_PATH
else
    export LD_LIBRARY_PATH=$basedir/inst/lib64
fi
a
