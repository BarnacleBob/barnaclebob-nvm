# == Class nvm::service
#
# This class is meant to be called from nvm.
# It ensure the service is running.
#
class nvm::service {

  service { $::nvm::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
