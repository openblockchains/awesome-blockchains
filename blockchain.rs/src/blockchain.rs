use super::*;
use std::collections::HashSet;

pub struct Blockchain {
    pub head: Link<Block>,
    pub no_of_blocks: i32,
    unspent_outputs: HashSet<Hash>,
}

type Link<Block> = Option<Box<Node<Block>>>;

pub struct Node<Block> {
    elem: Block,
    next: Link<Block>,
}

pub struct Iter<'a, Block> {
    next: Option<&'a Node<Block>>,
}


#[derive(Debug)]
pub enum BlockChainValidationErr {
    MismatchIndex,
    InvalidHash,
    AchronologicalTimestamp,
    InvalidPrevBlock,
    MismatchPreviousHash,
    InvalidGenisisBlockFormat,
    InvalidInput,
    InsufficientInputValue,
    InvalidCoinbaseTransaction, 
}

impl Blockchain {
    pub fn new() -> Self {
        Blockchain {
            head: None,
            no_of_blocks: 0,
            unspent_outputs: HashSet::new(),
        }
    }

    pub fn push(&mut self, block: Block) {
        let new_node = Box::new(Node {
            elem: block,
            next: self.head.take(),
        });

        self.head = Some(new_node);
    }

    pub fn peek(&self) -> Option<&Block> {
        self.head.as_ref().map(|node| {
            &node.elem
        })
    }

    pub fn iter(&self) -> Iter<Block> {
        Iter { next: self.head.as_ref().map(|node| &**node) }
    }

    pub fn update_with_block (&mut self, block: Block) -> Result<(), BlockChainValidationErr> {
        let i = self.no_of_blocks;

        if block.index != i as u32 {
            return Err(BlockChainValidationErr::MismatchIndex);
        } else if !block::check_difficulty(&block.hash(), block.difficulty) {
            return Err(BlockChainValidationErr::InvalidHash);
        } else if i != 0 {
            //Another block
            let prev_block = self.peek();
            match prev_block {
                None => return Err(BlockChainValidationErr::InvalidPrevBlock),
                Some(prev_block) => {
                    if block.timestamp <= prev_block.timestamp {
                        return Err(BlockChainValidationErr::AchronologicalTimestamp);
                    } else if block.prev_block_hash != prev_block.hash() {
                        return Err(BlockChainValidationErr::MismatchPreviousHash);
                    }
                }
            }
        } else {
            //Genesis block
            if block.prev_block_hash != vec![0; 32] {
                return Err(BlockChainValidationErr::InvalidGenisisBlockFormat);
            }
        }

        if let Some((coinbase, transactions)) = block.transactions.split_first(){
            if !coinbase.is_coinbase() {
                return Err(BlockChainValidationErr::InvalidCoinbaseTransaction);
            }

            let mut block_spent: HashSet<Hash> = HashSet::new();
            let mut block_created: HashSet<Hash> = HashSet::new();
            let mut total_fee = 0;

            for transaction in transactions {
                let input_hashes = transaction.input_hashes();

                if !(&input_hashes - &self.unspent_outputs).is_empty() ||
                   !(&input_hashes & &block_spent).is_empty()
                {
                    return Err(BlockChainValidationErr::InvalidInput);
                }

                let input_value = transaction.input_value();
                let output_value = transaction.output_value();

                if output_value > input_value {
                    return Err(BlockChainValidationErr::InsufficientInputValue)
                }

                let fee = input_value - output_value;
                total_fee += fee;

                block_spent.extend(input_hashes);
                block_created.extend(transaction.output_hashes())
            }

            if coinbase.output_value() < total_fee {
                return Err(BlockChainValidationErr::InvalidCoinbaseTransaction);
            } else {
                block_created.extend(coinbase.output_hashes())
            }

            self.unspent_outputs.retain(|output| block_spent.contains(output));
            self.unspent_outputs.extend(block_created);
        }

        self.push(block);
        
        self.no_of_blocks += 1;

        Ok(())
    }
}

impl<'a, Block> Iterator for Iter<'a, Block> {
    type Item = &'a Block;
    fn next(&mut self) -> Option<Self::Item> {
        self.next.map(|node| {
            self.next = node.next.as_ref().map(|node| &**node);
            &node.elem
        })
    }
}

