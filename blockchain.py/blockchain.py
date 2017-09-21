###########################
#  build your own blockchain from scratch in python3!
#
#   inspired by
#     Let's Build the Tiniest Blockchain In Less Than 50 Lines of Python by Gerald Nash
#     see https://medium.com/crypto-currently/lets-build-the-tiniest-blockchain-e70965a248b
#
#
#  to run use:
#    $ python ./blockchain.py

import hashlib as hasher
import datetime as date
import pprint


class Block:
  def __init__( self, index, data, previous_hash ):
    self.index         = index
    self.timestamp     = date.datetime.now()
    self.data          = data
    self.previous_hash = previous_hash
    self.hash          = self.calc_hash()

  def calc_hash( self ):
    sha = hasher.sha256()
    sha.update(str(self.index).encode("utf-8") +
               str(self.timestamp).encode("utf-8") +
               str(self.data).encode("utf-8") +
               str(self.previous_hash).encode("utf-8"))
    return sha.hexdigest()

  def __repr__( self ):
        return "Block<\n  index: {},\n  timestamp: {},\n  data: {},\n  previous_hash: {},\n  hash: {}>".format(
          self.index, self.timestamp, self.data, self.previous_hash, self.hash)


  @staticmethod
  def first( data="Genesis" ):
    return Block( 0, data, "0" )

  @staticmethod
  def next( previous, data="Transaction Data..." ):
    return Block( previous.index + 1, data, previous.hash )



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
#  [Block<
#    index: 0,
#    timestamp: 2017-09-19 19:21:04.015584,
#    data: Genesis,
#    previous_hash: 0,
#    hash: b0cb7953bfad60415ea3b5d3b8015ee22c89d43351ea8f53e5367ee06193b1d3>,
#   Block<
#    index: 1,
#    timestamp: 2017-09-19 19:21:04.015584,
#    data: Transaction Data...,
#    previous_hash: b0cb7953bfad60415ea3b5d3b8015ee22c89d43351ea8f53e5367ee06193b1d3,
#    hash: a87707b2867d28e7367c74e4a2800ec112ea2a8b1517a332ad0b4c49c3b3d60b>,
#   Block<
#    index: 2,
#    timestamp: 2017-09-19 19:21:04.015584,
#    data: Transaction Data......,
#    previous_hash: a87707b2867d28e7367c74e4a2800ec112ea2a8b1517a332ad0b4c49c3b3d60b,
#    hash: 9a8aecdd62da47301502f0079aa1bf24dcf39ad392c723baef6b9bfbc927cf4e>,
#   Block<
#    index: 3,
#    timestamp: 2017-09-19 19:21:04.015584,
#    data: More Transaction Data...,
#    previous_hash: 9a8aecdd62da47301502f0079aa1bf24dcf39ad392c723baef6b9bfbc927cf4e,
#    hash: 5ef442875fb8c3e18d08531f3eba26ea75b608604fa0cc75715d76e15edbb5ea>]
