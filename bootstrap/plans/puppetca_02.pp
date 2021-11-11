# This plan is a part of bootstrap::all and represents the second steps for the puppetca
plan bootstrap::puppetca_02 (
  TargetSpec $targets = 'puppetca',
  String $domain,
){
  out::message('### initialize PuppetCA - Part 2')

  # disable allow-subject-alt-name again
  apply($targets) {
    $ca_conf = [
      'certificate-authority: {',
      '    allow-subject-alt-names: false',
      '    # allow-authorization-extensions: false',
      '    # enable-infra-crl: false',
      '}',
    ]

    file { '/etc/puppetlabs/puppetserver/conf.d/ca.conf':
      ensure  => file,
      content => join($ca_conf, "\n"),
    }
  }

  # switch puppet conf to final server settings
  $puppet_conf =  {
    certname      => "puppetca.${domain}",
    server        => "puppet.${domain}",
    ca_server     => "puppetca.${domain}",
  }

  $puppet_conf.each |$setting, $value| {
    run_task('puppet_conf', $targets, "Setting: ${setting}",
      {
        action  => 'set',
        section => 'agent',
        setting => $setting,
        value   => $value,
      }
    )
  }

  run_task('service', $targets, { action => 'restart', name => 'puppetserver'})
}
