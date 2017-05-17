# Class: zookeeper
# ===========================
#
# Full description of class zookeeper here.
#
class zookeeper (
  $version          = $::zookeeper::params::version,
  $download_url     = $::zookeeper::params::download_url,
  $checksum_url     = $::zookeeper::params::checksum_url,
  $manage_group     = $::zookeeper::params::manage_group,
  $zookeeper_group  = $::zookeeper::params::zookeeper_group,
  $manage_user      = $::zookeeper::params::manage_user,
  $zookeeper_user   = $::zookeeper::params::zookeeper_user,
  $manage_home      = $::zookeeper::params::manage_home,
  $user_home        = $::zookeeper::params::user_home,
  $manage_config    = $::zookeeper::params::manage_config,
  $config_template  = $::zookeeper::params::config_template,
  $config_options   = {},
  $config_myid      = $::zookeeper::params::config_myid,
  $manage_service   = $::zookeeper::params::manage_service,
  $service_script   = $::zookeeper::params::service_script,
  $service_template = $::zookeeper::params::service_template,
  $service_options  = {},
  $service_ensure   = $::zookeeper::params::service_ensure,
  $service_enable   = $::zookeeper::params::service_enable,
) inherits ::zookeeper::params {

  $config_options_final = deep_merge($::zookeeper::params::config_options_default, hiera_hash('zookeeper::config_options', $config_options))
  $service_options_final = deep_merge($::zookeeper::params::service_options_default, hiera_hash('zookeeper::service_options', $service_options))

  include ::zookeeper::install
  include ::zookeeper::config
  include ::zookeeper::service

  Class['::zookeeper::install'] -> Class['::zookeeper::config'] ~> Class['::zookeeper::service']

}
