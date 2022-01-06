# This plan installs a puppetserver, puppetca and puppetdb
plan bootstrap::all (
  Boolean $prerequirements = true,
  String $collection       = 'puppet7',
  String $control_repo     = 'https://github.com/rand0mcode/pupin.control.git',
  String $domain           = 'priv.rw.betadots.training',
  String $locale           = 'de',
  TargetSpec $targets      = ['puppet', 'puppetdb', 'puppetca'],
){
  if $prerequirements {
    run_plan(
      'bootstrap::prerequirements', $targets,
      { collection => $collection, locale => $locale, domain => $domain })
  }

  run_plan('bootstrap::puppetca_01',     'puppetca', { domain => $domain })
  run_plan('bootstrap::puppetserver_01', 'puppet',   { domain => $domain })
  run_plan('bootstrap::puppetca_02',     'puppetca', { domain => $domain })
  run_plan('bootstrap::puppetserver_02', 'puppet',   { control_repo => $control_repo })
  run_plan('bootstrap::puppetdb_01',     'puppetdb', { domain => $domain })
  run_plan('bootstrap::puppetca_03',     'puppetca')
}
