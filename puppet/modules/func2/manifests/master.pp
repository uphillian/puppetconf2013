class func2::master {
  @@firewall { "51234 ACCEPT func from funcmaster $::hostname":
    action => 'accept',
    source => "$::ipaddress",
    dport  => '51234',
    tag    => 'func_master',
  }

  Firewall <<| tag == 'certmaster_minion' |>>

  # export the config file with our name to the minions
  @@file {'/etc/certmaster/minion.conf':
    mode    => 644,
    content => template('func2/etc/certmaster/minion.conf.erb'),
    tag     => 'func_master'
  }

  package { 'certmaster': }
  service { 'certmaster': require => Package['certmaster'] }
}
