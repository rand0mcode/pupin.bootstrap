# This plan will bootstrap an elk stack. It needs a working puppet environment for this.
plan bootstrap::elk (
  TargetSpec $targets = ['elastic01', 'elastic02', 'elastic03', 'kibana'],
  Boolean $add_nodes  = true,
){
  if $add_nodes {
    run_plan('bootstrap::add', 'elastic01, elastic02, elastic03', { role => 'monitoring::elasticsearch' })
    run_plan('bootstrap::add', 'kibana',    { role => 'monitoring::kibana' })
  }

  # # set yum to use only ipv4 to not get blocked bei elastic on ipv6
  # # they give you sometimes a http 403 when you want to install a
  # # package over ipv6
  apply($targets) {
      augeas { 'yum.conf_ip_resolve':
        incl    => '/etc/yum.conf',
        lens    => 'Yum.lns',
        context => '/files/etc/yum.conf/main/',
        changes => ' set ip_resolve 4',
      }
  }

  # bootstrap first node do create the cluster
  run_plan('puppet_agent::run', 'elastic01')
  # bootstrap second and third node to join the cluster
  run_plan('puppet_agent::run', 'elastic02, elastic03')
  run_plan('puppet_agent::run', 'kibana')
}
