class postfix::master {
  Augeas <<| tag == 'postfix_access' |>>  {
    notify => Exec['postfix rebuild access']
  }

  exec { 'postfix rebuild access':
    path        => '/bin:/usr/bin',
    command     => '/usr/sbin/postmap /etc/postfix/access',
    refreshonly => true,
  }
}
