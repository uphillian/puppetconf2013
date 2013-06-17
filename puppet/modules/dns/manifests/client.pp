class dns::client {
 file {'/tmp/resolv.conf':
   content => template('dns/resolv.conf.erb')
 }
}
