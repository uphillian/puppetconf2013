class func1::master {
  firewall { "51235 ACCEPT certmaster from anyone":
    action => 'accept',
    dport  => '51235',
  }

  package { 'certmaster': }
  service { 'certmaster': require => Package['certmaster'] }
}
