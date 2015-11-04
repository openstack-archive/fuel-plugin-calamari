if 'calamari' == hiera('user_node_name') {
  include fuel_plugin_calamari::server::init
}
