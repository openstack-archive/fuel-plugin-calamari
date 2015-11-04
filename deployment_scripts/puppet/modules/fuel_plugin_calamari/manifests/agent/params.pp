# == Class: fuel_plugin_calamari::agent::params
#
# A basic class for calamari plugin params
#

class fuel_plugin_calamari::agent::params {

  if($::osfamily == 'Redhat') {

    $salt_file = '/etc/salt/minion'

    $packages = ['diamond', 'salt-minion']
    $services = ['salt-minion']

    } elsif($::osfamily == 'Debian') {

    $salt_file = '/etc/salt/minion.d/calamari.conf'

    $packages = ['diamond', 'salt-minion']
    $services = ['salt-minion']

    } else {

    fail("Unsupported osfamily ${::osfamily}")

    }

    # Search for the calamari ip address from user_node_name and use the
    # first one
    $calamari_nodes = filter_nodes(hiera('nodes'), 'user_node_name', 'calamari')

    if size($calamari_nodes) < 1 {
      fail('Could not find node "calamari" in the environment')
    }

    # TODO: figure out if this ip is in the correct network
    $calamari_ip = $calamari_nodes[0]['internal_address']
}
