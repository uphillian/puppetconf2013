class func2::master {
  include base::firewall
  @@firewall { "51234 ACCEPT func from funcmaster $::hostname":
    action => 'accept',
    source => "$::ipaddress",
    dport  => '51234',
    tag    => 'func_master',
  }

  Firewall <<| tag == 'certmaster_minion' |>>

  # export our host entry
  @@host {"func_master":
    ensure       => 'present',
    ip           => "$::ipaddress_eth0",
    host_aliases => ["$::hostname","$::fqdn"],
    tag          => 'func_master', 
  }
  # export the config file with our name to the minions
  @@file {'/etc/certmaster/minion.conf':
    mode    => 644,
    content => template('func2/etc/certmaster/minion.conf.erb'),
    tag     => 'func_master'
  }

  # sign minion keys
  Exec <<| tag == 'certmaster_sign_minion' |>>

  package { 'certmaster': }
  service { 'certmaster': 
    require    => Package['certmaster'],
    hasstatus => false,
  }
}
