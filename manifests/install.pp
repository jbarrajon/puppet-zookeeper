# Class: zookeeper::install
# ===========================
#
class zookeeper::install inherits ::zookeeper {

  if $::zookeeper::manage_group {
    group { $::zookeeper::zookeeper_group :
      ensure => present,
    }
  }

  if $::zookeeper::manage_user {
    user { $::zookeeper::zookeeper_user :
      ensure     => present,
      comment    => 'Zookeeper User',
      gid        => $::zookeeper::zookeeper_group,
      home       => $::zookeeper::user_home,
      managehome => $::zookeeper::manage_home,
      system     => true,
    }
  }

  archive { "zookeeper-${::zookeeper::version}.tar.gz":
    path          => "${::zookeeper::user_home}/zookeeper-${::zookeeper::version}.tar.gz",
    source        => "${::zookeeper::download_url}/zookeeper/zookeeper-${::zookeeper::version}/zookeeper-${::zookeeper::version}.tar.gz",
    checksum_url  => "${::zookeeper::checksum_url}/zookeeper/zookeeper-${::zookeeper::version}/zookeeper-${::zookeeper::version}.tar.gz.sha1",
    checksum_type => 'sha1',
    extract       => true,
    extract_path  => $::zookeeper::user_home,
    creates       => "${::zookeeper::user_home}/zookeeper-${::zookeeper::version}",
    user          => $::zookeeper::zookeeper_user,
    group         => $::zookeeper::zookeeper_group,
    cleanup       => false,
  }

  file { "${::zookeeper::user_home}/zookeeper-${::zookeeper::version}":
    ensure  => directory,
    owner   => $::zookeeper::zookeeper_user,
    group   => $::zookeeper::zookeeper_group,
    require => Archive["zookeeper-${::zookeeper::version}.tar.gz"],
  }

  file { "${::zookeeper::user_home}/zookeeper":
    ensure => 'link',
    target => "${::zookeeper::user_home}/zookeeper-${::zookeeper::version}",
  }

  file { '/var/log/zookeeper':
    ensure => directory,
    owner  => $::zookeeper::zookeeper_user,
    group  => $::zookeeper::zookeeper_group,
    mode   => '0750',
  }

}
