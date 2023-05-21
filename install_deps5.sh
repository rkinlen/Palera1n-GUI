#!/usr/bin/env bash
# made by @ios_euphoria dependencies fix 5 test for all mac os for palera1n GUI tool.

echo 'THIS MAY TAKE SOME TIME TO INSTALL. JUST WAIT...'
echo 'If you have a slow Mac computer, I do not recommend it!!!'
sudo -v  
echo 'Going to install palera1n GUI dependencies in 3 seconds...'
echo ''
sleep 3

sudo mkdir dependencies
cd dependencies  
sudo mkdir libimobiledevice
cd libimobiledevice 

#Part 1

#uncomment these 2 lines if you're trying to install brew but 
#its failing with a git error for whatever reason
#rm -rf /opt/homebrew
#rm -rf /etc/homebrew

#Uninstalls brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall.sh)"

echo "Installing homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

git -C "/usr/local/Homebrew" remote set-url origin https://github.com/Homebrew/brew

rm -rf "/usr/local/Homebrew/Library/Taps/homebrew/homebrew-core"
brew tap homebrew/core

brew update-reset

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
echo "INSTALLING DEPENDENCIES 2..."
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
brew install python@3.11
echo ""
echo "Installing tk for GUI..."
pip3 install tk
brew install python3-tk
brew install python-tk
echo ""
echo "Installing pillow for GUI..."
pip3 install Pillow
echo ""
echo "FINISHED INSTALLING DEPENDECIES!!!"
echo ""
echo "DONE!!!"
echo ""
exit 1
