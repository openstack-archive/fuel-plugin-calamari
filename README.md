fuel-plugin-calamari
====================

Intro
-----

This is an working implementation for a plugin that will install
[calamari console for ceph](https://ceph.com/category/calamari/) on a
os-base node with fuel.

Usage
-----

Please look at the [install guide](doc/source/installation-guide.rst)
and [user guide](doc/source/user-guide.rst).

Version installed
-----------------

The =fuel-camari-plugin= installs the following packages:

- For Ubuntu:

  - calamari-clients 1.2.2-32-g931ee58
  - calamari-server 1.0.0-1
  - diamond 3.1.0
  - python-msgpack-python 1.0

- For CentOS:

  - calamari-clients 1.3-rc_12_g7d36e29.el6
  - calamari-server 1.3.0.1-11_g9fb65ae.el6
  - diamond 3.4.67-1.noarch.rpm
  - libcairo 1.14.2-alt1
  - pycairo 1.8.6-2.1.el6
  - supervisor 3.0.el6

Testing
-------

A simple install script tested with the default values of the
[virtualbox
script](https://github.com/stackforge/fuel-main/blob/master/virtualbox/README.md)
is available once the plugin is installed.  It requires a clean
environment with at least 4 unallocated nodes.

Run with the following:

```
cd /var/www/nailgun/plugins/fuel-plugin-calamari-1.0/test/
./simple-install
```

Debugging
---------

The following commands may be helpful:

```
# On the controllers and ceph-osd nodes

puppet apply --debug \
  --modulepath=/etc/fuel/plugins/fuel-plugin-calamari-1.0/puppet/modules:/etc/puppet/modules \
  /etc/fuel/plugins/fuel-plugin-calamari-1.0/puppet/manifests/calamari-agent.pp

# On the calamari node

puppet apply /etc/puppet/modules/osnailyfacter/modular/netconfig/netconfig.pp

puppet apply --debug \
  --modulepath=/etc/fuel/plugins/fuel-plugin-calamari-1.0/puppet/modules:/etc/puppet/modules \
  /etc/fuel/plugins/fuel-plugin-calamari-1.0/puppet/manifests/calamari-server.pp
```

TODO list
---------

- Salt change the ceph configuration:

  Here is the diff in /etc:

      diff --git a/ceph/ceph.conf b/ceph/ceph.conf
      index 17c676a..cf2f502 100644
      --- a/ceph/ceph.conf
      +++ b/ceph/ceph.conf
      @@ -1,4 +1,5 @@
       [global]
      +osd crush location hook = /usr/bin/calamari-crush-location
       fsid = 783fcc91-e95d-4ce3-b9c2-0a414a4751d3
       mon_initial_members = node-1
       mon_host = 192.168.0.3
      diff --git a/default/diamond b/default/diamond
      index deda518..c936044 100644
      --- a/default/diamond
      +++ b/default/diamond
      @@ -9,4 +9,4 @@
       # Additional options that are passed to the Daemon.
       ENABLE_DIAMOND="yes"
       DIAMOND_PID="/var/run/diamond.pid"
      -DIAMOND_USER="diamond"
      +DIAMOND_USER="root"

- Do the conf changes will step over puppet?  How can we manage salt
  and puppet to not step on each other?

- Figure out how to do proper testing and CI (we do not have hardware
  resources for this)

- Reproducible build of the packages included in the plugin.

- UI: Does make sense to enable the plugin only if there is some ceph
  depoyed?

- What happens in case of node ceph node addition?
  What happens in case of node ceph node removal?

  The puppet code is executed in the new node.  But not on the
  calamari server.  This blueprint addressed the problem:

  https://blueprints.launchpad.net/fuel/+spec/fuel-task-notify-other-nodes