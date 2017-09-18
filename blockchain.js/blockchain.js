//////////////////////////////////////////////////
//  build your own blockchain from scratch in 20 lines of javascript!
//
//   inspired by
//     Let's Build the Tiniest Blockchain In Less Than 50 Lines of Python by Gerald Nash
//     see https://medium.com/crypto-currently/lets-build-the-tiniest-blockchain-e70965a248b
//
//
//  to run use:
//   $ npm install        -- or npm install -g js-sha256
//   $ node ./blockchain.js


const SHA256 = require( "js-sha256" )     // for hash checksum digest function SHA256


class Block {

  constructor(index, data, previousHash) {
    this.index        = index
    this.timestamp    = new Date()
    this.data         = data
    this.previousHash = previousHash
    this.hash         = this.calcHash()
  }

  calcHash() {
    var sha = SHA256.create()
    sha.update( this.index.toString() + this.timestamp.toString() + this.data + this.previousHash )
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
//  [ Block {
//      index: 0,
//      timestamp: 2017-09-18T08:25:54.162Z,
//      data: 'Genesis',
//      previousHash: '0',
//      hash: 'c396de4c03ddb5275661982adc75ce5fc5905d2a2457d1266c74436c1f3c50f1' },
//    Block {
//      index: 1,
//      timestamp: 2017-09-18T08:25:54.178Z,
//      data: 'Transaction Data...',
//      previousHash: 'c396de4c03ddb5275661982adc75ce5fc5905d2a2457d1266c74436c1f3c50f1',
//      hash: '493131e09c069645c82795c96e4715cea0f5558be514b5096d853a5b9899154a' },
//    Block {
//      index: 2,
//      timestamp: 2017-09-18T08:25:54.178Z,
//      data: 'Transaction Data......',
//      previousHash: '493131e09c069645c82795c96e4715cea0f5558be514b5096d853a5b9899154a',
//      hash: '97aa3cb5052615d60ff8e6b41bef606562588c4874f011970ac2f218e2f0f4a8' },
//    Block {
//      index: 3,
//      timestamp: 2017-09-18T08:25:54.178Z,
//      data: 'More Transaction Data...',
//      previousHash: '97aa3cb5052615d60ff8e6b41bef606562588c4874f011970ac2f218e2f0f4a8',
//      hash: 'e10e020f832e46c2b60e1c3c0412bd370b2fde5f0f782c16eb87d0313ea0d3a3' } ]
