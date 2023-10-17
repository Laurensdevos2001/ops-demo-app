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

    # get jenkins repo en GPG key
    wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
    rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

    # install jenkins
    dnf install jenkins -y

    # start en enable
    systemctl start jenkins && sudo systemctl enable jenkins
}

install_packages
install_jenkins