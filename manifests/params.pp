# == Class nvm::params
#
# This class is meant to be called from nvm.
# It sets variables according to platform.
#
class nvm::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'nvm'
      $service_name = 'nvm'
    }
    'RedHat', 'Amazon': {
      $package_name = 'nvm'
      $service_name = 'nvm'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
