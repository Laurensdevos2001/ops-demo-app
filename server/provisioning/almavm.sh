#! /usr/bin/env bash

#------------------------------------------------------------------------------
# Bash settings
#------------------------------------------------------------------------------

# Enable "Bash strict mode"
set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't mask errors in piped commands

#------------------------------------------------------------------------------
# Variables
#------------------------------------------------------------------------------



install_packages() {
    dnf update -y && sudo dnf upgrade -y
    dnf install -y nano
    dnf install -y wget
    dnf install java-11-openjdk java-11-openjdk-devel -y
}

install_jenkins() {

    dnf update -y

    # get jenkins repo en GPG key
    wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo

    echo "Importing Jenkins GPG key..."
    rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
    echo "Key import completed."

    # install jenkins
    dnf install jenkins -y

    # start en enable
    systemctl start jenkins && sudo systemctl enable jenkins

    password=$(cat /var/lib/jenkins/secrets/initialAdminPassword)
}

install_packages
install_jenkins
echo password  "$password"
