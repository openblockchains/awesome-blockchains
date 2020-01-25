# Blockchain made in rust
inspired by [Build a cryptocurrency! - Blockchain in Rust](https://github.com/GeekLaunch/blockchain-rust) by Jacob Lindahl, GeekLaunch

Structure definition:

    pub struct Block {
        pub index: u32,
        pub timestamp: u128,
        pub hash: Hash,
        pub prev_block_hash: Hash,
        pub nonce: u64, 
        pub transactions: Vec<Transaction>, 
        pub difficulty: u128,
    }


To run use:

    $ cargo run 
