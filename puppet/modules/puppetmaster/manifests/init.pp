class puppetmaster {
  include puppetmaster::iptables

  # service and packages
  package {'puppet-server': }
  package {'puppet-server-selinux': }
  package {'httpd': }
  service {'httpd': require => Package['httpd']}
 
  @@host {'puppet':
    ensure       => 'present',
    ip           => "$::ipaddress_eth0",
    host_aliases => ["$::hostname","$::fqdn"],
    tag          => 'puppet',
  }
}
