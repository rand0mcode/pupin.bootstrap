#!/bin/bash

if puppetserver ca list --certname $PT_certname --format json | jq '.signed[].name' -r | grep $PT_certname; then
  echo "Cert is already signed."
else
  puppetserver ca sign --certname $PT_certname
fi
