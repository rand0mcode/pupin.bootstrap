# This plan will bootstrap an oracle database. It needs a working puppet environment for this.
plan bootstrap::oracle (
  String $domain      = 'priv.rw.betadots.training',
  TargetSpec $targets = ['oracle'],
  Boolean $add_nodes  = true,
) {
  if $add_nodes {
    run_plan('bootstrap::add', 'oracle', { role => 'database::oracle' })
  }
}
