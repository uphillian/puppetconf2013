class dns::server {
  # define the concat for /etc/resolv.conf
  include dns::resolv
  include dns::client

  # export ourselves as a dnsserver
  @@concat::fragment {"resolv.conf nameserver $::hostname":
    target  => '/etc/resolv.conf',
    content => "nameserver $::ipaddress\n",
    order   => 10,
    tag     => ['resolv.conf',"$::zone"],
  }

  include dns::firewall
  
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

  # include zone.henson from everyone else.
  include dns::zones
  Concat::Fragment <<| tag == 'zone' and tag == 'henson' |>>
}
