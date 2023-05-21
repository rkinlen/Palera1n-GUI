#!/usr/bin/env bash
# made by @ios_euphoria dependencies fix 4 test for all mac os
 
 
#Part 1
export PATH=/usr/local/bin:$PATH
which brew > /dev/null
if [ $? -ne 0 ]; then
    # Check for Homebrew, install if we don't have it
    if test ! $(which brew); then
        echo "Installing homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo ''
    fi
fi
 
echo Dependencies need full access to install more dependencies lol
echo Enter your Mac login password:
sudo -v
 
sudo rm -rf dependencies
sudo mkdir dependencies
cd dependencies
sudo mkdir libimobiledevice
cd libimobiledevice
 
echo "If Xcode launches... INSTALL IT!!!"
xcode-select --install
echo "Xcode done."
 
echo " "
echo Install the Command Line Tools if prompted.
echo If you see an xcode error ignore it.
echo " "
 
brew install libusb
brew install libtool
brew install automake
brew install curl
brew reinstall libxml2
 
echo 'export PATH="/usr/local/opt/libxml2/bin:$PATH"' >> ~/.zshrc
 
export LDFLAGS="-L/usr/local/opt/libxml2/lib"
export CPPFLAGS="-I/usr/local/opt/libxml2/include"
export PKG_CONFIG_PATH="/usr/local/opt/libxml2/lib/pkgconfig"
 
brew install gnutls
brew install libgcrypt
brew install pkg-config
brew link pkg-config
 
echo "[*]Installing openssl ..."
sudo rm -r -f openssl
sudo git clone https://github.com/openssl/openssl.git
cd openssl
sudo ./config
sudo make
sudo make install
cd ..
 
echo "[*]Installing libplist ..."
sudo rm -r -f libplist
sudo git clone https://github.com/libimobiledevice/libplist.git
cd libplist
sudo ./autogen.sh --without-cython
sudo make
sudo make install
cd ..
 
echo "[*]Installing libimobiledevice-glue ..."
sudo rm -r -f libimobiledevice-glue
sudo git clone https://github.com/libimobiledevice/libimobiledevice-glue.git
cd libimobiledevice-glue
sudo ./autogen.sh
sudo make
sudo make install
cd ..
 
echo "[*]Installing libusbmuxd ..."
 
sudo rm -r -f libusbmuxd
sudo git clone https://github.com/libimobiledevice/libusbmuxd.git
cd libusbmuxd
sudo ./autogen.sh
sudo make
sudo make install
cd ..
 
echo "[*]Installing libimobiledevice ..."
sudo rm -r -f libimobiledevice
sudo git clone https://github.com/libimobiledevice/libimobiledevice.git
cd libimobiledevice
sudo ./autogen.sh --without-cython --disable-openssl
sudo make
sudo make install
cd ..
 
echo "[*]Installing patched libideviceactivation by OliTheRepairDude ... "
sudo rm -r -f libideviceactivation
sudo git clone https://github.com/OliTheRepairDude/libideviceactivation.git
cd libideviceactivation
sudo ./autogen.sh
sudo make
sudo make clean
sudo make install
cd ..
 
echo "[*]Installing libirecovery ... "
sudo rm -r -f libirecovery
sudo git clone https://github.com/libimobiledevice/libirecovery.git
cd libirecovery
sudo ./autogen.sh
sudo make
sudo make install
cd ..
 
echo "Running part 2 of dependencies..."
sleep 2
 
echo ""
echo ""
echo ""
echo "INSTALLING DEPENDENCIES..."
echo ""
 
# Check for sshpass, install if we don't have it
if test ! $(which sshpass); then
    echo "Installing sshpass..."
    brew install esolitos/ipa/sshpass
    echo ''
fi
# Check for iproxy, install if we don't have it
if test ! $(which iproxy); then
    echo "Installing iproxy, ideviceinfo, ideviceenterrecovery..."
    brew install libimobiledevice
    echo ''
fi
 
echo "Installing brew python..."
brew install python3
echo ""
# Install pyenv to control python versions on mac
echo "Installing pyenv..."
brew install pyenv
echo ""
echo "Also Installing Python 3.10 🐍..."
pyenv install 3.10
echo ""
echo "Installing tk for GUI..."
pip3 install tk
echo ""
echo "Installing pillow..."
pip3 install pillow
echo ""
echo "Quarantine our files..."
sudo xattr -rd com.apple.quarantine ./
echo "Quarantined!"
echo ""
echo "FINISHED INSTALLING DEPENDECIES!!!"
echo ""
echo "DONE!!"
echo ""
exit 1

