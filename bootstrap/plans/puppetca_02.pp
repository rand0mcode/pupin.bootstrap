# This plan is a part of bootstrap::all and represents the second steps for the puppetca
plan bootstrap::puppetca_02 (
  String $domain,
  TargetSpec $targets = 'puppetca',
){
  out::message('### initialize PuppetCA - Part 2')
  # disable allow-subject-alt-name again
  run_task('bootstrap::set_alt_names', $targets, { alt_names => false })
  # switch puppet conf to final server settings
  $puppet_conf = { certname => "puppetca.${domain}", server => "puppet.${domain}", ca_server => "puppetca.${domain}" }
  $puppet_conf.each |$setting, $value| {
    run_task('puppet_conf', $targets, { action  => 'set', section => 'agent', setting => $setting, value => $value })
  }
  run_task('service', $targets, { action => 'restart', name => 'puppetserver'})
}
