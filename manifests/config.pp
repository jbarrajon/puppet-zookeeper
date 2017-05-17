# Class: zookeeper::config
# ===========================
#
class zookeeper::config inherits ::zookeeper {

  if $::zookeeper::manage_config {
    file { '/etc/zookeeper':
      ensure => directory,
      owner  => $::zookeeper::zookeeper_user,
      group  => $::zookeeper::zookeeper_group,
      mode   => '0750',
    }

    file { '/etc/zookeeper/zoo.cfg':
      ensure  => 'present',
      owner   => $::zookeeper::zookeeper_user,
      group   => $::zookeeper::zookeeper_group,
      mode    => '0640',
      content => template($::zookeeper::config_template),
    }

    file { '/etc/zookeeper/log4j.properties':
      ensure  => 'present',
      owner   => $::zookeeper::zookeeper_user,
      group   => $::zookeeper::zookeeper_group,
      mode    => '0640',
      content => template($::zookeeper::log4j_template),
    }

    file { $::zookeeper::config_options_final['dataDir'] :
      ensure => directory,
      owner  => $::zookeeper::zookeeper_user,
      group  => $::zookeeper::zookeeper_group,
      mode   => '0750',
    }

    file { "${::zookeeper::config_options_final['dataDir']}/myid":
      ensure  => 'present',
      owner   => $::zookeeper::zookeeper_user,
      group   => $::zookeeper::zookeeper_group,
      mode    => '0440',
      content => $::zookeeper::config_myid,
    }
  }

}
