KEY=$(gpg --list-keys --with-colons | awk -F: '$1=="fpr" {print $10}' | head -n1)
gpg --export-secret-keys $KEY > privatekey.gpg
gpg --export $KEY > publickey.gpg
gpg --export-ownertrust > ownertrust.txt
