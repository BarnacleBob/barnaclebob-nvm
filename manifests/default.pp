# == Define nvm::default
#
# set the default version of node to use on shells that source .profile

define nvm::default (
  $version
){
  validate_re($version, '^([0-9.]+|stable|unstable|system)$')

  exec { "set default node version to ${version} for ${name}":
    command => "/bin/bash -c 'source ~/.nvm/nvm.sh && nvm alias default ${version}'",
    unless  => "/bin/bash -c 'source ~/.nvm/nvm.sh && nvm alias default | grep -q \"default -> ${version}\"'",
    user    => $name,
  }
}
