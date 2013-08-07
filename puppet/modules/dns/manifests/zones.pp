class dns::zones {
 concat {'/var/named/zone.henson':
   mode   => 0644,
   notify => Exec['named reload'],
 }
 concat::fragment {'zone.henson header':
   target  => '/var/named/zone.henson',
   source => "puppet:///modules/dns/$::zone/zone.henson",
   order   => 01,
 }

 concat {'/var/named/reverse.120.168.192.in-addr.arpa':
   mode   => 0644,
   notify => Exec['named reload'],
 }
 
 concat::fragment {'reverse.120.168.192.in-addr.arpa header':
   target => '/var/named/reverse.120.168.192.in-addr.arpa',
   source => 'puppet:///modules/dns/reverse/reverse.120.168.192.in-addr.arpa',
   order  => 01,
 }

 concat {'/var/named/reverse.122.168.192.in-addr.arpa':
   mode   => 0644,
   notify => Exec['named reload'],
 }
 
 concat::fragment {'reverse.122.168.192.in-addr.arpa header':
   target => '/var/named/reverse.122.168.192.in-addr.arpa',
   source => 'puppet:///modules/dns/reverse/reverse.122.168.192.in-addr.arpa',
   order  => 01,
 }
} 
