# blockchain.rs - Build your own blockchain from scratch in Rust

inspired by [Build a cryptocurrency! - Blockchain in Rust](https://github.com/GeekLaunch/blockchain-rust) by Jacob Lindahl, GeekLaunch


contributed by [Siddhant Rao](https://github.com/siddhantrao23) 



Structure definition:

``` rust
pub struct Block {
    pub index: u32,
    pub timestamp: u128,
    pub hash: Hash,
    pub prev_block_hash: Hash,
    pub nonce: u64, 
    pub transactions: Vec<Transaction>, 
    pub difficulty: u128,
}
```


To run use:

    $ cargo run 




## Sources

See [`too_chainz`](https://github.com/siddhantrao23/too_chainz).
