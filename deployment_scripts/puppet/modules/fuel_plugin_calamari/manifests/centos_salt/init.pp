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

class fuel_plugin_calamari::centos_salt::init {

  notice('Starting centos_salt manifest')

  include fuel_plugin_calamari::centos_salt::params

  package { $fuel_plugin_calamari::centos_salt::params::packages:
    ensure => present,
    }->
    service{ $fuel_plugin_calamari::centos_salt::params::services:
      enable => true,
      }->
      exec { 'add_epel_key':
        command => '/bin/rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6'
      }
      notice('End of centos_salt manifest')
}
