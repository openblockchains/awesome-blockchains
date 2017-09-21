###########################
#  build your own blockchain from scratch in python3!
#
#  to run use:
#    $ python ./blockchain_with_proof_of_work.py


import hashlib as hasher
import datetime as date
import pprint


class Block:
  def __init__( self, index, data, previous_hash ):
    self.index              = index
    self.timestamp          = date.datetime.now()
    self.data               = data
    self.previous_hash      = previous_hash
    self.nonce, self.hash   = self.compute_hash_with_proof_of_work()

  def compute_hash_with_proof_of_work( self ):
    nonce = 0
    while True:    ## loop forever
      hash = self.calc_hash_with_nonce( nonce )
      if hash.startswith( "00" ):
        return [nonce,hash]    ## bingo! proof of work if hash starts with leading zeros (00)
      else:
        nonce += 1             ## keep trying (and trying and trying)

  def calc_hash_with_nonce( self, nonce=0 ):
    sha = hasher.sha256()
    sha.update(str(nonce).encode("utf-8") +
               str(self.index).encode("utf-8") +
               str(self.timestamp).encode("utf-8") +
               str(self.data).encode("utf-8") +
               str(self.previous_hash).encode("utf-8"))
    return sha.hexdigest()


  def __repr__( self ):
        return "Block<\n  index: {},\n  timestamp: {},\n  data: {},\n  previous_hash: {},\n  nonce: {},\n  hash: {}>".format(
          self.index, self.timestamp, self.data, self.previous_hash, self.nonce, self.hash)


  @staticmethod
  def first( data="Genesis" ):
    return Block( 0, data, "0" )

  @staticmethod
  def next( previous, data="Transaction Data..." ):
    return Block( previous.index+1, data, previous.hash )



#####
## let's get started
##   build a blockchain a block at a time

b0 = Block.first( "Genesis" )
b1 = Block.next( b0, "Transaction Data..." )
b2 = Block.next( b1, "Transaction Data......" )
b3 = Block.next( b2, "More Transaction Data..." )


blockchain = [b0, b1, b2, b3]

pprint.pprint( blockchain )

######
#  will pretty print something like:
#
# [Block<
#   index: 0,
#   timestamp: 2017-09-21 08:20:55.369288,
#   data: Genesis,
#   previous_hash: 0,
#   nonce: 522,
#   hash: 00f8d728c43331952794b6a9684a5c9838cdf9dc5664f218c8b84722d3ee9eae>,
#  Block<
#   index: 1,
#   timestamp: 2017-09-21 08:20:55.374494,
#   data: Transaction Data...,
#   previous_hash: 00f8d728c43331952794b6a9684a5c9838cdf9dc5664f218c8b84722d3ee9eae,
#   nonce: 80,
#   hash: 00f2ef4939c5ff5572f38b82907594a02cfcad01c815e8370dd10b3b912120a0>,
#  Block<
#   index: 2,
#   timestamp: 2017-09-21 08:20:55.374494,
#   data: Transaction Data......,
#   previous_hash: 00f2ef4939c5ff5572f38b82907594a02cfcad01c815e8370dd10b3b912120a0,
#   nonce: 19,
#   hash: 0004d93f5759596f423c9d91c8cb75b7cb38952b05da7842226c5bf93ce43902>,
#  Block<
#   index: 3,
#   timestamp: 2017-09-21 08:20:55.390116,
#   data: More Transaction Data...,
#   previous_hash: 0004d93f5759596f423c9d91c8cb75b7cb38952b05da7842226c5bf93ce43902,
#   nonce: 325,
#   hash: 001b8d1567dacf94ac036644a290212697a2ece6757951018beecd6cf3c076b2>]
