# Class: zookeeper::service
# ===========================
#
class zookeeper::service inherits ::zookeeper {

  if $::zookeeper::manage_service {
    file { $::zookeeper::service_script :
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template($::zookeeper::service_template),
      notify  => Service['zookeeper'],
    }
    service { 'zookeeper':
      ensure => $::zookeeper::service_ensure,
      enable => $::zookeeper::service_enable,
    }
  }

}
