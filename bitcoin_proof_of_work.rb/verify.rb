###
#   type to run:
#     $ ruby ./verify.rb

require 'digest'

def sha256( msg )
  Digest::SHA256.hexdigest( msg )
end



nonce = 4250
msg   = "Hello, world!"

difficulty = 2**240
hash = sha256( "#{msg}#{nonce}" )
num  = hash.to_i(16)

p num < difficulty
#=> true
