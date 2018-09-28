# Cross Compiler setup

Started off using instructions from https://github.com/cfenollosa/os-tutorial/tree/master/11-kernel-crosscompiler which fell apart.

Then used a combination of https://wiki.osdev.org/GCC_Cross-Compiler#Why_do_I_need_a_Cross_Compiler.3F and several other sources to hack my way to the solution


## Steps
Pick a combination of tested GCC and Binutils from https://wiki.osdev.org/Cross-Compiler_Successful_Builds#GCC_Version_7.x.x  
After failing a few times with GCC-8.2.0 and Binutils-2.24 I decided to go with GCC-7.3.0 and Binutils-2.30

You need `gcc` installed to be able to build a cross-compiled gcc. If the version you choose to use is the latest, simply `brew install gcc`. At the time of writing, that installed `gcc-8` (actually `gcc@8.2.0`) which was a big headache. You can find older brew formulae still available for download with `brew search gcc` and installing with `brew install gcc@X`. I used `brew install gcc-7`.



```
mkdir /tmp/src
cd /tmp/src
curl -O http://ftp.gnu.org/gnu/binutils/binutils-2.30.tar.gz # If the link 404's, look for a more recent version
tar xf binutils-2.30.tar.gz
mkdir binutils-build
cd binutils-build
../binutils-2.30/configure --target=$TARGET --enable-interwork --enable-multilib --disable-nls --disable-werror --prefix=$i386PREFIX 2>&1 | tee configure.log
make all install 2>&1 | tee make.log
```

```
cd /tmp/src
curl -O https://ftp.gnu.org/gnu/gcc/gcc-7.3.0/gcc-7.3.0.tar.gz
tar xf gcc-7.3.0.tar.gz
mkdir gcc-build
cd gcc-build
../gcc-7.3.0/configure --target=$TARGET --prefix="$i386PREFIX" --disable-nls --disable-libssp --enable-languages=c --without-headers 2>&1 | tee configure.log
make all-gcc 2>&1 | tee all-gcc.log
make all-target-libgcc 2>&1 | tee all-target.log
make install-gcc 2>&1 | tee install-gcc.log
make install-target-libgcc 2>&1 | tee install-target-libgcc.log
```