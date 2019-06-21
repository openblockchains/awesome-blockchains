# What's Blockchain?


> Blockchain is a distributed database with a list (that is, chain) of records (that is, blocks) 
> linked and secured by digital fingerprints (that is, cryptho hashes). 
>
> -- [Awesome Blockchains](https://github.com/openblockchains/awesome-blockchains)


> Blockchain is a continuously growing list of records, called blocks, which are linked and secured using cryptography.
> Each block typically contains a hash pointer as a link to a previous block, a timestamp and transaction data. 
> By design, blockchains are inherently resistant to modification of the data. 
> A blockchain can serve as "an open, distributed ledger that can record transactions between two parties efficiently
> and in a verifiable and permanent way."
>
> -- [Blockchain @ Wikipedia](https://en.wikipedia.org/wiki/Blockchain)


> [Blockchain is ...] a solution to the double-spending problem using a peer-to-peer network. 
> The network timestamps transactions by hashing them into an ongoing chain of hash-based proof-of-work, 
> forming a record that cannot be changed without redoing the proof-of-work. 
> The longest chain not only serves as proof of the sequence of events witnessed, 
> but proof that it came from the largest pool of CPU power... 
> The network itself requires minimal structure.
>
> -- Satoshi Nakamoto @ Bitcoin Whitepaper


> Blockchain [data structure] is an ordered, back-linked list of blocks of transactions. 
> The blockchain can be stored as a flat file, or in a simple database. 
> The Bitcoin Core client stores the blockchain metadata using Google's LevelDB database. 
> Blocks are linked "back," each referring to the previous block in the chain. 
> The blockchain is often visualized as a vertical stack, with blocks layered on top of each other 
> and the first block serving as the foundation of the stack. 
> The visualization of blocks stacked on top of each other results in the use of terms such as "height" 
> to refer to the distance from the first block, and "top" or "tip" to refer to the most recently added block.
>
> Each block within the blockchain is identified by a hash, generated using the SHA256 cryptographic hash algorithm 
> on the header of the block. Each block also references a previous block, known as the parent block, 
> through the "previous block hash" field in the block header. 
> In other words, each block contains the hash of its parent inside its own header. 
> The sequence of hashes linking each block to its parent creates a chain going back all the way to the first block ever created, 
> known as the genesis block.
>
> -- [Andreas M. Antonopoulos @ Mastering Bitcoin: Programming the Open Blockchain](https://github.com/bitcoinbook/bitcoinbook/blob/second_edition/ch09.asciidoc)




> Blockchain is a public database where new data are stored in a container called a block 
> and are added to an immutable chain (hence blockchain) with data added in the past.
> In the case of Bitcoin and other cryptocurrencies, these data are groups of transactions. 
> But, the data can be of any type, of course.
> 
> -- [Gerald Nash @ Let's Build the Tiniest Blockchain](https://medium.com/crypto-currently/lets-build-the-tiniest-blockchain-e70965a248b)


> Blockchain is a public database that consists out of blocks that anyone can read.
> Nothing special, but they have an interesting property: they are immutable.
> Once a block has been added to the chain, it cannot be changed anymore without invalidating the rest of the chain.
>
> -- [Xavier Decuyper @ Writing a Tiny Blockchain in JavaScript](https://www.savjee.be/2017/07/Writing-tiny-blockchain-in-JavaScript/)


> Blockchain is a distributed database with a set of rules for verifying new additions to the database.
>
> -- [Eric Munsing @ Build Your Own Blockchain: A Python Tutorial](http://ecomunsing.com/build-your-own-blockchain)



> Blockchain is a digital ledger in which transactions made in bitcoin or another cryptocurrency 
> are recorded chronologically and publicly.
>
> -- [Google Search: Blockchain Definition](https://www.google.com/search?q=blockchain+definition)


> Blockchain is an incorruptible digital ledger of economic transactions that can be programmed to record 
> not just financial transactions but virtually everything of value.
>
> -- Don & Alex Tapscott, Blockchain Revolution (2016)


> Blockchain is a data structure that makes it possible to create a digital
> ledger of data and share it among a network of independent parties. 
>
> -- Tiana Laurence @ Blockchain for Dummies (2017)


> Blockchain is a shared, distributed ledger that facilitates the process
> of recording transactions and tracking assets in a business network.
> An asset can be tangible - a house, a car, cash, land - or intangible
> like intellectual property, such as patents, copyrights, or branding.
> Virtually anything of value can be tracked or traded on a blockchain 
> network, reducing risk and cutting costs for all involved.
>
> -- Manav Gupta @ Blockchain for Dummies - IBM Limited Edition (2017)


> Blockchain is a shared, immutable ledger for recording the history of transactions. 
> It fosters a new generation of transactional applications that establish trust, 
> accountability and transparency - from contracts to deeds to payments.
>
> -- [IBM Blockchain](https://ibm.com/blockchain) 



> Blockchain is the magic that will power all the world's financial transactions 
> and unlock the great decentralized database in the sky.
>
> -- Snake Oil Purveyors


> Blockchain is a provably-immutable append-only data log with transaction validation based on asymmetric crypto,
> and (optionally) a Byzantine-generals solution too! 
>
> -- [Tim Bray @ I Don't Believe in Blockchain](https://www.tbray.org/ongoing/When/201x/2017/05/13/Not-Believing-in-Blockchain)


> Blockchain is really a fairly old set of ideas - merkle hash trees, distributed databases etc. 
> The novelty, if any, is in a convergence of different methods and new levels of efficiency. 
> This is the stuff of solid, and valuable, progress.
> But it isn't a revolution in governance, production or the structure of society.
>
> -- [Rufus Pollock @ Reflections on the Blockchain](http://rufuspollock.com/2016/07/02/reflections-on-the-blockchain/)

