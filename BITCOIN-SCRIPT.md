`DUP HASH160 6fad...ab90 EQUALVERIFY CHECKSIG`


# Bitcoin Script

_A mini blockchain contract programming language for locking (and unlocking) bitcoins (that is, unspent transaction outputs)_.


> The script is actually a predicate. It's just an equation that evaluates to true or false. 
> Predicate is a long and unfamiliar word so I called it script. 
>
> – [Satoshi Nakamoto](https://bitcointalk.org/index.php?topic=195.msg1611#msg1611), June 2010





## Standard (Lock) Scripts / Contracts

- **P2PK** (Pay To Pubkey)
  - Example: `04ae1a62fe09c5f51b13905f07f06b99a2f7159b2225f374cd378d71302fa28414e7aab37397f554a7df5f142c21c1b7303b8a0626f1baded5c72a704f7e6cd84c OP_CHECKSIG`
- **P2PKH** (Pay To Pubkey Hash) 
  - Example: `OP_DUP OP_HASH160 12ab8dc588ca9d5787dde7eb29569da63c3a238c OP_EQUALVERIFY OP_CHECKSIG`

**More**

- **P2MS** (Pay To Multisig) - lets you to lock bitcoins to multiple public keys, and require signatures for some (or all) of those public keys to unlock it
  - Example: `OP_1 04cc71eb30d653c0c3163990c47b976f3fb3f37cccdcbedb169a1dfef58bbfbfaff7d8a473e7e2e6d317b87bafe8bde97e3cf8f065dec022b51d11fcdd0d348ac4 0461cbdcc5409fb4b4d42b51d33381354d80e550078cb532a34bfa2fcfdeb7d76519aecc62770f5b0e4ef8551946d8a540911abe3e7854a26f39f58b25c15342af OP_2 OP_CHECKMULTISIG`
- **P2SH** (Pay To Script Hash) - lets you create your own custom "redeem scripts", but still be able to share them easily with other people
- **NULL DATA** - lets you store data in bitcoin transactions
  - Example: `OP_RETURN 68656c6c6f20776f726c64`



## Higher-Level Script Languages

- Ivy
- Miniscript by Blockstream


## Alternative Languages

- Simplicity by Blockstream


## Guides / Booklets

[**Programming Bitcoin Script Transaction (Crypto) Contracts Step-by-Step**](https://github.com/openblockchains/programming-bitcoin-script) - 
Let's start with building your own bitcoin stack machine from zero / scratch and let's run your own bitcoin ops (operations)...


## More Resources

- [Script - A mini programming language @ Learn Me A Bitcoin](https://learnmeabitcoin.com/guide/script) by Greg Walker
