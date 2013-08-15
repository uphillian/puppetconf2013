class func2::minion {
  include base::firewall
  #allow connections from the func master
  Firewall <<| tag == 'func_master' |>>

  @@exec {"sign certificate for $::fqdn":
    command => "certmaster-ca --sign $::fqdn",
    path    => '/usr/bin:/bin',
    creates => "/var/lib/certmaster/certmaster/certs/${::fqdn}.cert",
    onlyif  => "/usr/bin/test -f /var/lib/certmaster/certmaster/csrs/${::fqdn}.csr",
    tag     => 'certmaster_sign_minion',
  }


  # configure minion
  file {'/etc/func/minion.conf':
    mode    => 0644,
    owner   => 0,
    group   => 0,
    content => template('func2/etc/func/minion.conf.erb'),
    notify  => Service['funcd'],
  }
  package {'func': }
  service {'funcd':
    ensure    => running,
    require   => [File['/etc/func/minion.conf'],Package['func']],
    # http://projects.puppetlabs.com/issues/8346
    hasstatus => false,
  }

  # pull in func master host entry
  Host <<| tag == 'func_master' |>> {
    before => Service['funcd']
  }
  File <<| tag == 'func_master' |>>
}
