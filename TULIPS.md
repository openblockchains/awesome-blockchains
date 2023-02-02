# Tulips :tulip::tulip::tulip: on the Blockchain! - Public Distributed (Hyper) Ledger Book

> Tulips were introduced into the Netherlands in the 16th century.
> These exotic flowers were greatly admired and numerous species were meticulously recorded,
> along with their Latin names, in tulip albums.
>
> -- Rijksmuseum, Amsterdam


Learn by Example from the Real World (Anno 1637) - Buy! Sell! Hold! Enjoy the Beauty of Admiral of Admirals, Semper Augustus and More.


## Transactions (Hyper) Ledger Book

| From                | To           | What                      | Qty |
|---------------------|--------------|---------------------------|----:|
| Dutchgrown (†)      | Vincent      | Tulip Bloemendaal Sunset  |  10 |
| Keukenhof (†)       | Anne         | Tulip Semper Augustus     |   7 |
|                     |              |                           |     |
| Flowers (†)         | Ruben        | Tulip Admiral van Eijck   |   5 |
| Vicent              | Anne         | Tulip Bloemendaal Sunset  |   3 |
| Anne                | Julia        | Tulip Semper Augustus     |   1 |
| Julia               | Luuk         | Tulip Semper Augustus     |   1 |
|                     |              |                           |     |
| Bloom & Blossom (†) | Daisy        | Tulip Admiral of Admirals |   8 |
| Vincent             | Max          | Tulip Bloemendaal Sunset  |   2 |
| Anne                | Martijn      | Tulip Semper Augustus     |   2 |
| Ruben               | Julia        | Tulip Admiral van Eijck   |   2 |
|                     |              |                           |     |
| Teleflora (†)       | Max          | Tulip Red Impression      |  11 |
| Anne                | Naomi        | Tulip Bloemendaal Sunset  |   1 |
| Daisy               | Vincent      | Tulip Admiral of Admirals |   3 |
| Julia               | Mina         | Tulip Admiral van Eijck   |   1 |
|                     |              |                           |     |
| Max                 | Isabel       | Tulip Red Impression      |   2 |

(†): Grower Transaction - New Tulips on the Market!



## Blockchain! Blockchain! Blockchain!

Let's put the tulips on the blockchain! Example [`awesome-blockchains/blockchain_with_transactions.rb`](https://github.com/openblockchains/awesome-blockchains/blob/master/blockchain.rb/blockchain_with_transactions.rb):


```ruby
b0 = Block.first(
        { from: "Dutchgrown", to: "Vincent", what: "Tulip Bloemendaal Sunset", qty: 10 },
        { from: "Keukenhof",  to: "Anne",    what: "Tulip Semper Augustus",    qty: 7  } )

b1 = Block.next( b0,
        { from: "Flowers", to: "Ruben", what: "Tulip Admiral van Eijck",  qty: 5 },
        { from: "Vicent",  to: "Anne",  what: "Tulip Bloemendaal Sunset", qty: 3 },
        { from: "Anne",    to: "Julia", what: "Tulip Semper Augustus",    qty: 1 },
        { from: "Julia",   to: "Luuk",  what: "Tulip Semper Augustus",    qty: 1 } )

b2 = Block.next( b1,
        { from: "Bloom & Blossom", to: "Daisy",   what: "Tulip Admiral of Admirals", qty: 8 },
        { from: "Vincent",         to: "Max",     what: "Tulip Bloemendaal Sunset",  qty: 2 },
        { from: "Anne",            to: "Martijn", what: "Tulip Semper Augustus",     qty: 2 },
        { from: "Ruben",           to: "Julia",   what: "Tulip Admiral van Eijck",   qty: 2 } )
...
```

resulting in:

```
[#<Block:0x2da3da0
  @index              = 0,
  @timestamp          = 1637-09-24 11:40:15,
  @previous_hash      = "0",
  @hash               = "32bd169baebba0b70491b748329ab631c85175be15e1672f924ca174f628cb66",
  @transactions_count = 2,
  @transactions       =
   [{:from=>"Dutchgrown", :to=>"Vincent", :what=>"Tulip Bloemendaal Sunset", :qty=>10},
    {:from=>"Keukenhof",  :to=>"Anne",    :what=>"Tulip Semper Augustus",    :qty=>7}]>,
 #<Block:0x2da2ff0
  @index              = 1,
  @timestamp          = 1637-09-24 11:50:15,
  @previous_hash      = "32bd169baebba0b70491b748329ab631c85175be15e1672f924ca174f628cb66",
  @hash               = "57b519a8903e45348ac8a739c788815e2bd90423663957f87e276307f77f1028",
  @transactions_count = 4,
  @transactions       =
   [{:from=>"Flowers", :to=>"Ruben", :what=>"Tulip Admiral van Eijck",  :qty=>5},
    {:from=>"Vicent",  :to=>"Anne",  :what=>"Tulip Bloemendaal Sunset", :qty=>3},
    {:from=>"Anne",    :to=>"Julia", :what=>"Tulip Semper Augustus",    :qty=>1},
    {:from=>"Julia",   :to=>"Luuk",  :what=>"Tulip Semper Augustus",    :qty=>1}]>,
 #<Block:0x2da2720
  @index              = 2,
  @timestamp          = 1637-09-24 12:00:15,
  @previous_hash      = "57b519a8903e45348ac8a739c788815e2bd90423663957f87e276307f77f1028",
  @hash               = "ec7dd5ea86ab966d4d4db182abb7aa93c7e5f63857476e6301e7e38cebf36568",
  @transactions_count = 4,
  @transactions       =
   [{:from=>"Bloom & Blossom", :to=>"Daisy",   :what=>"Tulip Admiral of Admirals", :qty=>8},
    {:from=>"Vincent",         :to=>"Max",     :what=>"Tulip Bloemendaal Sunset",  :qty=>2},
    {:from=>"Anne",            :to=>"Martijn", :what=>"Tulip Semper Augustus",     :qty=>2},
    {:from=>"Ruben",           :to=>"Julia",   :what=>"Tulip Admiral van Eijck",   :qty=>2}]>,
 ...
```


## Alternatives

Anyone? Show us your tulips on the blockchain examples!


## What's a Blockchain?

See the [Awesome Blockchains](https://github.com/openblockchains/awesome-blockchains) page for more.


## We <3 Tulips, Tulips, Tulips :tulip::tulip::tulip:

> Tulips never lost their popularity, and growers in the west of Holland
> have continued to develop new varieties to this very day.
>
> -- Rijksmuseum, Amsterdam




## License

![](https://publicdomainworks.github.io/buttons/zero88x31.png)

The tulips on the blockchain transactions and scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.
