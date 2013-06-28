class func2::minion {
  #allow connections from the func master
  Firewall <<| tag == 'func_master' |>>

  #allow connections from us to the certmaster
  @@firewall {"51235 ACCEPT certmaster from $::hostname":
    action => 'accept',
    source => "$::ipaddress",
    dport  => '51235',
    tag    => 'certmaster_minion',
  }
  package {'func': }
  service {'funcd': require => Package['func'] }

  File <<| tag == func_master |>>
}
