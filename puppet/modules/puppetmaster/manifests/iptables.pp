class puppetmaster::iptables {
  firewall {'8140 allow puppetmaster connections':
    proto  => 'tcp',
    port   => 8140,
    action => 'accept',
  }
}
