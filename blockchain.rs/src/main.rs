use blockchainlib::*;

fn main() {
    let mut blockchain = Blockchain::new();
    let difficulty = 0x000fffffffffffffffffffffffffffff;
    
    let mut genesis_block = Block::new(0, now(), vec![0; 32], vec![
        Transaction {
            inputs: vec![],
            outputs: vec![
                transaction::Output {
                    to_addr: "Alice".to_owned(),
                    value: 50,
                },
                transaction::Output {
                    to_addr: "Bob".to_owned(),
                    value: 7,
                }
            ]
        }
    ], difficulty);
    genesis_block.mine();
    println!("Mined gen block {:?}", &genesis_block);

    let mut last_hash = genesis_block.hash.clone();

    blockchain.update_with_block(genesis_block).expect("Failed to add Genesis Block");
    
    let mut block = Block::new(1, now(), last_hash, vec![
        Transaction {
            inputs: vec![],
            outputs: vec![
                transaction::Output {
                    to_addr: "Chris".to_owned(),
                    value: 536,
                }
            ]
        },
        Transaction {
            inputs: vec![
                transaction::Output {
                    to_addr: "Alice".to_owned(),
                    value: 50,
                },
            ],
            outputs: vec![
                transaction::Output {
                    to_addr: "Alice".to_owned(),
                    value: 36,
                },
                transaction::Output {
                    to_addr: "Bob".to_owned(),
                    value: 12,
                }
            ]
        }
    ], difficulty);
    block.mine();
    println!("Mined block {:?}", &block);

    last_hash = block.hash.clone();

    blockchain.update_with_block(block).expect("Failed to add Block");
    
    block = Block::new(2, now(), last_hash, vec![
        Transaction {
            inputs: vec![],
            outputs: vec![
                transaction::Output {
                    to_addr: "David".to_owned(),
                    value: 100,
                },
            ]
        },
        Transaction {
            inputs: vec![
                transaction::Output {
                    to_addr: "Chris".to_owned(),
                    value: 536,
                }
            ],
            outputs: vec![
                transaction::Output {
                    to_addr: "David".to_owned(),
                    value: 30,
                },
                transaction::Output {
                    to_addr: "Chris".to_owned(),
                    value: 500,
                }
            ]
        }
    ], difficulty);
    block.mine();

    println!("Mined block {:?}", &block);

    blockchain.update_with_block(block).expect("Failed to add Block");

    for i in blockchain.iter() {
        println!("{:?}", i);
    }
}

