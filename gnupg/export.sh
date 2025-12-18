# KEY=<KEYID> ./export.sh
gpg --export-secret-keys $KEY > privatekey.gpg
gpg --export $KEY > publickey.gpg
gpg --export-ownertrust > ownertrust.txt
