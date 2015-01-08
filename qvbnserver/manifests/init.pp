class qvbnserver {
  anchor { 'qvbnserver::begin': } ->
  class { '::qvbnserver::adding_repo': } ->
  class { '::qvbnserver::update_packages': } ->
  class { '::qvbnserver::dist_upgrade_packages': } ->
  class { '::qvbnserver::qvbn_services': } ->
  class { '::qvbnserver::openrg_trial': } ->
  class { '::qvbnserver::guest_agentd_reload': } ->
  class { '::qvbnserver::qvbn_tools': } ->
  class { '::qvbnserver::xmpp_server_config': } ->
  class { '::qvbnserver::xmpp_account': } ->
  class { '::qvbnserver::xmpp_account_credentials': } ->
  class { '::qvbnserver::reading_xmpp_config': } ->
  anchor { 'qvbnserver::end': }
}
