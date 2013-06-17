Package { 
  ensure => 'installed',
}

Service {
  ensure => 'running',
  enable => true,
}
