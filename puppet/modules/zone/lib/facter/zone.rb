# zone.rb
# Set a fact for the zone

require('ipaddr')

ip = IPAddr.new(Facter.value('ipaddress'))

# use CIDR for zones
zones = {
 'prod' => IPAddr.new('192.168.120.0/23'),
 'dev'  => IPAddr.new('192.168.122.0/23'),
 'sbx'  => IPAddr.new('192.160.124.0/23'),
 }

# default to undefined for now
zone = 'undef'

# loop through the zones, using ipaddr's built in include? function
# to see if the ipaddress is in the zone.
for z in zones.keys do
  if zones[z].include?(ip)
     zone = z
  end
end

# return the net_zone to facter
Facter.add("zone") do
  setcode do zone end
end
