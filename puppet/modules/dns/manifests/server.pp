class dns::server {
  # export ourselves as a dnsserver
  # all clients will need to have the File['add_nameserver']
  @@exec {"add nameserver $::hostname":
    command => "/usr/local/bin/add_nameserver $::ipaddress",
    path    => '/usr/bin:/bin',
    require => File['add_nameserver']
  }

  include dns::iptables
  
  package {'bind': }
  service {'named': require => Package['bind'] }
}
