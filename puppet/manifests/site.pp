import "defaults.pp"

# kermit will be the email server
node kermit {
  include postfix::master
  include standard
}

# piggy will be the func master
node piggy {
  include func2::master
  include standard
}

# gonzo will do dns
node gonzo {
  include dns::server
  include hiera_test
  include standard
}
# jim will be the puppetmaster
# jim will do dns
node jim {
  include dns::server
  include puppetmaster 
  include standard
#  class { 'puppetdb':
#    listen_address => 'jim.henson'
#  }
  include func2::minion
#  include puppetdb::master::config
}

# everybody else gets standard
node default {
  include standard
}
