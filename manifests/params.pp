# Class: zookeeper::params
# ===========================
#
class zookeeper::params {

  $version      = '3.4.10'
  $download_url = 'http://mirrors.ocf.berkeley.edu/apache'
  $checksum_url = 'http://apache.org/dist'

  $manage_group = true
  $zookeeper_group  = 'zookeeper'
  $manage_user  = true
  $zookeeper_user   = 'zookeeper'
  $manage_home  = true
  $user_home    = '/opt/zookeeper'

  $manage_config   = true
  $config_template = 'zookeeper/zookeeper.conf.erb'
  $config_myid     = '1'
  $config_options_default = {
    'dataDir' => '/var/lib/zookeeper',
  }

  $manage_service   = true
  $service_ensure   = 'running'
  $service_enable   = true
  $service_script   = '/etc/systemd/system/zookeeper.service'
  $service_template = 'zookeeper/zookeeper.systemd.erb'
  $service_options_default = {
    'environment' => ['ZOO_LOG_DIR=/var/log/zookeeper', 'ZOOCFGDIR=/etc/zookeeper', 'ZOOCFG=zoo.cfg'],
  }

}
