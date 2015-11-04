User Guide
==========

Intro
+++++

- Create a new environment with the Fuel UI wizard.  At the moment
  only the Ubuntu distribution is supported.

- Click on the Settings tab of the Fuel web UI.

  For fuel version 7.0: select the “Calamari Installer” tab, enable
  the plugin by clicking on the “Calamari Installer” checkbox and
  fill-in the required fiels:

  .. image:: _static/settings-calamari_fuel70.png
     :alt: A screen-shot of the Calamari Settings UI
     :scale: 90%

- For fuel version 6.1: scroll down the page, select the calamari
  plugin check-box and fill-in the required fields.  The interface
  looks like the following:

  .. image:: _static/settings-calamari.png
     :alt: A screen-shot of the Calamari Settings UI
     :scale: 90%

- Go to the nodes page.

- Add a base-os node and rename the base-os host as “calamari”:

  .. image:: _static/calamari-name.png
     :alt: A screen-shot of the Calamari host name
     :scale: 90%

- Some minutes after the deploy is ready (currently the Fuel UI
  display "Ready" on the nodes, even some plugin has not yet finished)
  you can browse the calamari interface on the calamari server.  You
  have to figure out the address of the server from the network info
  pop-up:

  .. image:: _static/calamari-ip.png
     :alt: A screen-shot of the Calamari host IP
     :scale: 90%

How to use the plugin
+++++++++++++++++++++

Have a look to the still rough `calamari documentation
<https://ceph.com/category/calamari/>`_.
