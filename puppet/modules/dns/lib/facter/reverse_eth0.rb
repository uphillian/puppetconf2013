# reverse.rb
# Set a fact for the reverse lookup of the network on eth0

require 'ipaddr'
require 'puppet/util/ipcidr'


ip = IPAddr.new(Facter.value('network_eth0'))
nm = Puppet::Util::IPCidr.new(Facter.value('network_eth0')).mask(Facter.value('netmask_eth0'))
cidr = nm.cidr

# return the reverse to facter
Facter.add("reverse_eth0") do
  setcode do ip.reverse.to_s[2..-1] end
end
Facter.add("network_cidr_eth0") do
  setcode do cidr end
end
