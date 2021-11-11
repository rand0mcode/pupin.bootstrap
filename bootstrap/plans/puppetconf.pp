# This plan is a part of bootstrap::all and is used to configure the puppet agent
plan bootstrap::puppetconf (
  TargetSpec $targets,
  String $domain,
){
  $puppet_conf =  {
    environment        => 'production',
    splay              => 'true',
    use_cached_catalog => 'false',
    usecacheonfailure  => 'false',
    server             => "puppet.${domain}",
    ca_server          => "puppetca.${domain}",
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
}
