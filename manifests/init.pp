# == Class: nvm
#
# Full description of class nvm here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class nvm (
  $package_name = $::nvm::params::package_name,
  $service_name = $::nvm::params::service_name,
) inherits ::nvm::params {

  # validate parameters here

  class { '::nvm::install': } ->
  class { '::nvm::config': } ~>
  class { '::nvm::service': } ->
  Class['::nvm']
}
