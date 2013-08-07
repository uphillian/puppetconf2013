import "defaults.pp"

# kermit will be the email server
node kermit {
  include postfix::master
  include dns::client
}

node piggy {
  include dns::client
}

# gonzo will do dns
node gonzo {
  include postfix::client
  include dns::server
  include dns::client
}
# jim will be the puppetmaster
# jim will do dns
node jim {
  include dns::server
  include puppetmaster 
  include dns::client
}

# everybody else gets standard
node default {
  include standard
}
