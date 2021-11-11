#!/bin/bash

ca_conf='/etc/puppetlabs/puppetserver/services.d/ca.cfg'

echo 'puppetlabs.services.ca.certificate-authority-disabled-service/certificate-authority-disabled-service' > $ca_conf
echo 'puppetlabs.trapperkeeper.services.watcher.filesystem-watch-service/filesystem-watch-service' >> $ca_conf
echo >> $ca_conf
