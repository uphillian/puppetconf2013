class dns::client {
  # pull settings from hiera, sensible defaults
  $domain = hiera('dns::domain','henson')
  $search = hiera('dns::search','henson')

  # include definition of concat for /etc/resolv.conf
  include dns::resolv

  # search the local search value
  concat::fragment{'resolv.conf search': 
    target  => '/etc/resolv.conf',
    content => "search $search\n",
    order   => 07, 
  }

  # pull in any nameservers
  Concat::Fragment <<| tag == 'resolv.conf' and tag == "$::zone" |>>

  # export ourselves to the zone file

  @@concat::fragment {"zone henson $::hostname":
    target  => '/var/named/zone.henson',
    content => "$::hostname A $::ipaddress\n",
    order   => 10,
    tag     => ['zone','henson'],
  }
  $lastoctet = regsubst($::ipaddress_eth0,'^([0-9]+)[.]([0-9]+)[.]([0-9]+)[.]([0-9]+)$','\4')
  @@concat::fragment {"zone reverse $::reverse_eth0 $::hostname":
    target  => "/var/named/reverse.$::reverse_eth0",
    content => "$lastoctet PTR $::fqdn\n",
    order   => 10,
    tag     => ['zone','henson'],
  }
}
