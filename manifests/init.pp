# == Class: nvm
#
# Full description of class nvm here.
#
# === Parameters
#
# [name]
#   Username that this nvm will be installed under
#
define nvm (
  $versions = ['stable'],
  $nvm_version = '0.26.1',
  $default_version = 'stable',
) {

  validate_array($versions)
  validate_re($default_version, '^([0-9.]+|stable|unstable|system)$')

  case $::osfamily {
    'Debian', 'Redhat', 'Amazon': {
      #supported
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }

  $acceptable_versions=concat($versions, ['system'])

  if ! member($acceptable_versions, $default_version){
    fail("default_version(${default_version}) must be in the list of installed versions (${versions}) or system")
  }

  $user_version_installs = regsubst($versions, '^', "${name}:")

  ::nvm::install { $name:
    version => $nvm_version,
  } ->
  ::nvm::install::version { $user_version_installs: } ->
  ::nvm::default { $name:
    version => $default_version
  }

}
