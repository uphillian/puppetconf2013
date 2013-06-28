class base::firewall::post {
  firewall { '998 reject all':
    proto   => 'all',
    action  => 'reject',
    before  => undef,
  }
}
