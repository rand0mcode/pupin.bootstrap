# This plan will bootstrap an elk stack. It needs a working puppet environment for this.
plan bootstrap::elk (
  String $domain      = 'priv.rw.betadots.training',
  TargetSpec $targets = ['elastic01', 'elastic02', 'elastic03', 'kibana'],
  Boolean $add_nodes  = true,
){
  if $add_nodes {
    run_plan('bootstrap::add', 'elastic01, elastic02, elastic03', { role => 'monitoring::elasticsearch' })
    run_plan('bootstrap::add', 'kibana', { role => 'monitoring::kibana' })
  }

  # bootstrap first node do create the cluster
  run_plan('puppet_agent::run', 'elastic01')

  # bootstrap second and third node to join the cluster
  run_plan('puppet_agent::run', 'elastic02, elastic03')
  run_plan('puppet_agent::run', 'kibana')

  # sleep 120 seconds to give kibana some time to compile all its nodejs stuff
  ctrl::sleep(120)

  # add index_pattern/dataview to be able
  # to use the discover tab of kibana right away
  run_task('bootstrap::elk_add_dataview', 'kibana', { pattern => 'filebeat-*' })

  # Add Beats dashboards
  run_task('bootstrap::elk_add_filebeat_dashboards', 'kibana')
  ctrl::sleep(10)
  run_task('bootstrap::elk_add_metricbeat_dashboards', 'kibana')
  ctrl::sleep(10)
  run_task('bootstrap::elk_add_auditbeat_dashboards', 'kibana')

  run_task('bootstrap::elk_add_ingest_pipeline_puppetserver_log', 'elastic01', { elastic_host => "elastic01.${domain}"})
}
