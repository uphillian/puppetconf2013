class dns::server {
  # define the concat for /etc/resolv.conf
  include dns::resolv

  # export ourselves as a dnsserver
  @@concat::fragment {"resolv.conf nameserver $::hostname":
    target  => '/etc/resolv.conf',
    content => "nameserver $::ipaddress\n",
    order   => 10,
    tag     => ['resolv.conf',"$::zone"],
  }

  include dns::iptables
  
  # setup bind
  package {'bind': }
  service {'named': require => Package['bind'] }

  # configure bind
  file {'/etc/named.conf':
    content => template('dns/named.conf.erb'),
    owner   => 0,
    group   => 'named',
    require => Package['bind'],
    notify  => Service['named']
  }

  # zone files

  # make this one dynamically
#  file {'/var/named/zone.henson':
#    source => "puppet:///dns/$::zone/zone.henson",
#    mode   => 640,
#    owner  => 0,
#    group  => 'named',
#  }

  exec {'named reload':
    refreshonly => true,
    command     => 'service named reload',
    path        => '/usr/sbin:/sbin',
    require     => Package['bind'],
  }

  file {"/var/named/zone.${::zone}.henson":
    source => "puppet:///dns/$::zone/zone.${::zone}.henson",
    mode   => 640,
    owner  => 0,
    group  => 'named',
  }
  #file {"/var/named/reverse.${::reverse_eth0}":
  #  source => "puppet:///dns/reverse/reverse.${::reverse_eth0}",
  #  mode   => 640,
  #  owner  => 0,
  #  group  => 'named',
  #}

  # create zone.henson from all clients
  include dns::zones
  Concat::Fragment <<| tag == 'zone' and tag == 'henson' |>>
}
