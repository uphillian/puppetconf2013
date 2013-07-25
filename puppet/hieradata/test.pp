$dom = hiera('dom')
notify { "domain is $dom": }
