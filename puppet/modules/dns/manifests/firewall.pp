class dns::firewall {
  include base::firewall
  firewall {'53 domain udp':
    proto  => 'udp',
    action => 'accept',
    port   => '53',
  }
  firewall {'53 domain tcp':
    proto  => 'tcp',
    action => 'accept',
    port   => '53',
  } 
}
