/////////////////////////////////////////////////////////////////////
//  to run use:
//   $ npm install        -- or npm install -g js-sha256
//   $ node ./blockchain_with_proof_of_work.js


const SHA256 = require( "js-sha256" )     // for hash checksum digest function SHA256


class Block {

  constructor(index, data, previousHash) {
    this.index             = index
    this.timestamp         = new Date()
    this.data              = data
    this.previousHash      = previousHash
    this.nonce, this.hash  = this.computeHashWithProofOfWork()
  }

  computeHashWithProofOfWork( difficulty="00" ) {
    var nonce = 0
    while( true ) {
      var hash = this.calcHashWithNonce( nonce )
      if( hash.startsWith( difficulty ))
        return nonce, hash    // bingo! proof of work if hash starts with leading zeros (00)
      else
        nonce += 1            // keep trying (and trying and trying)
    }
  }

  calcHashWithNonce( nonce=0 ) {
    var sha = SHA256.create()
    sha.update( nonce.toString() + this.index.toString() + this.timestamp.toString() + this.data + this.previousHash )
    return sha.hex()
  }


  static first( data="Genesis" ) {    // create genesis (big bang! first) block
    // uses index zero (0) and arbitrary previousHash ("0")
    return new Block( 0, data, "0" )
  }

  static next( previous, data="Transaction Data..." ) {
    return new Block( previous.index+1, data, previous.hash )
  }
}


//////
// let's get started
//   build a blockchain a block at a time

b0 = Block.first( "Genesis" )
b1 = Block.next( b0, "Transaction Data..." )
b2 = Block.next( b1, "Transaction Data......" )
b3 = Block.next( b2, "More Transaction Data..." )


blockchain = [b0, b1, b2, b3]

console.log( blockchain )



//////////////////////////////////
//  will log something like:
//
// [ Block {
//     index: 0,
//     timestamp: 2017-09-22T18:08:36.587Z,
//     data: 'Genesis',
//     previousHash: '0',
//     hash: '003dabacd06e208f5c5625777a49778e279516e0b43f6126a478a68791bd9789' },
//   Block {
//     index: 1,
//     timestamp: 2017-09-22T18:08:36.603Z,
//     data: 'Transaction Data...',
//     previousHash: '003dabacd06e208f5c5625777a49778e279516e0b43f6126a478a68791bd9789',
//     hash: '006760687f42f82d4ba93b7b6c8459184b8e871608ffc230f2bbe6af6c5bd260' },
//   Block {
//     index: 2,
//     timestamp: 2017-09-22T18:08:36.603Z,
//     data: 'Transaction Data......',
//     previousHash: '006760687f42f82d4ba93b7b6c8459184b8e871608ffc230f2bbe6af6c5bd260',
//     hash: '00a7f2a8d3b718b48ddbbb41cab158e160540625568255e0cbca33c83437f0f7' },
//   Block {
//     index: 3,
//     timestamp: 2017-09-22T18:08:36.603Z,
//     data: 'More Transaction Data...',
//     previousHash: '00a7f2a8d3b718b48ddbbb41cab158e160540625568255e0cbca33c83437f0f7',
//     hash: '00e9fd5ffbce8c2bc95243c781506b366985ba726a15e02597e42f8598498800' } ]
