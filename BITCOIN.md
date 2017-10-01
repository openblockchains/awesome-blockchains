# Build Your Own (Local) Bitcoin Blockchain from Scratch


## Step 0: Installation

Download and install the Bitcoin Core (command line) tools @ [bitcoin.org/en/download](https://bitcoin.org/en/download) (~20 MBs).

See if the tools are installed, try:

    $ bitcoind --help
    $ bitcoin-cli --help



## Step 1: Configuration File

Add a configuration file - `bitconf.conf` to your working folder:

    rpcuser=bitcoinrpc
    rpcpassword=semperaugustus


**What's the `regtest`?**

`regtest` is the regression test mode.
Using the regression test mode option switch `-regtest` you can
build your own (local) blockchain from scratch -
initially added for (local) regression testing.



## Step 2: Start the (Local) Bitcoin Service / Daemon

Start the bitcoin service / daemon

    $ bitcoind -regtest -datadir=. -conf=./bitcoin.conf -printtoconsole

used option switches:

- `-regtest` use the (local) regression test mode NOT the main live production mode
- `-conf=./bitcoin.conf`  use the `bitcoin.conf` from the local folder
- `-datadir=.` root folder for adding the `regtest/` folder with the blockchain and all meta data
- `-printtoconsole` for learing and debugging run with commentary (and not silent in the background)


Printing something like:

```
2017-10-01 12:44:14 Bitcoin version v0.15.0.1
2017-10-01 12:44:14 Using the 'standard' SHA256 implementation
2017-10-01 12:44:15 Using data directory /tmp/bitcoin/regtest
2017-10-01 12:44:15 Using config file /tmp/bitcoin/./bitcoin.conf
...

```

And adding all the blockchain data in `./regtest`:

```
└───blocks/
        blk00000.dat
```


## Step 3: Start Querying the (Local) Bitcoin Service 

In a new terminal (shell) window (console) 
start connecting with the command line interface (cli) tool.
Let's query for `getblockchaininfo`:

    $ bitcoin-cli -regtest -datadir=. -conf=./bitcoin.conf getblockchaininfo

Resulting in something like:

```` json
{
  "chain": "regtest",
  "blocks": 0,
  "headers": 0,
  "bestblockhash": "0f9188f13cb7b2c71f2a335e3a4fc328bf5beb436012afca590b1a11466e2206",
  "difficulty": 4.656542373906925e-010,
  "mediantime": 1296688602,
  "verificationprogress": 1,
  "chainwork": "0000000000000000000000000000000000000000000000000000000000000002",
  "pruned": false,
  ...
}
```

Add (mine) new 500 blocks with `generate`

    $ bitcoin-cli -regtest -datadir=. -conf=./bitcoin.conf generate 500

Resulting in something like:

``` json
[
  "15262fb31ca5680c0af236c0fbb6b3d39a1686afcd46a01549c2cc2a4626b791",
  "1a482dbae5bee25f510abbc9b7835cd2550203c36eb60fe0b4e9db76dac17075",
  "4f40aea65b50ca8c18995f07430816cf1bfca49a9af39f6ef87838bdbe978046",
  "7433eab491f9d6a1644e8f31ee8867707a526d6cd94d6b88aa6f9605cc252e49",
  "04baf8b25cc7144a307b8cab440555b07479f26ab55ee5ce8cd59807c908db0a",
  "1096d25836ad81d4bc44906791229264a961a07a4a7069718b028454c9a38c6e",
  "31d9983ccfbd6f2d2c157eac540ee06b31421fb4dc35065dce33b8d41b97ffeb",
  ...
]
```

Now let's retry query for `getblockchaininfo`:

    $ bitcoin-cli -regtest -datadir=. -conf=./bitcoin.conf getblockchaininfo

Now resulting in something like:

``` json
{
  "chain": "regtest",
  "blocks": 500,
  "headers": 500,
  "bestblockhash": "1496f1188c53d79c1f1858485feaa71924a9fe47a8209e2eacecd3b916a70245",
  "difficulty": 4.656542373906925e-010,
  "mediantime": 1506863235,
  "verificationprogress": 1,
  "chainwork": "00000000000000000000000000000000000000000000000000000000000003ea",
  "pruned": false,
  ...
}
```

Check your balance - mining rewards in bitcoins (BTC):

   $ bitcoin-cli -regtest -datadir=. -conf=./bitcoin.conf getbalance

12462.50000000

Congrats. You now own 12 462 bitcoins (BTC) on your own (local) blockchain.


Let's query the first block, that is, `15262fb31ca5680c0af236c0fbb6b3d39a1686afcd46a01549c2cc2a4626b791`:

Note: You can get the hash for the block with `getblockhash`. Example:

   $ bitcoin-cli -regtest -datadir=. -conf=./bitcoin.conf getblockhash 1

Resulting in:

   15262fb31ca5680c0af236c0fbb6b3d39a1686afcd46a01549c2cc2a4626b791


Now let's query for the frist block with `getblock`. Example:

   $ bitcoin-cli -regtest -datadir=. -conf=./bitcoin.conf getblock 15262fb31ca5680c0af236c0fbb6b3d39a1686afcd46a01549c2cc2a4626b791

Resulting in:

``` json
{
  "hash": "15262fb31ca5680c0af236c0fbb6b3d39a1686afcd46a01549c2cc2a4626b791",
  "confirmations": 500,
  "strippedsize": 226,
  "size": 226,
  "weight": 904,
  "height": 1,
  "version": 536870912,
  "versionHex": "20000000",
  "merkleroot": "0d41ef5aacae3d61475a2101873fd0e33fb1b8de8ec99211b18cd97f29be1bef",
  "tx": [
    "0d41ef5aacae3d61475a2101873fd0e33fb1b8de8ec99211b18cd97f29be1bef"
  ],
  "time": 1506863151,
  "mediantime": 1506863151,
  "nonce": 0,
  "bits": "207fffff",
  "difficulty": 4.656542373906925e-010,
  "chainwork": "0000000000000000000000000000000000000000000000000000000000000004",
  "previousblockhash": "0f9188f13cb7b2c71f2a335e3a4fc328bf5beb436012afca590b1a11466e2206",
  "nextblockhash": "1a482dbae5bee25f510abbc9b7835cd2550203c36eb60fe0b4e9db76dac17075"
}
```

That's it. Happy blockchaining.

