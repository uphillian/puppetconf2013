class hiera_test {
$dom = hiera('dom')
notify {"domain is $dom": }
}
