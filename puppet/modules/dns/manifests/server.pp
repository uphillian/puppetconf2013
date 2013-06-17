class dns::server {
#  @@augeas {"add nameserver $::hostname":
#    context => '/etc/resolv.conf',
#    changes => [
#      "ins "
#    ],
#    onlyif => "match $",
#    tag    => "$::zone"
#  }

  include dns::iptables
  
  package {'bind': }
  service {'named': require => Package['bind'] }
}
