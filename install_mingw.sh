#!/bin/sh

set -e

#cd /usr/bin
#patch -p0 -i /usr/share/makepkg-asroot/makepkg-asroot.patch




function install_conflict {

cat > /tmp/conflict.sh << EOF
#!/usr/bin/expect -f
spawn pacman -U $1
expect " are in conflict. Remove "
sleep 1
send "y\r"
expect "Proceed with installation"
sleep 1
send "Y\r"
expect eof
EOF

chmod a+rx /tmp/conflict.sh
/tmp/conflict.sh
}

gpg --recv D605848ED7E69871 D9C4D26D0E604491 0223A078DBFF4B66 BB5869F064EA74AB # gettext, openssl, dbus, readline

# remove all
yaourt -Rscnd mingw-w64 --noconfirm || echo "already clean" 

# update
yaourt -Syu --noconfirm

yaourt -S mingw-w64-gcc --noconfirm
yaourt -S mingw-w64-exprtk-git --noconfirm
yaourt -S mingw-w64-dlfcn  --noconfirm
yaourt -S mingw-w64-libsvm --noconfirm
yaourt -S mingw-w64-libgnurx --noconfirm
yaourt -S mingw-w64-muparser --noconfirm
yaourt -S mingw-w64-arpack++ --noconfirm
yaourt -S mingw-w64-fann --noconfirm
yaourt -S mingw-w64-intel-tbb --noconfirm
yaourt -S mingw-w64-libmixmod --noconfirm
yaourt -S mingw-w64-nlopt --noconfirm
yaourt -S mingw-w64-libxml2 --noconfirm
yaourt -S mingw-w64-lapack --noconfirm
yaourt -S mingw-w64-hmat-oss --noconfirm
yaourt -S mingw-w64-fftw --noconfirm
yaourt -S mingw-w64-python-bin --noconfirm
yaourt -S mingw-w64-python2-bin --noconfirm
yaourt -S mingw-w64-python26-bin --noconfirm
yaourt -S mingw-w64-boost --noconfirm --tmp $PWD
yaourt -S mingw-w64-agrum --noconfirm
yaourt -S mingw-w64-libzip --noconfirm
yaourt -S mingw-w64-qt4 --noconfirm --tmp $PWD || { rm /usr/*-w64-mingw32/bin/Qt*.dll; pacman -U yaourt-tmp-root/mingw-w64-qt4-*.pkg.tar.xz --noconfirm; rm -r yaourt-tmp-root; }
yaourt -S mingw-w64-qscintilla-qt4 --noconfirm
yaourt -S mingw-w64-qwt --noconfirm
yaourt -S mingw-w64-iistaskpanel --noconfirm

