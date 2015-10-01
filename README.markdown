#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with nvm](#setup)
    * [What nvm affects](#what-nvm-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with nvm](#beginning-with-nvm)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module will install nvm and use it to install nodejs versions on a per user basis.  This allows you to have multiple nvm installations per system such as using one user/nvm install per application running.

## Usage

This module requires the user you want to install nvm for to already exist.

```
user{'bob':
  ensure     => present,
  managehome => true,
}

nvm{'bob':
  versions        => ["10.40", "stable", "12.6"]
  default_version => "stable"
}
```

## Reference

### Public Defines
* [`nvm`](#define-nvm)

### Private defines
* [`nvm::install`](#define-nvminstall)
* [`nvm::install::version`](#define-nvminstall)
* [`nvm::install::default`](#define-nvmdefault)

#### Define: `nvm`

Manages nvm for specified user.

##### Parameters (all optional)

* `versions`: Specifies the versions of nodejs to install for this user.  Valid options: an array of strings. Default: ['stable'].

* `default_version`: Specifies the default version of nodejs that nvm will use.  Valid options: a string from the `versions` parameter.  Default: ['stable'].

* `nvm_version`: Specifies the version of nvm to install. Valid options: a string.  Default: '0.26.1'.

## Limitations

Tested on:
* Ubuntu 12.04
* Ubuntu 14.04
* Debian 6
* Debian 7
* Centos 6
* Centos 7

