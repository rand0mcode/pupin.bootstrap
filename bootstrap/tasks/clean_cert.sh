#!/bin/bash

if puppetserver ca list --certname $PT_certname --format json | jq '.signed[].name' -r | grep $PT_certname; then
  puppetserver ca clean --certname $PT_certname
else
  echo "Cert is already cleaned."
fi
