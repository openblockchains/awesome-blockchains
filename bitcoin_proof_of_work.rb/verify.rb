###
#   type to run:
#     $ ruby ./verify.rb

require 'digest'

def sha256( msg )
  Digest::SHA256.hexdigest( msg )
end



nonce = 4250
msg   = "Hello, world!"

p hash = sha256( "#{msg}#{nonce}" )
#=> "0000c3af42fc31103f1fdc0151fa747ff87349a4714df7cc52ea464e12dcd4e9"

p target = 2**240
#=> 1766847064778384329583297500742918515827483896875618958121606201292619776
p num    = hash.to_i(16)
#=> 1350565582647790482127632554504241516291697500941742491868079705537959145

p num < target
#=> true
