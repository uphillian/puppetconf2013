import "defaults.pp"

# kermit will be the email server
node kermit {
  include postfix::master
  include standard
}

# piggy will be the func master
node piggy {
  include func::master
  include standard
}

# everybody else gets standard
node default {
  include standard
}
