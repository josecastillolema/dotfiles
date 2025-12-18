gpg --import privatekey.gpg
gpg --import publickey.gpg
gpg --import-ownertrust ownertrust.txt
pass init $(cat ~/.password-store/.gpg-id)
