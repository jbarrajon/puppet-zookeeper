# Class: zookeeper::config
# ===========================
#
class zookeeper::config inherits ::zookeeper {

  if $::zookeeper::manage_config {
    file { '/etc/zookeeper':
      ensure => directory,
      group  => $::zookeeper::zookeeper_group,
      owner  => $::zookeeper::zookeeper_user,
      mode   => '0640',
    }

    file { '/etc/zookeeper/zoo.cfg':
      ensure  => 'present',
      group   => $::zookeeper::zookeeper_group,
      owner   => $::zookeeper::zookeeper_user,
      mode    => '0640',
      content => template($::zookeeper::config_template),
    }

    file { $::zookeeper::config_datadir :
      ensure => directory,
      group  => $::zookeeper::zookeeper_group,
      owner  => $::zookeeper::zookeeper_user,
      mode   => '0640',
    }

    file { "${::zookeeper::config_datadir}/myid":
      ensure  => 'present',
      group   => $::zookeeper::zookeeper_group,
      owner   => $::zookeeper::zookeeper_user,
      mode    => '0440',
      content => $::zookeeper::config_myid,
    }
  }

}
