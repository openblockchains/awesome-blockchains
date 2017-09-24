###########################
#  build your own blockchain from scratch in 20 lines of ruby!
#
#  to run use:
#    $ ruby ./blockchain_with_transactions.rb

#
#  transactions (hyper) ledger / book:
#
#  from: Dutchgrown       to: Vincent    what: Tulip Bloemendaal Sunset   qty: 10
#  from: Keukenhof        to: Anne       what: Tulip Semper Augustus      qty: 7
#
#  from: Flowers          to: Ruben      what: Tulip Admiral van Eijck    qty: 5
#  from: Vicent           to: Anne       what: Tulip Bloemendaal Sunset   qty: 3
#  from: Anne             to: Julia      what: Tulip Semper Augustus      qty: 1
#  from: Julia            to: Luuk       what: Tulip Semper Augustus      qty: 1
#
#  from: Bloom & Blossom  to: Daisy      what: Tulip Admiral of Admirals  qty: 8
#  from: Vincent          to: Max        what: Tulip Bloemendaal Sunset   qty: 2
#  from: Anne             to: Martijn    what: Tulip Semper Augustus      qty: 2
#  from: Ruben            to: Julia      what: Tulip Admiral van Eijck    qty: 2
#
#  from: Teleflora        to: Max        what: Tulip Red Impression       qty: 11
#  from: Anne             to: Naomi      what: Tulip Bloemendaal Sunset   qty: 1
#  from: Daisy            to: Vincent    what: Tulip Admiral of Admirals  qty: 3
#  from: Julia            to: Mina       what: Tulip Admiral van Eijck    qty: 1
#
#  from: Max              to: Isabel     what: Tulip Red Impression       qty: 2
#
# (source: tulips on the blockchain - public distributed (hyper) ledger
#    @ github.com/openblockchains/tulips )


require "digest"    # for hash checksum digest function SHA256
require "pp"        # for pp => pretty printer


class Block

  attr_reader :index
  attr_reader :timestamp
  attr_reader :transactions
  attr_reader :transactions_count
  attr_reader :previous_hash
  attr_reader :hash

  def initialize(index, transactions, previous_hash)
    @index              = index
    @timestamp          = Time.now.utc
    @transactions       = transactions
    @transactions_count = transactions.size
    @previous_hash      = previous_hash
    @hash               = calc_hash
  end

  def calc_hash
    sha = Digest::SHA256.new
    sha.update( @index.to_s +
                @timestamp.to_s +
                @transactions_count.to_s +
                @transactions.to_s +
                @previous_hash )
    sha.hexdigest
  end


  ##  ruby note: the splat operator (that is, *) turns list of passed in transactions into array
  def self.first( *transactions )    # create genesis (big bang! first) block
    ## uses index zero (0) and arbitrary previous_hash ("0")
    Block.new( 0, transactions, "0" )
  end

  def self.next( previous, *transactions )
    Block.new( previous.index+1, transactions, previous.hash )
  end

end  # class Block


#####
## let's get started
##   build a blockchain a block at a time

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

b3 = Block.next( b2,
        { from: "Teleflora", to: "Max",     what: "Tulip Red Impression",      qty: 11 },
        { from: "Anne",      to: "Naomi",   what: "Tulip Bloemendaal Sunset",  qty: 1  },
        { from: "Daisy",     to: "Vincent", what: "Tulip Admiral of Admirals", qty: 3  },
        { from: "Julia",     to: "Mina",    what: "Tulip Admiral van Eijck",   qty: 1  } )


blockchain = [b0, b1, b2, b3]

pp blockchain

######
#  will pretty print (pp) something like:
#
# [#<Block:0x2da3da0
#   @hash="32bd169baebba0b70491b748329ab631c85175be15e1672f924ca174f628cb66",
#   @index=0,
#   @previous_hash="0",
#   @timestamp=2017-09-24 11:40:15 UTC,
#   @transactions=
#    [{:from=>"Dutchgrown", :to=>"Vincent", :what=>"Tulip Bloemendaal Sunset", :qty=>10},
#     {:from=>"Keukenhof",  :to=>"Anne",    :what=>"Tulip Semper Augustus",    :qty=>7}],
#   @transactions_count=2>,
#  #<Block:0x2da2ff0
#   @hash="57b519a8903e45348ac8a739c788815e2bd90423663957f87e276307f77f1028",
#   @index=1,
#   @previous_hash=
#    "32bd169baebba0b70491b748329ab631c85175be15e1672f924ca174f628cb66",
#   @timestamp=2017-09-24 11:40:15 UTC,
#   @transactions=
#    [{:from=>"Flowers", :to=>"Ruben", :what=>"Tulip Admiral van Eijck",  :qty=>5},
#     {:from=>"Vicent",  :to=>"Anne",  :what=>"Tulip Bloemendaal Sunset", :qty=>3},
#     {:from=>"Anne",    :to=>"Julia", :what=>"Tulip Semper Augustus",    :qty=>1},
#     {:from=>"Julia",   :to=>"Luuk",  :what=>"Tulip Semper Augustus",    :qty=>1}],
#   @transactions_count=4>,
#  #<Block:0x2da2720
#   @hash="ec7dd5ea86ab966d4d4db182abb7aa93c7e5f63857476e6301e7e38cebf36568",
#   @index=2,
#   @previous_hash=
#    "57b519a8903e45348ac8a739c788815e2bd90423663957f87e276307f77f1028",
#   @timestamp=2017-09-24 11:40:15 UTC,
#   @transactions=
#    [{:from=>"Bloom & Blossom", :to=>"Daisy",   :what=>"Tulip Admiral of Admirals", :qty=>8},
#     {:from=>"Vincent",         :to=>"Max",     :what=>"Tulip Bloemendaal Sunset",  :qty=>2},
#     {:from=>"Anne",            :to=>"Martijn", :what=>"Tulip Semper Augustus",     :qty=>2},
#     {:from=>"Ruben",           :to=>"Julia",   :what=>"Tulip Admiral van Eijck",   :qty=>2}],
#   @transactions_count=4>,
#  #<Block:0x2da1ee0
#   @hash="a1c5e5035403214a7349c2dedb7858ed411a351d7cb23d196583687a9a019785",
#   @index=3,
#   @previous_hash=
#    "ec7dd5ea86ab966d4d4db182abb7aa93c7e5f63857476e6301e7e38cebf36568",
#   @timestamp=2017-09-24 11:40:15 UTC,
#   @transactions=
#    [{:from=>"Teleflora", :to=>"Max",     :what=>"Tulip Red Impression",      :qty=>11},
#     {:from=>"Anne",      :to=>"Naomi",   :what=>"Tulip Bloemendaal Sunset",  :qty=>1},
#     {:from=>"Daisy",     :to=>"Vincent", :what=>"Tulip Admiral of Admirals", :qty=>3},
#     {:from=>"Julia",     :to=>"Mina",    :what=>"Tulip Admiral van Eijck",   :qty=>1}],
#   @transactions_count=4>]
