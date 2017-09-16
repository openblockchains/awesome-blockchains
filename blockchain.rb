###########################
#  build your own blockchain from scratch in 20 lines of ruby!
#
#   inspired by
#     Let's Build the Tiniest Blockchain In Less Than 50 Lines of Python by Gerald Nash
#     see https://medium.com/crypto-currently/lets-build-the-tiniest-blockchain-e70965a248b
#
#
#  to run use:
#    $ ruby ./blockchain.rb


require "digest"    # for hash checksum digest function SHA256
require "pp"        # for pp => pretty printer


class Block

  attr_reader :index
  attr_reader :timestamp
  attr_reader :data
  attr_reader :previous_hash
  attr_reader :hash

  def initialize(index, timestamp, data, previous_hash)
    @index         = index
    @timestamp     = timestamp
    @data          = data
    @previous_hash = previous_hash
    @hash          = calc_hash
  end

  def self.first( data="Genesis" )    # create genesis (big bang! first) block
    ## uses index zero and arbitrary previous_hash
    Block.new( 0, Time.now, data, "0" )
  end

  def self.next( previous, data="Transaction Data..." )
    Block.new( previous.index+1, Time.now, data, previous.hash )
  end

private
	
  def calc_hash
    sha = Digest::SHA256.new
    sha.update( @index.to_s + @timestamp.to_s + @data.to_s + @previous_hash.to_s )
    sha.hexdigest
  end
	
end  # class Block


#####
## let's get started
##   build a blockchain a block at a time

b0 = Block.first( "Genesis" )
b1 = Block.next( b0, "Transaction Data..." )
b2 = Block.next( b1, "Transaction Data......" )
b3 = Block.next( b2, "More Transaction Data..." )

blockchain = [b0, b1, b2, b3]

pp blockchain

######
#  will pretty print (pp) something like:
#
# [#<Block:0x1eed2a0
#   @data="Genesis",
#   @hash="edbd4e11e69bc399a9ccd8faaea44fb27410fe8e3023bb9462450a0a9c4caa1b",
#   @index=0,
#   @previous_hash="0",
#   @timestamp=2017-09-15 20:52:38 +0200>,
#  #<Block:0x1eec9a0
#   @data="Transaction Data...",
#   @hash="eb8ecbf6d5870763ae246e37539d82e37052cb32f88bb8c59971f9978e437743",
#   @index=1,
#   @previous_hash="edbd4e11e69bc399a9ccd8faaea44fb27410fe8e3023bb9462450a0a9c4caa1b",
#   @timestamp=2017-09-15 20:52:38 +0200>,
#  #<Block:0x1eec838
#   @data="Transaction Data......",
#   @hash="be50017ee4bbcb33844b3dc2b7c4e476d46569b5df5762d14ceba9355f0a85f4",
#   @index=2,
#   @previous_hash="eb8ecbf6d5870763ae246e37539d82e37052cb32f88bb8c59971f9978e437743",
#   @timestamp=2017-09-15 20:52:38 +0200>,
#  #<Block:0x1eec6d0
#   @data="More Transaction Data...",
#   @hash="5ee2981606328abfe0c3b1171440f0df746c1e1f8b3b56c351727f7da7ae5d8d",
#   @index=3,
#   @previous_hash="be50017ee4bbcb33844b3dc2b7c4e476d46569b5df5762d14ceba9355f0a85f4",
#   @timestamp=2017-09-15 20:52:38 +0200>]
