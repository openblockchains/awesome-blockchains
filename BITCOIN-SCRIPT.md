```
IF
    2 <Alice's pubkey> <Bob's pubkey> <Escrow's pubkey> 3 CHECKMULTISIG
ELSE
    "30d" CHECKSEQUENCEVERIFY DROP
    <Alice's pubkey> CHECKSIG
ENDIF
```

# Bitcoin Script

_A mini blockchain contract programming language for locking (and unlocking) bitcoins (that is, unspent transaction outputs)_.


## Intro

Did you know? Every (yes, every) bitcoin transaction (payment) runs
a contract script (one half coming from the "output" or "lock" transaction and the
other half coming from the "input" or "unlock" transaction).
The programming language is called simply (bitcoin) script.

> The script is actually a predicate. It's just an equation that evaluates to true or false. 
> Predicate is a long and unfamiliar word so I called it script. 
>
> -- [Satoshi Nakamoto, June 2010 @ Bitcoin Talk](https://bitcointalk.org/index.php?topic=195.msg1611#msg1611)



## Guides / Booklets

[**Programming Bitcoin Script Transaction (Crypto) Contracts Step-by-Step**](https://github.com/openblockchains/programming-bitcoin-script) - 
Let's start with building your own bitcoin stack machine from zero / scratch and let's run your own bitcoin ops (operations)...


## More Resources

- [**Script - A mini programming language @ Learn Me A Bitcoin**](https://learnmeabitcoin.com/guide/script) by Greg Walker - The complete script is run from left-to-right. As it runs, it makes use of a data structure called a "stack". Data is always pushed on to the stack...
- [**Script @ Bitcoin Wiki**](https://en.bitcoin.it/wiki/Script) Bitcoin uses a scripting system for transactions. Forth-like, Script is simple, stack-based, and processed from left to right. It is intentionally not Turing-complete, with no loops...
- [**The Bitcoin Script Language**](http://davidederosa.com/basic-blockchain-programming/bitcoin-script-language-part-one/) by Davide De Rosa - Script is a simple scripting language, as well as the core of Bitcoin transaction processing. If you ever wrote assembly code you'll find this article very easy to understand - probably entertaining -, otherwise it might well be one of the most challenging. Keep focused! Meet machine code...
 



## Standard (Lock) Scripts / Contracts

- **P2PK** (Pay To Pubkey)
  - Example: `<pubKey> CHECKSIG` - unlock with `<sig>`
- **P2PKH** (Pay To Pubkey Hash) 
  - Example: `DUP HASH160 <pubKeyHash> EQUALVERIFY CHECKSIG` - unlock with `<sig> <pubKey>`
- **P2MS** (Pay To Multisig) - lets you to lock bitcoins to multiple public keys, and require signatures for some (or all) of those public keys to unlock it
  - Example 1 out of 2 keys required: `1 <pubKey> <pubKey> 2 CHECKMULTISIG` - unlock with `<sig>` 
- **NULL DATA** - lets you store data in bitcoin transactions
  - Example: `RETURN <data>`

**More**

- **P2SH** (Pay To Script Hash) - lets you create your own custom "redeem scripts", but still be able to share them easily with other people
  - Example: `HASH160 <scriptHash> EQUAL` - unlock with inputs required by the script (e.g. sig etc.) and the "redeem script" itself




## Higher-Level Script Languages

- Ivy
- Miniscript by Blockstream
  - [Miniscript @ Bitcoin Optech](https://bitcoinops.org/en/topics/miniscript/)


## Alternative Languages

- Simplicity by Blockstream

 
 
## Language Grammar
 
Bitcoin Script in the BNF (Backus-Naur form) grammar:

```
<script>           ::= <unlocking-script> <locking-script>
<unlocking-script> ::= <constants> | <empty>
<locking-script>   ::= <script-block> ["OP_RETURN" <non-script-data>]
<script-block>     ::= <function> [<script-block>] | 
                       <push-data> [<script-block>] |
                       <branch> [<script-block>] |
                       "OP_RETURN" [<script-block>] |
                       <empty>
<branch>            ::= <op-if> <script-block> ["OP_ELSE" <script-block>] "OP_ENDIF"
<op-if>             ::= "OP_IF" | "OP_NOTIF"
<constants>         ::= <constant> [<constants>]
<constant>          ::= "OP_PUSHDATA1" <count-1> "bytes" |
				"OP_PUSHDATA2" <count-2> "bytes" |
            "OP_PUSHDATA4" <count-4> "bytes" |
            <op-push-xx> "bytes" | <op-false> | 
            <op-true> | "OP_2" | "OP_3" | "OP_4" |
            "OP_5" | "OP_6" | "OP_7" | "OP_8" | "OP_9" | 
            "OP_10" | "OP_11" | "OP_12" | "OP_13" | 
            "OP_14" | "OP_15" | "OP_16"
<count-1>           ::= a one byte unsigned integer (0-255)
<count-2>           ::= a two byte unsigned integer (0-65535)
<count-4>           ::= a four byte unsigned integer (0-4294967295)
<op-push-xx>        ::= hex codes 0x01 to 0x4b
<op-false>          ::= "OP_0" | "OP_FALSE"
<op-true>           ::= "OP_1" | "OP_TRUE"
<function>          ::= "OP_NOP" | "OP_VERIFY" | 
    "OP_TOALTSTACK" | "OP_FROMALTSTACK" | "OF_IFDUP" | 
    "OP_DEPTH" | "OP_DROP" | "OP_DUP" | "OP_NIP" | "OP_OVER" |
    "OP_PICK" | "OP_ROLL" | "OP_ROT" | "OP_SWAP" | "OP_TUCK" |
    "OP_2DROP" | "OP_2DUP" | "OP_3DUP" | "OP_2OVER" | 
    "OP_2ROT" | "OP_2SWAP" | "OP_SIZE" | "OP_EQUAL" | 
    "OP_EQUALVERIFY" | "OP_1ADD" | "OP_1SUB" | "OP_NEGATE" |
    "OP_ABS" | "OP_NOT" | "OP_0NOTEQUAL" | "OP_ADD" | 
    "OP_SUB" | "OP_BOOLAND" | "OP_BOOLOR" | "OP_NUMEQUAL" |
    "OP_NUMEQUALVERIFY" | "OP_NUMNOTEQUAL" | "OP_LESSTHAN" |
    "OP_GREATERTHAN" | "OP_LESSTHANOREQUAL" |
    "OP_GREATERTHANOREQUAL" | "OP_MIN" | "OP_MAX" | 
    "OP_WITHIN" | "OP_RIPEMD160" | "OP_SHA1" | "OP_SHA256" |
    "OP_HASH160" | "OP_HASH256" | "OP_CODESEPARATOR" | 
    "OP_CHECKSIG" | "OP_CHECKSIGVERIFY" | "OP_CHECKMULTISIG" |
    "OP_CHECKMULTISIGVERIFY" | "OP_CAT" | "OP_SPLIT" | 
    "OP_AND" | "OP_OR" | "OP_XOR" | "OP_DIV" | "OP_MOD" |
    "OP_NUM2BIN" | "OP_BIN2NUM" | "OP_NOP1" | "OP_NOP2" | 
    "OP_NOP3" | "OP_NOP4" | "OP_NOP5" | "OP_NOP6" | 
    "OP_NOP7" | "OP_NOP8" | "OP_NOP9" | "OP_NOP10" |
    "OP_MUL" | "OP_LSHIFT" | "OP_RSHIFT" | "OP_INVERT" | 
    "OP_2MUL" | "OP_2DIV" | "OP_VERIF" | "OP_VERNOTIF"
<non-script-data>   ::= any sequence of bytes
```

It's worth highlighting the following features of this formal grammar:

-   The complete script consists of two sections, the unlocking script and the locking script. The locking script is 
    included in the transaction output that is being spent, the unlocking script is included in the transaction input 
    that is spending the output.
-   The unlocking script can only contain constants.
-   A branching operator (OP_IF or OP_NOTIF) must have a matching OP_ENDIF.
-   An OP_ELSE can only be included between a branching operator and OP_ENDIF pair. There can only be at most one 
    OP_ELSE between a branching operator and an OP_ENDIF.
-   OP_RETURN may appear at any location in a valid script.

(Source: [Bitcoin Specs @ Satoshi Vision](https://github.com/bitcoin-sv-specs/protocol/blob/master/updates/genesis-spec.md#formal-grammar-for-bitcoin-script))



## Future Bitcoin Script Notes / Updates / Upgrades

A number of related ideas for improving Bitcoin's scripting capabilities have been previously proposed: Schnorr signatures (bip-schnorr), Merkle branches ("MAST", [BIP114](https://github.com/bitcoin/bips/blob/master/bip-0114.mediawiki), [BIP117](https://github.com/bitcoin/bips/blob/master/bip-0117.mediawiki)), new sighash modes ([BIP118](https://github.com/bitcoin/bips/blob/master/bip-0118.mediawiki)), new opcodes like CHECKSIGFROMSTACK, [Taproot](https://lists.linuxfoundation.org/pipermail/bitcoin-dev/2018-January/015614.html), [Graftroot](https://lists.linuxfoundation.org/pipermail/bitcoin-dev/2018-February/015700.html), [G'root](https://lists.linuxfoundation.org/pipermail/bitcoin-dev/2018-July/016249.html), and [cross-input aggregation](https://bitcointalk.org/index.php?topic=1377298.0).


### Taproot & Tapscript

_A new SegWit version 1 output type, with spending rules based on Taproot, Schnorr signatures, and Merkle branches._

- [Bitcoin Optech Newsletter #46](https://bitcoinops.org/en/newsletters/2019/05/14/#overview-of-the-taproot--tapscript-proposed-bips), May 14, 2019 - This week's newsletter includes a special section about the Taproot proposal...
- [Taproot: Bitcoin's Next Big Actions](https://medium.com/coinmonks/taproot-bitcoins-next-big-actions-9c58bb2e111f) by Kento Uchida, May 16, 2019 

<!-- break -->

- [Taproot @ Bitcoin Optech](https://bitcoinops.org/en/topics/taproot/)
- [Tapscript @ Bitcoin Optech](https://bitcoinops.org/en/topics/tapscript/)


### Merklized Abstract Syntax Tree (MAST)

_MAST is an extending design for Bitcoin, which can be understood as adding a smart contract-like function to the existing system. The basic idea of MAST is to combine the original condition script Pay-to-ScriptHash (P2SH) with the Merkle Tree structure, so that logically more complex and flexible transaction scripts can be implemented in Bitcoin. What is more, MAST makes the transaction volume regarding various scripts to further shrink with privacy steadily enhanced, totally a comprehensive upgrade based on P2SH, period._ 

- [What is a Bitcoin Merklized Abstract Syntax Tree (MAST)?](https://bitcointechtalk.com/what-is-a-bitcoin-merklized-abstract-syntax-tree-mast-33fdf2da5e2f) by David A. Harding, Oct 12, 2017

<!-- break -->
- [MAST @ Bitcoin Optech](https://bitcoinops.org/en/topics/mast/)
