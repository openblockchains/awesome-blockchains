
# Bitcoin Storage 

_Different Ways to Store Data on top of the Bitcoin Blockchain_


## Value
Encode data in the number of satoshis being sent to an address.


## OP_RETURN
`OP_RETURN` is a command in the Bitcoin scripting language that was specifically 
added to allow the inclusion of metadata on the blockchain. 
Currently 80 bytes of information can be added to a transaction using `OP_RETURN` in Bitcoin Classic (BTC) 
and almost unlimited (~1 GiG) in Bitcoin Satoshi Vision (BSV).


## Input Sequence
This is an unused 32 bit integer (4 bytes max.) 
in Bitcoin Classic (BTC) and restore in Bitcoin Satoshi (BSV) for its intended use.

## Coinbase
Miners can include up to 100 bytes worth of data in a coinbase transaction (per block).

## Fake Addresses
Encode data in the Address itself. Because the Address encodes data of your choice it cannot have been the result of a derivation 
from a private key (with extremely high probability) 
and thus any coins sent to such addresses are lost (or "burnt").

## Vanity Addresses
Brute force through keys until you get an address that encodes your data, 
extremely resource intensive and impractical for anything bigger than a couple of bytes.

## 1 of N Multisig Address
These are more complex Bitcoin addresses that require one key out of N to redeem. 
We can use only one key as a real key (like with a standard address) 
and encode 32 bytes of data in the remaining N-1 keys.





---

## Sources

- [Data storage on the (bitcoin) blockchain @ Colored Coins](https://github.com/Colored-Coins/Colored-Coins-Protocol-Specification/wiki/Data%20Storage%20Methods)
