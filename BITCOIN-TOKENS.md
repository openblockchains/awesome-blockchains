# Bitcoin Tokens

_Issue and trade your own cryptocurrency / tokens / digital assets ontop the bitcoin blockchain_

## Intro

**2012–2013: Colored Coins**

One could argue that Colored Coins are the very first non-fungible tokens to exist.
Colored Coins are made of small denominations of a bitcoin and can be as small as a single satoshi,
the smallest unit of a bitcoin. Colored Coins can be used to represent a multitude of assets and have multiple use cases, including:
i) Ability to issue your own cryptocurrency
ii) Issue shares of a company
iii) Property, Coupons, Subscriptions, Access tokens, Digital collectibles and more.

Colored Coins exemplified a huge leap in Bitcoin's capabilities, however, their downside was they could only represent certain values if everyone agrees on their worth. Bitcoin's scripting language was never meant to enable this type of behavior within its network, thus Colored Coins were only as powerful as their weakest participant. For example, 3 people agree that 100 Colored Coins represent 100 company shares. If even one participant decides they no longer equate Colored Coins to represent company shares, the entire system falls apart.



## Options

Absent miner-validation of tokens, it is necessary to add extra data onto ordinary bitcoin transactions that indicates coloring, transferred value, etc. The standard way to do this is with [OP_RETURN](https://en.bitcoin.it/wiki/Script#Provably_Unspendable.2FPrunable_Outputs) which allows cleanly holding arbitrary data. Unfortunately, any bitcoin user can post an apparent token-transfer transaction and have it confirmed by miners without actually owning tokens. Token conservation and any other desired rules must instead be enforced with user consensus alone, by examining the history behind each transaction and marking as ‘invalid’ those that do not follow the rules of its protocol.

Many methods fall under the category of "colored coins".   [Most of these designs actually supplement the unspent transaction output (UTXO) with extra colored values](https://github.com/Colored-Coins/Colored-Coins-Protocol-Specification/wiki/Faq#coloring-satoshis): Surprisingly, only Enhanced padded order-based coloring (EPOBC) - one of the earliest proposals - actually took bitcoins and applied color to them.

The advantage of these "colored coin" tokens is that the miners prevent double-spending. One disadvantage is that these UTXOs can be accidentally spent without the special color metadata, which is equivalent to discarding the tokens. This easily occurs if tokens are sent to someone with a regular (non-token-aware) bitcoin wallet. [Color addresses](https://github.com/chromaway/ngcccbase/wiki/Addresses) have been proposed to reduce these accidents.

Finally, some token schemes (Omni, Counterparty) discard the UTXO concept for tokens and instead associate an overall balance to an address. Transactions then serve only as a signed and irreversibly published order of balance transfer, and miners do not prevent double-spending of tokens. Users' checking of transaction validity requires examining all prior transactions associated with the addresses involved, and this is sensitive to blockchain re-ordering. The [Tether](https://en.wikipedia.org/wiki/Tether_(cryptocurrency)) USD-pegged token was issued on Omni.

Since colored coins cannot be double spent, [one can prove](https://www.reddit.com/r/Bitcoin/comments/26mzbb/chromawallet_colored_coins_v007_beta_it/chsm1na/) the validity of a token transaction by examining only the input ancestor transactions tracing back to when the tokens were first minted. This set of transactions forms a [directed acyclic graph](https://en.wikipedia.org/wiki/Directed_acyclic_graph) (DAG). These proofs are significantly more weighty than Simplified Payment Verification (SPV), yet still simple enough to implement in a lite client. In contrast, balance-based tokens in principle require a full node to achieve a high level of security: only after an examination of all transactions (to ensure inclusion of all at a given address), can valid transactions be proven.

Token implementations also vary in their scriptability, ranging from none at all (tokens can only be sent and received), to bitcoin-level (multisig, atomic swaps, payment channels possible), up to highly complex scripting languages like those implemented on the Ethereum cryptocurrency.

Here is a chart comparing primary token properties:


| System   | Token value associated to... |  Transfer data is all on-chain? | Lite proofs?  | Scriptability | Adoption obstacles |
|----------|-----------------------------|---------------------------------|----------------|--------------|--------------------|
|  Omni        | Address   | Y |  no   | Bitcoin   | Ecosystem integration |
| Counterparty | Address   | Y |  no   | Complex   | Ecosystem integration |
| EPOBC (Enhanced padded order-based coloring)        | UTXO-outval | Y  | DAG | Bitcoin  |  Lack of interest  |
| Coinspark    |  UTXO     |  N  | DAG   | Bitcoin   |  Lack of interest |
| Colu         |  UTXO     |  Y  | DAG   | Bitcoin   | Under evaluation |
| Open Assets  |  UTXO     |  Y  | DAG   | Bitcoin   | Lack of interest |
| Tokeda       |  UTXO     |  Y  | Sigs  | Bitcoin   | Incomplete draft |
| SITO         |  UTXO     |  N  | DAG   | No        | Under evaluation |
| RSK/ect.     | Sidechain |  N  | SPV   | Complex   | Protocol change (for trustless) |
| GROUP        | UTXO-outval | Y | SPV   | Bitcoin   | Protocol change |
| Simple Ledger Protocol (SLP) | UTXO | Y | DAG  | Bitcoin  | Under evaluation |     


Other aspects are noted below: how multiple tokens can interact (e.g., can they appear in the same transaction, allowing token-token direct swaps?); how much customization is available to token properties at issuance; and any other notable extras / unusual features.

| System | Multiple token handling | Issuer tweaks | Extras  |
|--------|-------------------------|---------------|---------|
| Omni   | Normally segregated     | Many          | DEX, bets, ... |
| Counterparty  |  Normally segregated  |  Many    |  DEX, bets, ... |
| EPOBC (Enhanced padded order-based coloring)  | In same tx   | None |  - |
| Coinspark  |  In same tx or same UTXO  |  Some   | Legal contracts, token conservation  |
| Colu       | In same tx or same UTXO  | Some   |  Rule engine  |
| Open Assets | In same tx |      None   |
| Tokeda      | Segregated |  Few    | Issuer permission required for transactions |
| SITO        | Segregated | None    |
| GROUP       | Segregated | Few     | Yes, if even more opcodes
| SLP         | Segregated | Few     | 








## Sources

- [Simple Ledger Protocol (SLP) Token Type 1 Specification](https://github.com/simpleledger/slp-specifications/blob/master/slp-token-type-1.md)
- [Colored Coins @ Bitcoin Wiki](https://en.bitcoin.it/wiki/Colored_Coins)
- [The History of Non-Fungible Tokens (NFTs)](https://medium.com/@Andrew.Steinwold/the-history-of-non-fungible-tokens-nfts-f362ca57ae10) by Andrew Steinwold


