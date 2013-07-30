class standard {

# default class
# every node on the network will need these settings

#  include func::minion
  include postfix::client
  include dns::client
  Host <<| tag == 'puppet' |>>
}
