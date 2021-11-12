# This plan installs a puppetserver, puppetca and puppetdb
plan bootstrap::all (
  TargetSpec $targets      = ['puppetserver', 'puppetdb', 'puppetca', 'agent01'],
  String $collection       = 'puppet7',
  Boolean $prerequirements = true,
  String $domain           = 'priv.example42.cloud',
  String $control_repo     = 'https://github.com/rand0mcode/pupin.control.git',
){
  if $prerequirements {
    run_plan('bootstrap::prerequirements', $targets, { collection => $collection })
  }

  run_plan('bootstrap::puppetca_01',     'puppetca',     { domain => $domain })
  run_plan('bootstrap::puppetserver_01', 'puppetserver', { domain => $domain })
  run_plan('bootstrap::puppetca_02',     'puppetca',     { domain => $domain })
  run_plan('bootstrap::puppetserver_02', 'puppetserver', { control_repo => $control_repo })
  run_plan('bootstrap::puppetdb_01',     'puppetdb',     { domain => $domain })
  run_plan('bootstrap::puppetca_03',     'puppetca')
}
