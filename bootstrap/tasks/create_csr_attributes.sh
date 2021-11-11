#!/bin/bash

file_path='/etc/puppetlabs/puppet/csr_attributes.yaml'

echo "---" > ${file_path}
echo "extension_requests:" >> ${file_path}
echo "  pp_role: \"${PT_role}\"" >> ${file_path}
echo >> $file_path
