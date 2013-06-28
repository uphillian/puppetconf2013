class base::firewall::pre {
  Firewall {
    require => undef,
  }
  firewall { '000 INPUT allow related and established':
    proto   => 'all',
    action => accept,
    state  => ['RELATED', 'ESTABLISHED'],
  }
  firewall { '001 accept all icmp':
    proto   => 'icmp',
    action  => 'accept',
  }
  firewall { '002 accept all to lo interface':
    proto   => 'all',
    iniface => 'lo',
    action  => 'accept',
  }
  firewall { '003 INPUT allow SSH':
    action => accept,
    proto  => 'tcp',
    dport  => '22'
  }
}
