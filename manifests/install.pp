# == Define nvm::install
#
# This class is called from nvm for install.
#
define nvm::install (
  $version
){

  # version must match a full x.x.x to match the github versioning for this project
  validate_re($version, '^[0-9]+\.[0-9]+\.[0-9]+$')
  $installer_url = "https://raw.githubusercontent.com/creationix/nvm/v${version}/install.sh"

  exec { "install nvm for user ${name}":
    command  => "/bin/bash -c 'export NVM_DIR=~/.nvm; /usr/bin/curl ${installer_url} | /bin/bash -x'",
    unless   => "/bin/bash -c 'test -e ~/.nvm/nvm.sh'",
    user     => $name,
    provider => shell,
  }
}
