class dns::client {
  file {'add_nameserver':
    path    => '/usr/local/bin/add_nameserver',
    source  => 'puppet:///dns/add_nameserver',
    mode    => 0755
  }
    
  Exec <<| |>>
}
