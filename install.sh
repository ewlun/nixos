#!/usr/bin/env sh

# Deletes everything in /etc/nixos/ except hardware-configuration, 
# incase directory structure has changed in the git repo, and replaces
# all files.

echo "Deleting files: "
echo $(find /etc/nixos/ -type f -not -name "hardware-configuration.nix" -print -delete)
echo

echo "Deleting directories: "
echo $(find /etc/nixos/ -type d -not -name "nixos" -print -delete)
echo

echo "Creating directories: "
find . -type d -not -path "./.git" -not -path "./.git/*" \
     -not -name "." -printf "/etc/nixos/%P " | xargs -d $' ' -I % sh -c 'mkdir % && echo Created dir %'
echo

echo "Linking files:"
for file in $(find . -type f -not -path "./.git/*" \
		   -not -name "*~" -not -name "install.sh" \
		   -not -name "hardware-configuration.nix" -printf "%P ")
do
    echo "Linking ${file} to /etc/nixos/${file}"
    ln ${file} /etc/nixos/${file}
done
echo

echo "Rebuilding NixOS"
nixos-rebuild switch
