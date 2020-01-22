###
#   type to run:
#     $ ruby ./hashes.rb

require "digest"

def sha256( msg )
  Digest::SHA256.hexdigest( msg )
end



p sha256( "Hello, world!0" )
#=> "1312af178c253f84028d480a6adc1e25e81caa44c749ec81976192e2ec934c64"
p sha256( "Hello, world!1" )
#=> "e9afc424b79e4f6ab42d99c81156d3a17228d6e1eef4139be78e948a9332a7d8"
p sha256( "Hello, world!2" )
#=> "ae37343a357a8297591625e7134cbea22f5928be8ca2a32aa475cf05fd4266b7"

# ...

p sha256( "Hello, world!4248" )
#=> "6e110d98b388e77e9c6f042ac6b497cec46660deef75a55ebc7cfdf65cc0b965"
p sha256( "Hello, world!4249" )
#=> "c004190b822f1669cac8dc37e761cb73652e7832fb814565702245cf26ebb9e6"
p sha256( "Hello, world!4250" )
#=> "0000c3af42fc31103f1fdc0151fa747ff87349a4714df7cc52ea464e12dcd4e9"
