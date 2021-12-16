#!/bin/bash

if [ ${PT_puppet_env} == "false" ]; then
  echo "Deploying all environments"
  /opt/puppetlabs/puppet/bin/r10k deploy environment -v -m
else
  echo "Deploying environment: ${PT_puppet_env}"
  /opt/puppetlabs/puppet/bin/r10k deploy environment -v -m $PT_puppet_env
  # /opt/puppetlabs/puppet/bin/puppet generate types --environment $PT_puppet_env
fi
