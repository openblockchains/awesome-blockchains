###
#   type to run:
#     $ ruby ./proof_of_work.rb

require "digest"

def sha256( msg )
  Digest::SHA256.hexdigest( msg )
end



def mine_hash_with_proof_of_work( msg, target: 2**240 )
  nonce = 0
  loop do
    hash = sha256( "#{msg}#{nonce}" )

    if hash.to_i(16) < target
      ## bingo! proof of work if hash is smaller than the difficulty target number
      return [nonce,hash]
    else
      ## keep trying (and trying and trying)
      nonce += 1
    end
  end # loop
end


p 2**240    # 2^240
#=> 1766847064778384329583297500742918515827483896875618958121606201292619776

nonce, hash = mine_hash_with_proof_of_work( "Hello, world!", target: 2**240)
p nonce
#=> 4250
p hash
#=> "0000c3af42fc31103f1fdc0151fa747ff87349a4714df7cc52ea464e12dcd4e9"
