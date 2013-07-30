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
   
}
