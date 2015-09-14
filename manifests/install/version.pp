# == Define nvm::install::version
#
# This define handles installing a specific node version for a user via nvm.
# The $name param contains ${user}:${version} to make it unique for users/version
# combos.  We parse from that since i don't have a better idea how to pass both.

define nvm::install::version (
){
  # the name must match our user/version combined set
  validate_re($name, '^[^:]+:([0-9.]+|stable|unstable)$')

  $name_parts = split($name, ':')
  $user = $name_parts[0]
  $version = $name_parts[1]

  exec { "install node ${version} for ${user}":
    command => "/bin/bash -c '. ~/.nvm/nvm.sh && nvm install ${version}'",
    unless  => "/bin/bash -c '. ~/.nvm/nvm.sh && nvm ls ${version}'",
    user    => $user,
  }
}
