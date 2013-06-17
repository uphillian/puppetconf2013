class postfix::client {
  # this is a client of the master, set our config file to use the master
  # add our name to the access list on the master
  @@augeas {"access by $::hostname": 
	  context => "/files/etc/postfix/access",
	  changes => [
	    "ins 0 after *[last()]",
	    "set 0/pattern $::ipaddress",
	    "set 0/action OK",
	  ],
	  onlyif => "match *[ pattern = '$::ipaddress'] size == 0",
    tag   => 'postfix_access',
  }
}
