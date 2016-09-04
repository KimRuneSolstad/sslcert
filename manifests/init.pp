# Class: sslcert
# ===========================
#
# Full description of class sslcert here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'sslcert':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2016 Your name here, unless otherwise noted.
#

class sslcert ( $certificate ){
  $path_centos = "/etc/pki/CA"
  $path_ubuntu = "/etc/ssl/CA"
  $path_test = "/home/kimkong"

  $path = $::osfamily ? {
    'Debian' => "/etc/ssl/CA",
    'RedHat' => "/etc/pki/CA",
    'default'=> "/root/CA",
  }

  notice ( "using the path: ${path}")

  file {["$path/CA", "${path}/CA/csr", "${path}/certs", "${path}/crl", "${path}/private", "${path}/newcerts"] :
    ensure => directory,
  }

  file {"${path}/CA/serial":
    ensure  => file,
    content => "01",
  }

  file {"${path}/CA/index.txt":
    ensure  => file,
  }

  file {"${path}/CA/openssl.cnf":
    ensure => file,
    source => 'puppet:///modules/sslcert/openssl_test1.cnf'
  }

  file {"${path}/private/ca.key.pem":
    ensure => file,
    source => 'puppet:///modules/sslcert/root/private/ca.key.pem',
  }

  file {"${path}/certs/ca.cert.pem":
    ensure => file,
    source => $certificate,
  }
}





























