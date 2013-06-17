class func::master {
  @@firewall { "51234 ACCEPT func from funcmaster $::hostname":
    action => 'accept',
    source => "$::ipaddress",
    dport  => '51234',
    tag    => 'func_master',
  }
  Firewall <<| tag == 'certmaster_client' |>>

  package { 'certmaster': }
  service { 'certmaster': require => Package['certmaster'] }
}
