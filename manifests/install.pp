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
    command  => "/usr/bin/env curl ${installer_url} | /usr/bin/env bash",
    unless   => "test -e \$HOME/.nvm/nvm.sh && source \$HOME/.nvm/nvm.sh && test '$(nvm --version)' = ${version}",
    user     => $name,
    provider => shell,
  }
}
