class func3::master {
  @@firewall { "51234 ACCEPT func from funcmaster $::hostname":
    action => 'accept',
    source => "$::ipaddress",
    dport  => '51234',
    tag    => ['func_master',"zone-$::zone"],
  }
  Firewall <<| tag == 'certmaster_minion' and tag == "zone-$::zone" |>>

  package { 'certmaster': }
  service { 'certmaster': require => Package['certmaster'] }
}
