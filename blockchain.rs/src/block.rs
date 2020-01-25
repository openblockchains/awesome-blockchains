use super::*;
use std::fmt::{ self, Debug, Formatter };

pub struct Block {
	pub index: u32,
	pub timestamp: u128,
	pub hash: Hash,
	pub prev_block_hash: Hash,
	pub nonce: u64,
	pub transactions: Vec<Transaction>,
	pub difficulty: u128,
}

impl Debug for Block {
	fn fmt(&self, f: &mut Formatter) -> fmt::Result {
		write!(f, "Block[{}]: {} at: {} with: nonce:{}\n", 
			&self.index,
			&hex::encode(&self.hash),
			&self.timestamp,
			&self.nonce,
		)
	}
}

impl Block {
	pub fn new(index:u32, timestamp:u128, prev_block_hash:Hash, 
	transactions: Vec<Transaction>, difficulty: u128) -> Self {
		Block {
			index,
			timestamp,
			hash: vec![0; 32],
			prev_block_hash,
			nonce: 0,
			transactions,
			difficulty,
		}
	}

	pub fn mine(&mut self) {
		for nonce_attempt in 0..(u64::max_value()) {
			self.nonce = nonce_attempt;
			let hash = self.hash();
			if check_difficulty(&hash, self.difficulty) {
				self.hash = hash;
				return;
			}
		}
	}
}

impl Hashable for Block {
	fn bytes(&self) -> Vec<u8> {
		let mut bytes = vec![];

		bytes.extend(&u32_bytes(&self.index));
		bytes.extend(&u128_bytes(&self.timestamp));
		bytes.extend(&self.prev_block_hash);
		bytes.extend(&u64_bytes(&self.nonce));
		bytes.extend(
			self.transactions
				.iter()
				.flat_map(|transaction| transaction.bytes())
				.collect::<Vec<u8>>()
			);
		bytes.extend(&u128_bytes(&self.difficulty));

		bytes
	} 
}

pub fn check_difficulty(hash: &Hash, difficulty: u128) -> bool {
	difficulty > difficulty_bytes_as_u128(&hash)
}

