class iptables::pre {
  Firewall {
            require => undef,
  }

  # default firewall rules
  firewall { '000 accept all icmp':
    proto  => 'icmp',
    action => 'accept',
  }->
  firewall { '001 accept all to lo interface':
    proto   => 'all',
    iniface => 'lo',
    action  => 'accept',
  }->
  firewall { '002 accept related established rules':
    proto  => 'all',
    state  => ['RELATED', 'ESTABLISHED'],
    action => 'accept',
  }->
  firewall { '022 accept ssh from our network':
    proto => 'tcp',
    dport => '22',
    action => 'accept',
  }
}
