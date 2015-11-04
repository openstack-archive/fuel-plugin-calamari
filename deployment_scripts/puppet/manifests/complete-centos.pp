if 'calamari' == hiera('user_node_name') {
    if($::osfamily == 'Redhat') {
      include fuel_plugin_calamari::centos_salt::complete_centos
    }
}