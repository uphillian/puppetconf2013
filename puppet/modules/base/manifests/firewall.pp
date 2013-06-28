class base::firewall {
  resources { "firewall":
    purge => true
  }
  Firewall {
    before  => Class['base::firewall::post'],
    require => Class['base::firewall::pre'],
  }
  class { ['base::firewall::pre', 'base::firewall::post']: }
}
