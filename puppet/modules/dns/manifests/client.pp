class dns::client {
  $domain = hiera('dns::domain')
  $search = hiera('dns::search')

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
}
