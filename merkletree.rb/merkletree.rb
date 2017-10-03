###############################################
#  build your own merkletree from scratch
#
# inspired by building a merkle tree (in c++) in the book
#    Mastering Bitcoin - Programming the Open Blockchain
#     see https://github.com/bitcoinbook/bitcoinbook/blob/second_edition/ch09.asciidoc#merkle-trees
#
#  to run use:
#    $ ruby ./merkletree.rb
#
#
#  todos/check:
#     hwo to combine hash pairs? - for now the two hexdigests get joined


require "digest"    # for hash checksum digest function SHA256
require "pp"        # for pp => pretty printer


def calc_hash( data )
  sha = Digest::SHA256.new
  sha.update( data )
  sha.hexdigest
end

def compute_merkletree_hash( hashes )

  if hashes.empty?
    return "0"   ## return null hash (fix: what's the (proper) null hash?)
  elsif hashes.size == 1
    return hashes[0]
  else
    ## while there's more than one hash in the list, keep looping...
    while hashes.size > 1
      # if number of hashes is odd e.g. 3,5,7,etc., duplicate last hash in list
      hashes << hashes[-1]   if hashes.size % 2 != 0

      ## new hash list
      new_hashes = []
      ## loop through hashes two at a time
      hashes.each_slice(2) do |slice|
        ## join both hashes slice[0]+slice[1] together
        hash = calc_hash( slice[0]+slice[1] )
        new_hashes << hash
      end
      hashes = new_hashes

      ## debug output
      puts "current merkle hash list (#{hashes.size}):"
      pp hashes
    end
    ### finally we end up with a single hash
    hashes[0]
   end
end # method compute_merkletree_hash


hashes = [
  "0000000000000000000000000000000000000000000000000000000000000000",
  "0000000000000000000000000000000000000000000000000000000000000011",
  "0000000000000000000000000000000000000000000000000000000000000022"
]

hash = compute_merkletree_hash( hashes )

puts "merkletree hash:"
puts hash


######
#  will print something like:
#
# current merkle hash list (2):
#   ["4ff2b6e318d979927a8c780b5e16cf36dc11ee9f95c5f132279d52f21a051520",
#    "4d479b4b92c57b9bfcd55f7b674f66f098af8c8de1036b4c419b427c6cd31c83"]
# current merkle hash list (1):
#   ["5bffe87c7fd53d98f166661dd6a2d368ba0acc0b5c773d8426f4f153ff23125c"]
# merkletree hash:
#     5bffe87c7fd53d98f166661dd6a2d368ba0acc0b5c773d8426f4f153ff23125c
