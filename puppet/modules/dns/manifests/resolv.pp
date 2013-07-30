class dns::resolv {
 concat {'/etc/resolv.conf':
   mode => 0644,
 }
}
