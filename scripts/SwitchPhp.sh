#!/bin/bash

###############################################################################
# Script based on https://github.com/conradkleinespel/sphp-osx                #
###############################################################################

if [ $# -ne 1 ]; then
	echo "Usage: sphp [phpversion]"	
	exit 1
fi

currentversion="`php -r \"echo str_replace('.', '', substr(phpversion(), 0, 3));\"`"
newversion="$1"

# Check if the given version is available.
brew list php$newversion 2> /dev/null > /dev/null
if [ $? -eq 1 ]; then
  echo "PHP version $newversion was not found."
  echo
	exit 1
fi

# Check if the given version is not already active.
if [ "$newversion" == "$currentversion" ]; then
  echo "PHP version is already $newversion., restarting..."
  brew services restart "php$currentversion"
  echo
  exit 0
fi 

# Switch the PHP version.
echo "PHP version $newversion found"
echo "Switching from $currentversion to $newversion..."

brew services stop "php$currentversion"
brew unlink "php$currentversion"
brew link "php$newversion"
brew services start "php$newversion"

# Restart Apache
brew services restart httpd24

echo "Done."
echo

exit 0
