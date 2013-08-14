class func2::minion {
  include base::firewall
  #allow connections from the func master
  Firewall <<| tag == 'func_master' |>>

  #allow connections from us to the certmaster
  @@firewall {"51235 ACCEPT certmaster from $::hostname":
    action => 'accept',
    source => "$::ipaddress",
    dport  => '51235',
    tag    => 'certmaster_minion',
  }
  @@exec {"sign certificate for $::fqdn":
    command => "certmaster-ca --sign $::fqdn",
    path    => '/usr/bin:/bin',
    creates => "/var/lib/certmaster/certmaster/certs/${::fqdn}.cert",
    tag     => 'certmaster_sign_minion',
  }



  package {'func': }
  service {'funcd':
    ensure    => running,
    require   => Package['func'],
    # http://projects.puppetlabs.com/issues/8346
    hasstatus => false,
  }

  # pull in func master host entry
  Host <<| tag == 'func_master' |>> {
    before => Service['funcd']
  }
  File <<| tag == 'func_master' |>>
}
