# reverse.rb
# Set a fact for the reverse lookup of the network on eth0

require('ipaddr')

ip = IPAddr.new(Facter.value('network_eth0'))

# return the reverse to facter
Facter.add("reverse_eth0") do
  setcode do ip.reverse.to_s[2..-1] end
end
