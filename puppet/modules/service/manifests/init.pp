class service {
  if $::hostname == 'jim' {
	File <<| tag == 'service' |>>
  } else {
    @@file { "service$::hostname":
      path => "/tmp/service.$::hostname",
      content => "this is $::hostname\n",
      tag  => 'service',
    }
  }
}
