class func1::minion {
  package {'func': }
  service {'funcd': 
    require => Package['func']
  }

  file { '/etc/certmaster/minion.conf':
    source => 'puppet:///func1/etc/certmaster/minion.conf',
    mode   => 644,
    owner  => 0,
    group  => 0,
  }

  firewall {"51234 ACCEPT func from jim":
    action => 'accept',
    source => "192.168.122.24",
    dport  => '51234',
  }

}
