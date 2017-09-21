
Mining Digital Gold one Block at a Time?! • Don't Expect to Get Insanely Rich (Quick) • Tulips :tulip::tulip::tulip: (like Blockchains) are Great and Gorgeous (and will Endure)  



# Awesome Blockchains

A collection about awesome blockchains - open distributed databases w/ crypto hashes incl. git ;-).  Blockchains are the new tulips :tulip::tulip::tulip:.

Contents:

- [Frequently Asked Questions (F.A.Q.s) & Answers](#frequently-asked-questions-faqs--answers)
- [Do-It-Yourself (DIY) - Build Your Own Blockchain](#do-it-yourself-diy---build-your-own-blockchain)
- [Blockchain Articles](#blockchain-articles)
- [Blockchain Books](#blockchain-books)
- [Blockchain (Lite) Crypto Hash Libraries](#blockchain-lite-crypto-hash-libraries)
- [Git, Git, Git - The Stupid Content Tracker with Crypto Hashes](#git-git-git---the-stupid-content-tracker-with-crypto-hashes)
- [Classic Tulip Mania](#classic-tulip-mania)



## Frequently Asked Questions (F.A.Q.s) & Answers

**Q: What's a Blockchain?**

A: A blockchain is a distributed database with a linked list (that is, chain) of records (that is, blocks) secured by crypto(graphic) hashes.

**Q: What's a Merkle Tree?**

A: A Merkle tree is a hash tree named after Ralph Merkle who patented the concept in 1979
(the patent expired in 2002). A hash tree is a generalization of hash lists or hash chains where every leaf node (in the tree) is labelled with a data block and every non-leaf node (in the tree)
is labelled with the crypto(graphic) hash of the labels of its child nodes. For more see the [Merkle tree](https://en.wikipedia.org/wiki/Merkle_tree) Wikipedia Article.

Note: By adding crypto(graphic) hash functions you can "merkelize" any data structure.

**Q: What's a Merkelized DAG (Directed Acyclic Graph)?**

A: It's a blockchain secured by crypto(graphic) hashes that uses a directed acyclic graph data structure (instead of linear "classic" linked list).

Note: Git uses merkelized dag (directed acyclic graph)s for its blockchains.

**Q: Is the Git Repo a Blockchain?**

A: Yes, every branch in the git repo is a blockchain.
The "classic" Satoshi-blockchain is like a git repo with a single master branch (only).



**Q: What's a Hash? What's a (One-Way) Crypto(graphic) Hash Digest Checksum**?

A: A hash e.g. `eb8ecbf6d5870763ae246e37539d82e37052cb32f88bb8c59971f9978e437743`
is a small digest checksum calculated
with a one-way crypto(graphic) hash digest checksum function
e.g. SHA256 (Secure Hash Algorithm 256 Bits)
from the data. Example from [`blockchain.rb`](blockchain.rb/blockchain.rb):

```ruby
def calc_hash
  sha = Digest::SHA256.new
  sha.update( @index.to_s + @timestamp.to_s + @data + @previous_hash )
  sha.hexdigest   ## returns "eb8ecbf6d5870763ae246e37539d82e37052cb32f88bb8c59971f9978e437743"
end
```

A blockchain uses

- the block index (e.g. `1`,`2`,`3`,`4`, etc.) and
- the block timestamp (e.g. `2017-09-15 20:52:38`) and
- the block data (e.g. `Transaction Data...`) and finally
- the hash from the previous block (e.g. `edbd4e11e69bc399a9ccd8faaea44fb27410fe8e3023bb9462450a0a9c4caa1b`)

to calculate the new hash digest checksum, that is, the hash
e.g. `be50017ee4bbcb33844b3dc2b7c4e476d46569b5df5762d14ceba9355f0a85f4`.



## Do-It-Yourself (DIY) - Build Your Own Blockchain

![](i/fake-dilbert-blockchain.png)

### Articles

[**Let's Build the Tiniest Blockchain In Less Than 50 Lines of Python**](https://medium.com/crypto-currently/lets-build-the-tiniest-blockchain-e70965a248b)
by Gerald Nash, July 2016

[**Let's Make the Tiniest Blockchain Bigger With More Lines of Python (Part 2)**](https://medium.com/crypto-currently/lets-make-the-tiniest-blockchain-bigger-ac360a328f4d)
by Gerald Nash, July 2016

[**Writing a Tiny Blockchain in JavaScript**](https://www.savjee.be/2017/07/Writing-tiny-blockchain-in-JavaScript/)
by Xavier Decuyper, July 2017


### Samples

#### Blockchain from Scratch - Ruby Version

```ruby
class Block

  attr_reader :index
  attr_reader :timestamp
  attr_reader :data
  attr_reader :previous_hash
  attr_reader :hash

  def initialize(index, data, previous_hash)
    @index         = index
    @timestamp     = Time.now
    @data          = data
    @previous_hash = previous_hash
    @hash          = calc_hash
  end

  def self.first( data="Genesis" )    # create genesis (big bang! first) block
    ## uses index zero (0) and arbitrary previous_hash ("0")
    Block.new( 0, data, "0" )
  end

  def self.next( previous, data="Transaction Data..." )
    Block.new( previous.index+1, data, previous.hash )
  end

private

  def calc_hash
    sha = Digest::SHA256.new
    sha.update( @index.to_s + @timestamp.to_s + @data + @previous_hash )
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

```

(Source: [`blockchain.rb`](blockchain.rb/blockchain.rb))

will pretty print (pp) something like:

```
[#<Block:0x1eed2a0
  @index         = 0,
  @timestamp     = 2017-09-15 20:52:38,
  @data          = "Genesis",
  @previous_hash = "0",
  @hash          = "edbd4e11e69bc399a9ccd8faaea44fb27410fe8e3023bb9462450a0a9c4caa1b">,
 #<Block:0x1eec9a0
  @index         = 1,
  @timestamp     = 2017-09-15 20:52:38,
  @data          = "Transaction Data...",
  @previous_hash = "edbd4e11e69bc399a9ccd8faaea44fb27410fe8e3023bb9462450a0a9c4caa1b",
  @hash          = "eb8ecbf6d5870763ae246e37539d82e37052cb32f88bb8c59971f9978e437743">,
 #<Block:0x1eec838
  @index         = 2,
  @timestamp     = 2017-09-15 20:52:38,
  @data          = "Transaction Data......",
  @previous_hash = "eb8ecbf6d5870763ae246e37539d82e37052cb32f88bb8c59971f9978e437743",
  @hash          = "be50017ee4bbcb33844b3dc2b7c4e476d46569b5df5762d14ceba9355f0a85f4">,
 #<Block:0x1eec6d0
  @index         = 3,
  @timestamp     = 2017-09-15 20:52:38,
  @data          = "More Transaction Data...",
  @previous_hash = "be50017ee4bbcb33844b3dc2b7c4e476d46569b5df5762d14ceba9355f0a85f4",
  @hash          = "5ee2981606328abfe0c3b1171440f0df746c1e1f8b3b56c351727f7da7ae5d8d">]
```


Comments from the [reddit ruby posting](https://www.reddit.com/r/ruby/comments/70c30f/build_your_own_blockchain_in_20_lines_of_ruby/):

> Wait, so a blockchain is just a linked list?
>
>> No. A linked list is only required to have a reference to the previous element, a block must
>> have an identifier depending on the previous block's identifier, meaning that you cannot
>> replace a block without recomputing every single block that comes after.
>> In this implementation that happens as the previous digest is input in the calc_hash method.


**What about Proof of Work?**

Let's add a proof of work to the blockchain. In the classic blockchain you have to compute a block hash that starts with leading zeros (`00`). The more leading zeros the harder (more difficult) to compute. Let's keep it easy to compute with two leading zeros (`00`), that is, 16^2 = 256 possibilites. Three leading zeros (`000`) would be 16^3 = 4_096 possibilites and four zeros (`0000`) would be 16^4 = 65_536 and so on. Example:

```ruby
def compute_hash_with_proof_of_work
  nonce = 0
  loop do
    hash = calc_hash_with_nonce( nonce )
    if hash.start_with?( "00" )  
      return [nonce,hash]     ## bingo! proof of work if hash starts with leading zeros (00)
    else
      nonce += 1              ## keep trying (and trying and trying)
    end
  end
end

def calc_hash_with_nonce( nonce=0 )
  sha = Digest::SHA256.new
  sha.update( nonce.to_s + @index.to_s + @timestamp.to_s + @data + @previous_hash )
  sha.hexdigest
end
```

(Source: [`blockchain_with_proof_of_work.rb`](blockchain.rb/blockchain_with_proof_of_work.rb))

Let's rerun the sample with the proof of work machinery added.
Now the sample will pretty print (pp) something like:

```
[#<Block:0x1e204f0
  @index         = 0,
  @timestamp     = 2017-09-20 20:13:38,
  @data          = "Genesis",
  @previous_hash = "0",
  @nonce         = 242,
  @hash          = "00b8e77e27378f9aa0afbcea3a2882bb62f6663771dee053364beb1887e18bcf">,
 #<Block:0x1e56e20
  @index         = 1,
  @timestamp     = 2017-09-20 20:13:38,
  @data          = "Transaction Data...",
  @previous_hash = "00b8e77e27378f9aa0afbcea3a2882bb62f6663771dee053364beb1887e18bcf",
  @nonce         = 46,
  @hash          = "00aae8d2e9387e13c71b33f8cd205d336ac250d2828011f5970062912985a9af">,
 #<Block:0x1e2bd58
  @index         = 2,
  @timestamp     = 2017-09-20 20:13:38,
  @data          = "Transaction Data......",
  @previous_hash = "00aae8d2e9387e13c71b33f8cd205d336ac250d2828011f5970062912985a9af",
  @nonce         = 350,
  @hash          = "00ea45e0f4683c3bec4364f349ee2b6816be0c9fd95cfd5ffcc6ed572c62f190">,
 #<Block:0x1fa8338
  @index         = 3,
  @timestamp     = 2017-09-20 20:13:38,
  @data          = "More Transaction Data...",
  @previous_hash = "00ea45e0f4683c3bec4364f349ee2b6816be0c9fd95cfd5ffcc6ed572c62f190",
  @nonce         = 59,
  @hash          = "00436f0fca677652963e904ce4c624606a255946b921132d5b1f70f7d86c4ab8">]
```

See the difference? All hashes now start with leading zeros (`00`) and the nonce is the random "lucky number"
that makes it happen. That's the magic behind the proof of work.


##### Blockchain from Scratch - JavaScript Version

```js
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
```

(Source: [`blockchain.js`](blockchain.js/blockchain.js))

will log something like:

```
[ Block {
     index        : 0,
     timestamp    : 2017-09-18T08:25:54.162Z,
     data         : 'Genesis',
     previousHash : '0',
     hash         : 'c396de4c03ddb5275661982adc75ce5fc5905d2a2457d1266c74436c1f3c50f1' },
   Block {
     index        : 1,
     timestamp    : 2017-09-18T08:25:54.178Z,
     data         : 'Transaction Data...',
     previousHash : 'c396de4c03ddb5275661982adc75ce5fc5905d2a2457d1266c74436c1f3c50f1',
     hash         : '493131e09c069645c82795c96e4715cea0f5558be514b5096d853a5b9899154a' },
   Block {
     index        : 2,
     timestamp    : 2017-09-18T08:25:54.178Z,
     data         : 'Transaction Data......',
     previousHash : '493131e09c069645c82795c96e4715cea0f5558be514b5096d853a5b9899154a',
     hash         : '97aa3cb5052615d60ff8e6b41bef606562588c4874f011970ac2f218e2f0f4a8' },
   Block {
     index        : 3,
     timestamp    : 2017-09-18T08:25:54.178Z,
     data         : 'More Transaction Data...',
     previousHash : '97aa3cb5052615d60ff8e6b41bef606562588c4874f011970ac2f218e2f0f4a8',
     hash         : 'e10e020f832e46c2b60e1c3c0412bd370b2fde5f0f782c16eb87d0313ea0d3a3' } ]
```


## Blockchain Articles

[**Blockchains by analogies and applications: How blockchain compares to Git, Raft, and other technologies.**](https://www.oreilly.com/ideas/blockchains-by-analogies-and-applications)
by Kieren James-Lubin, January 2016 --
_Blockchains are databases ++
Understanding transactions ++
Persistent, replicated databases (related technology: Git) ++
Peer-to-peer networks (related technology: BitTorrent) ++
Distributed consensus (related technology: distributed databases, Raft) ++
Minting new coins (mining) ++
Embedded identities (related technology: TLS) ++
Smart contracts: Like SQL expressions & triggers ++
What can we really do with blockchains?_


[**Reflections on the Blockchain**](http://rufuspollock.com/2016/07/02/reflections-on-the-blockchain) by Rufus Pollock (Open Knowledge Foundation), July 2016 --
_The DAO: Code is not Law – and It’s Dangerous to Think So ++
The Internet changed the world - surely the Blockchain will too? ++
Gold-rush or Internet-rush? ++
Governance Matters in Bitcoin ++
The Myth of a Costless, Ownerless Network ++
Lessons from History_

[**On the Dangers of a Blockchain Monoculture**](https://tonyarcieri.com/on-the-dangers-of-a-blockchain-monoculture) by Tony Arcieri, January 2016 --
_The Bitcoin blockchain: the world's worst database ++
Next-generation protocols ++
Decentralized ledger protocols ++
Bitcoin-NG ++
Blockchain! Blockchain! Blockchain! ++
The great decentralized database in the sky_


[**I Don’t Believe in Blockchain**](https://www.tbray.org/ongoing/When/201x/2017/05/13/Not-Believing-in-Blockchain) by Tim Bray, May 2017



## Blockchain Books

[**Attack of the 50 Foot Blockchain: Bitcoin, Blockchain, Ethereum & Smart Contracts**](https://davidgerard.co.uk/blockchain/table-of-contents/) by David Gerard, London, 2017 --
_What is a bitcoin? ++
The Bitcoin ideology ++
The incredible promises of Bitcoin! ++
Early Bitcoin: the rise to the first bubble ++
How Bitcoin mining centralised ++
Who is Satoshi Nakamoto? ++
Spending bitcoins in 2017 ++
Trading bitcoins in 2017: the second crypto bubble ++
Altcoins ++
Smart contracts, stupid humans ++
Business bafflegab, but on the Blockchain ++
Case study: Why you can’t put the music industry on a blockchain_

[**Mastering Bitcoin - Programming the Open Blockchain**](https://github.com/bitcoinbook/bitcoinbook/blob/second_edition/ch09.asciidoc) 2nd Edition,
by Andreas M. Antonopoulos, 2017 - FREE (Online Source Version) --
_What Is Bitcoin? ++
How Bitcoin Works ++
Bitcoin Core: The Reference Implementation ++
Keys, Addresses ++
Wallets ++
Transactions ++
Advanced Transactions and Scripting ++
The Bitcoin Network ++
The Blockchain ++
Mining and Consensus ++
Bitcoin Security ++
Blockchain Applications_



## Blockchain (Lite) Crypto Hash Libraries

### Ruby

**blockchain.lite** (github: [openblockchains/blockchain.lite.rb](https://github.com/openblockchains/blockchain.lite.rb),
gem: [blockchainlite](https://rubygems.org/gems/blockchainlite)) -
build your own blockchain with crypto hashes -
revolutionize the world with blockchains, blockchains, blockchains one block at a time

```ruby
require 'blockchainlite'

b0 = Block.first( "Genesis" )
b1 = Block.next( b0, "Transaction Data..." )
b2 = Block.next( b1, "Transaction Data......" )
b3 = Block.next( b2, "More Transaction Data..." )

blockchain = [b0, b1, b2, b3]

pp blockchain   
```

will pretty print (pp) something like:

```
[#<Block:0x1eed2a0
  @index         = 0,
  @timestamp     = 2017-09-15 20:52:38,
  @data          = "Genesis",
  @previous_hash = "0",
  @hash          = "edbd4e11e69bc399a9ccd8faaea44fb27410fe8e3023bb9462450a0a9c4caa1b">,
 #<Block:0x1eec9a0
  @index         = 1,
  @timestamp     = 2017-09-15 20:52:38,
  @data          = "Transaction Data...",
  @hash          = "eb8ecbf6d5870763ae246e37539d82e37052cb32f88bb8c59971f9978e437743",
  @previous_hash = "edbd4e11e69bc399a9ccd8faaea44fb27410fe8e3023bb9462450a0a9c4caa1b">,
  ...
```



## Git, Git, Git - The Stupid Content Tracker with Crypto Hashes

_Everything is local. Distributed is the new centralized._

![](i/xkcd1597.png)


### Quotes - Blockchains and Git

> Yep, that's the joke. Nobody has been able to explain to me how the "blockchain" buzzword is significantly different to "git repo".
> -- [Yaakov](https://twitter.com/yaakov_h/status/902659507255312384)
>
> But if you said "let's build a currency where all transactions are stored in a git repo"
> you wouldn't be taken seriously for even 24 hrs.
> -- [Yaakov](https://twitter.com/yaakov_h/status/902659847224664064)

> Soon explaining git like "a git repo is like a blockchain with commits instead of blocks".
> -- [Nicolás Berger](https://twitter.com/nicoberger/status/901776907418697729)
>
> "A local branch is like a state channel. It can be pushed and merged into the master blockchain at any moment."
> -- [Nicolás Berger](https://twitter.com/nicoberger/status/901777571456614400)

> The #Blockchain has changed the world. Here I make the argument that the #Blockchain is just like #git.
> -- [Jackson Kelley](https://twitter.com/sjkelleyjr/status/901464041163341824)


### Books

[**Learn Enough Git to Be Dangerous**](https://learnenough.com/git-tutorial) by Michael Hartl - FREE (Online Version) --
_Getting started ++
Backing up and sharing ++
Intermediate workflow ++
Collaborating ++
Conclusion ++
Advanced setup_


[**Pro Git**](https://git-scm.com/book) by Scott Chacon and Ben Straub, 2nd Edition, 2014 - FREE (Online Version) --
_Getting Started ++
Git Basics ++
Git Branching ++
Git on the Server ++
Distributed Git ++
GitHub ++
Git Tools ++
Customizing Git ++
Git and Other Systems ++
Git Internals ++
A1: Git in Other Environments ++
A2: Embedding Git in your Applications ++
A3: Git Commands_


> Git gets easier once you get the basic idea that branches are homeomorphic endofunctors
> mapping submanifolds of a Hilbert space.
> -- Anonymous


### Open Distributed Databases on Git

[**football.db**](https://github.com/openfootball) - open public domain football datasets (incl. clubs, national teams, leagues, match schedules, etc.)

[**world.db**](https://github.com/openmundi) - open public domain world (country) datasets

[**beer.db**](https://github.com/openmundi) - open public domain beer & brewery datasets

> Add a beer transaction to the #blockchain on #git and win a free Wiener Lager beer! Cheers. Prost.
> -- [Gerald Bauer @ Vienna.html](https://twitter.com/viennahtml/status/907240018435088384)


### Open Distributed (Hyper) Ledgers on Git

[**Schilling**](https://github.com/openblockchains/schilling) - Schilling on the Blockchain! - Rock-Solid Alpine Dollar from Austria




## Classic Tulip Mania

_A period in the Dutch Golden Age during which contract prices for bulbs of the recently introduced tulip reached extraordinarily high levels and then dramatically collapsed in February 1637._

### Quotes - Blockchains are the next Internets / Tulips

> People who compare digital tokens to tulips are essentially saying digital tokens are a bubble backed
> by nothing but pure hype and speculation.
>
> What they fail to understand is that tulips come from dirt, not a blockchain.
>
> And as we all know, blockchain is possibly the best technological innovation since the internet.
> It will have a tremendous impact on global business and society in general.
> -- [TulipToken](http://tuliptoken.com)


### Books

**Tulipomania: The Story of the World's Most Coveted Flower & the Extraordinary Passions It Aroused** by Mike Dash, 2001 --
_A Mania for Tulips ++
The Valley of Tien Shan ++
Within the Abode of Bliss ++
Stranger from the East ++
Clusius ++
Leiden ++
An Adornment to the Cleavage ++
The Tulip in the Mirror ++
Florists ++
Boom ++
At the Sign of the Golden Grape ++
The Orphans of Wouter Winkel ++
Bust ++
Goddess of Whores ++
At the Court of the Tulip King ++
Late Flowering_




## Meta

**License**

![](https://publicdomainworks.github.io/buttons/zero88x31.png)

The awesome list is dedicated to the public domain. Use it as you please with no restrictions whatsoever.
