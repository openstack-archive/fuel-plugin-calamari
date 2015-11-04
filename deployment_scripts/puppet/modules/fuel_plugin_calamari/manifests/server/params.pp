# Copyright 2015 CREATE-NET
#
# Licensed under the Apache License, Version 2.0 (the "License"); you
# may not use this file except in compliance with the License. You may
# obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied. See the License for the specific language governing
# permissions and limitations under the License.


# == Class: fuel_plugin_calamari::server::params
#
# A basic class for calamari plugin params
#

class fuel_plugin_calamari::server::params {

  if($::osfamily == 'Redhat') {

    $packages = ['calamari-server', 'calamari-clients']
    $services = ['httpd', 'postgresql-9.3']

    } elsif($::osfamily == 'Debian') {

    $packages = ['calamari-server', 'calamari-clients']
    $services = ['apache2']

    } else {

    fail("Unsupported osfamily ${::osfamily}")

    }

    # General configuration
    $settings = hiera('fuel-plugin-calamari')

    $username = $settings['fuel-plugin-calamari_username']
    $password = $settings['fuel-plugin-calamari_password']
    $email    = $settings['fuel-plugin-calamari_email']
}
