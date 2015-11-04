# == Class: fuel_plugin_calamari::centos_salt::params
#
# A basic class for calamari plugin params
#

class fuel_plugin_calamari::centos_salt::params {

  if($::osfamily == 'Redhat') {

    $packages = ['epel-release-6-8']
    $services = []

    } else {

    fail("Unsupported osfamily ${::osfamily}")

    }

}
