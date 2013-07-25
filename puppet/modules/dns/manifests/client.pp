class dns::client {
  file {'add_nameserver':
    path    => '/usr/local/bin/add_nameserver',
    source  => 'puppet:///dns/add_nameserver',
    mode    => 0755
  }
    
  Exec <<| tag == 'nameserver' and tag == "$::zone" |>>
  $search = hiera('dns::search')
  notify {"search is $search": }
}
