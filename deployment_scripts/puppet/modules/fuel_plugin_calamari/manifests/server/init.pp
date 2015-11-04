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
class redhat_init{
  if($::osfamily == 'Redhat') {

    notice('Starting redhat_init')

    #Needed for calamari server config
    file { '/etc/init.d/postgresql':
      ensure => link,
      target => '/etc/init.d/postgresql-9.3'
      }->

      exec { 'init postgres db':
        command => 'service postgresql-9.3 initdb',
        path    => '/usr/local/sbin/:/usr/bin:/usr/sbin:/bin/:/sbin/'
        }->

        exec { 'start postgres':
          command => 'service postgresql-9.3 start',
          path    => '/usr/local/sbin/:/usr/bin:/usr/sbin:/bin/:/sbin/'
          }->

          exec { 'start httpd':
            command => 'service httpd start',
            path    => '/usr/local/sbin/:/usr/bin:/usr/sbin:/bin/:/sbin/'
            }->

            file { 'wrapper_salt':
              source => 'puppet:///modules/fuel_plugin_calamari/salt_wrapper.py',
              path => '/opt/calamari/venv/lib/python2.6/site-packages/calamari_common-0.1-py2.6.egg/calamari_common/salt_wrapper.py',
              recurse => true,
              mode => '0777'
              }->

              file { '/var/lib/pgsql/data':
                ensure => 'directory',
                owner => 'postgres',
                group => 'postgres'
                }->

                file { '/var/lib/pgsql/data/pg_hba.conf':
                  ensure => 'link',
                  target => '/var/lib/pgsql/9.3/data/pg_hba.conf',
                  owner => 'postgres',
                  group => 'postgres'
                  }->

                  exec { 'postgres trust':
                    command => 'sed -ir "s/ident/trust/" /var/lib/pgsql/data/pg_hba.conf && sed -ir "s/peer/trust/" /var/lib/pgsql/data/pg_hba.conf && sed -ir "s/ident/trust/" /var/lib/pgsql/9.3/data/pg_hba.conf && sed -ir "s/peer/trust/" /var/lib/pgsql/9.3/data/pg_hba.conf',
          path    => '/usr/local/sbin/:/usr/bin:/usr/sbin:/bin/:/sbin/'
        }->

        exec {'restart postgres' :
          command => '/etc/init.d/postgresql-9.3 restart',
          path =>'/usr/local/sbin/:/usr/bin:/usr/sbin:/bin/:/sbin/'
        }

        notice('Finish redhat_init')
    }
}

class fuel_plugin_calamari::server::init {

  notice('Starting calamari-server manifest')

  include fuel_plugin_calamari::server::params

  package { $fuel_plugin_calamari::server::params::packages:
    ensure => present,
    }->
    # TODO: wait for minion deploy!  How?  Does the order in tasks.yaml suffice?
    exec { 'salt accept keys':
      command => 'salt-key --yes --accept-all',
      path    => '/usr/local/sbin/:/usr/bin:/usr/sbin:/bin/:/sbin/',
      # Config of calamari
      }->
      class {'redhat_init':}

      # service { 'db before':
      #       name =>  'postgresql-9.3',
      #       enable => true,
      #     }->

      # service { 'http before':
      #       name =>  'httpd',
      #       enable => true,
      #     }->

      #    notice('Starting redhat_init')

        exec { 'calamari server config':
          command => "calamari-ctl initialize --admin-username='${fuel_plugin_calamari::server::params::username}' --admin-password='${fuel_plugin_calamari::server::params::password}' --admin-email='${fuel_plugin_calamari::server::params::email}'",
          path    => '/usr/local/sbin/:/usr/bin:/usr/sbin:/bin/:/sbin/',
          }->

          # Restart apache2 to load the correct config (if not we have some
          # errors in the gui)
        service { $fuel_plugin_calamari::server::params::services:
          enable => true,
        }

        notice('End of calamari-server manifest')

}
