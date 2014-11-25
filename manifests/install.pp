# == Class nvm::install
#
# This class is called from nvm for install.
#
class nvm::install {

  package { $::nvm::package_name:
    ensure => present,
  }
}
