class func3::client {
  #allow connections from the func master
  Firewall <<| tag == 'func_master' and tag == "zone-$::zone" |>>

  #allow connections from us to the certmaster
  @@firewall {"51235 ACCEPT certmaster from $::hostname":
    action => 'accept',
    source => "$::ipaddress",
    dport  => '51235',
    tag    => ['certmaster_minion',"zone-$::zone"],
  }
  package {'func': }
  service {'funcd': require => Package['func'] }

}
