`DUP HASH160 6fad...ab90 EQUALVERIFY CHECKSIG`


# Bitcoin Script

_A mini blockchain contract programming language for locking (and unlocking) bitcoins (that is, unspent transaction outputs)_.


> The script is actually a predicate. It's just an equation that evaluates to true or false. 
> Predicate is a long and unfamiliar word so I called it script. 
>
> – [Satoshi Nakamoto](https://bitcointalk.org/index.php?topic=195.msg1611#msg1611), June 2010





## Standard (Lock) Scripts / Contracts

- **P2PK** (Pay To Pubkey)
  - Example: `<pubKey> OP_CHECKSIG` - unlock with `<sig>`
- **P2PKH** (Pay To Pubkey Hash) 
  - Example: `OP_DUP OP_HASH160 <pubKeyHash> OP_EQUALVERIFY OP_CHECKSIG` - unlock with `<sig> <pubKey>`

**More**

- **P2MS** (Pay To Multisig) - lets you to lock bitcoins to multiple public keys, and require signatures for some (or all) of those public keys to unlock it
  - Example 1 out of 2 keys required: `OP_1 <pubKey> <pubKey> OP_2 OP_CHECKMULTISIG` - unlock with `<sig>` 
- **P2SH** (Pay To Script Hash) - lets you create your own custom "redeem scripts", but still be able to share them easily with other people
  - Example: `OP_HASH160 <scriptHash> OP_EQUAL` - unlock with inputs required by the script (e.g. sig etc.) and the "redeem script" itself
- **NULL DATA** - lets you store data in bitcoin transactions
  - Example: `OP_RETURN <data>`



## Higher-Level Script Languages

- Ivy
- Miniscript by Blockstream


## Alternative Languages

- Simplicity by Blockstream


## Guides / Booklets

[**Programming Bitcoin Script Transaction (Crypto) Contracts Step-by-Step**](https://github.com/openblockchains/programming-bitcoin-script) - 
Let's start with building your own bitcoin stack machine from zero / scratch and let's run your own bitcoin ops (operations)...


## More Resources

- [**Script - A mini programming language @ Learn Me A Bitcoin**](https://learnmeabitcoin.com/guide/script) by Greg Walker
- [**Script @ Bitcoin Wiki**](https://en.bitcoin.it/wiki/Script)
- [**The Bitcoin Script Language**](http://davidederosa.com/basic-blockchain-programming/bitcoin-script-language-part-one/) by Davide De Rosa
 
 
