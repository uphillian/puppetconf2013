class dns::server {
  # export ourselves as a dnsserver
  # all clients will need to have the File['add_nameserver']
  @@exec {"add nameserver $::hostname":
    command => "/usr/local/bin/add_nameserver $::ipaddress",
    path    => '/usr/bin:/bin',
    require => File['add_nameserver'],
    tag     => ['nameserver',"$::zone"]
  }

  include dns::iptables
  
  package {'bind': }
  service {'named': require => Package['bind'] }

  file {'/etc/named.conf':
    content => template('dns/named.conf.erb'),
    owner   => 0,
    group   => 'named',
    require => Package['bind'],
    notify  => Service['named']
  }
  # zone files
  file {'/var/named/zone.henson':
    source => "puppet:///dns/$::zone/zone.henson",
    mode   => 640,
    owner  => 0,
    group  => 'named',
  }
  file {"/var/named/zone.${::zone}.henson":
    source => "puppet:///dns/$::zone/zone.${::zone}.henson",
    mode   => 640,
    owner  => 0,
    group  => 'named',
  }
  file {"/var/named/reverse.${::reverse_eth0}":
    source => "puppet:///dns/reverse/reverse.${::reverse_eth0}",
    mode   => 640,
    owner  => 0,
    group  => 'named',
  }
}
