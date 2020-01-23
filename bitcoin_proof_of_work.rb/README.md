# Inside Bitcoin's Proof-of-Work / Waste 10-Minute Mining Lottery


## TL;DR (Too Long; Didn't Read) - Management Executive Summary

[**How Bitcoin Mining Works**]( https://twitter.com/Tr0llyTr0llFace/status/1119657122126602240) by Trolly McTrollface

Me: I just set a $100 bill on fire.  
Everyone: That's stupid.  
Me: I have undeniable proof.  
Bitcoiners: We'll give you $200 for it.  



## Intro

Did you know? The Proof-of-work / waste mining lottery in bitcoin is a global energy environmental disaster.
The estimate for bitcoin classic transactions is 300 kW-h per bitcoin transaction (!) 
that's about 179 kilograms of CO₂ emissions¹.

¹: Assuming let's say 0.596 kilograms of CO₂ per kW-h 
(that's the energy efficiency in Germany) that's 
about 179 kilograms of CO₂ per bitcoin transaction (300 kW-h × 0.596 kg). For more insights see [Bitcoin CO₂ - The Proof-of-Work / Waste Environmental Mining Disaster](https://github.com/openblockchains/awesome-blockchains/blob/master/BITCOIN-CO2.md).



Let's look how Bitcoin's Proof-of-Work / Waste 10-Minute Mining Lottery works
and what's the lucky number used once (nonce) that wins the mining lottery 
and what's the difficulty target to make it easier or harder to find the nonce.



## Proof-of-Work By Example - The Ruby Edition


### Let's calculate the SHA-256 hash

> Let's say the base string that we are going to do work on is `"Hello, world!"`. 
> Our target is to find a variation of it that SHA-256 hashes to a value smaller than `2^240`. 
> We vary the string by adding an integer value to the end called a nonce and incrementing it each time, 
> then interpreting the hash result as a long integer and checking whether 
> it's smaller than the target `2^240`. 
> Finding a match for `"Hello, world!"` takes us 4251 tries.
>
> ```
> "Hello, world!0" => 1312af178c253f84028d480a6adc1e25e81caa44c749ec81976192e2ec934c64 = 2^252.253458683
> "Hello, world!1" => e9afc424b79e4f6ab42d99c81156d3a17228d6e1eef4139be78e948a9332a7d8 = 2^255.868431117
> "Hello, world!2" => ae37343a357a8297591625e7134cbea22f5928be8ca2a32aa475cf05fd4266b7 = 2^255.444730341
> ...
> "Hello, world!4248" => 6e110d98b388e77e9c6f042ac6b497cec46660deef75a55ebc7cfdf65cc0b965 = 2^254.782233115
> "Hello, world!4249" => c004190b822f1669cac8dc37e761cb73652e7832fb814565702245cf26ebb9e6 = 2^255.585082774
> "Hello, world!4250" => 0000c3af42fc31103f1fdc0151fa747ff87349a4714df7cc52ea464e12dcd4e9 = 2^239.61238653
> ```
>
> 4 251 hashes on a modern computer is not very much work (most computers can achieve at least 4 million hashes per second). 
> Bitcoin automatically varies the target (and thus the amount of work required to generate a block) 
> to keep a roughly constant rate of block generation [,that is, about every 10 minutes for the mining lottery].
>
> (Source: [Proof of work @ Bitcoin Wiki](https://en.bitcoin.it/wiki/Proof_of_work))

Let's break down the "magic" proof-of-work / waste lottery step-by-step 
and let's start with calculating the SHA-256 hash:


``` ruby
require "digest"

def sha256( msg )
  Digest::SHA256.hexdigest( msg )
end

sha256( "Hello, world!0" )   
#=> "1312af178c253f84028d480a6adc1e25e81caa44c749ec81976192e2ec934c64"
sha256( "Hello, world!1" )   
#=> "e9afc424b79e4f6ab42d99c81156d3a17228d6e1eef4139be78e948a9332a7d8"
sha256( "Hello, world!2" )   
#=> "ae37343a357a8297591625e7134cbea22f5928be8ca2a32aa475cf05fd4266b7"

# ...

sha256( "Hello, world!4248" )
#=> "6e110d98b388e77e9c6f042ac6b497cec46660deef75a55ebc7cfdf65cc0b965"
sha256( "Hello, world!4249" ) 
#=> "c004190b822f1669cac8dc37e761cb73652e7832fb814565702245cf26ebb9e6"
sha256( "Hello, world!4250" )
#=> "0000c3af42fc31103f1fdc0151fa747ff87349a4714df7cc52ea464e12dcd4e9"
```

(Source: [`hashes.rb`](hashes.rb))



Note: The resulting hash is always a fixed 256-bit in size or 64 hex(adecimal) characters (0-9,a-f) 
in length even if the input is less than 256-bit or much bigger than 256-bit.

Trivia Quiz: What's SHA256?

- (A) Still Hacking Anyway
- (B) Secure Hash Algorithm
- (C) Sweet Home Austria
- (D) Super High Aperture

B: SHA256 == Secure Hash Algorithms 256 Bits

SHA256 is a (secure) hashing algorithm designed by the National Security Agency (NSA)
of the United States of America (USA).

Find out more @ [Secure Hash Algorithms (SHA) @ Wikipedia](https://en.wikipedia.org/wiki/Secure_Hash_Algorithms).



### What's your hash rate per second? Let's calculate 10 million (or 10,000,000) hashes and check...

Let's get back to:

4 251 hashes on a modern computer is not very much work - most computers can achieve 
at least 4 million (or 4,000,000) hashes per second.

> Bitcoin's hash rate experienced an explosive increase over 2019, jumping from 42 exahashes per second (EH/s) (or,
> 42,000,000,000,000,000,000 hashes per second) to 112 EH/s
> (or, 112,000,000,000,000,000,000 hashes per second).
>
> (Source: [Happy Birthday Bitcoin! Here's a Look at Bitcoin's 11th Year by the Numbers](https://bitcoinmagazine.com/articles/happy-birthday-bitcoin-heres-a-look-at-bitcoins-11th-year-by-the-numbers))

What's your hash rate per second? Let's calculate 10 million (or 10,000,000) hashes and check...

``` ruby
#################
## Let's calculate 10 million, that is, 10 000 000 hashes.
##   e.g. "Hello, world!0"
##        "Hello, world!1"
##        "Hello, world!2"
##        "Hello, world!3"
##        and on and on and on

t1 = Time.now
10_000_000.times do |i|
  sha256( "Hello, world!#{i}")

  # bonus: print a dot (.) for progress for every one hundred thousand hashes calculated
  print "."    if i % 100_000 == 0      
end
t2 = Time.now

delta = t2 - t1
puts ""
puts "Elapsed Time: %.4f seconds" % delta

hashrate = Float( 10_000_000 / delta )
puts "Hash Rate: %d hashes/second" % hashrate
```

(Source: [`hashrate.rb`](hashrate.rb))


Resulting in (using a plain-vanilla personal computer in 2020):

```
....................................................................................................
Elapsed Time: 26.7724 seconds
Hash Rate: 373,518 hashes/second
```

Try the script at your computer. What's your hash rate today?


Trivia Quiz: What's the (advertised) hash rate/s for the ASIC (Application-specific integrated circuit)
AntMiner S9 sold by Bitmain for US$ 2,400?

- (A) 14,000,000 hashes/second
- (B) 14,000,000,000 hashes/second
- (C) 14,000,000,000,000 hashes/second
- (D) 14,000,000,000,000,000 hashes/second


C: 14,000,000,000,000 hashes/second (or 14,000,000 million hashes/s)

Find out more @ [Mining hardware comparison @ Bitcoin Wiki](https://en.bitcoin.it/wiki/Mining_hardware_comparison)




### Hitting the difficulty target - Find the lucky number used once (nonce) - Find the winning mining lottery ticket

Let's get back to:

Our target is to find a variation of it that SHA-256 hashes
to a value smaller than `2^240`.

Every hash is really a big 256-bit (integer) number.
Let's convert the `"Hello, world!0"`
hash in hex(adecimal) format
e.g.  `"1312af178c253f84028d480a6adc1e25e81caa44c749ec81976192e2ec934c64"`
to a big (integer) number
e.g. `8626955810696577806643191367156697543225924734479747394789354329720975740004`
and than calculate the binary base 2 logarithm  (`log2`)
e.g. `2^252.253458683`.

``` ruby
hash = sha256( "Hello, world!0" )
#=> "1312af178c253f84028d480a6adc1e25e81caa44c749ec81976192e2ec934c64"

num = hash.to_i( 16 )  ## convert hex(adecimal) hash to (integer) number
#=> 8626955810696577806643191367156697543225924734479747394789354329720975740004
```

(Source: [`target.rb`](target.rb))



Q: What's the binary base 2 logarithm  (`log2`)?

> In mathematics, the binary logarithm (`log2 n`)
> is the power to which the number 2 must be raised to obtain the value `n`.
> That is, for any real number `x`,
>
>     x = log2(n)  <==>  2^x = n.
>
> -- [Binary logarithm @ Wikipedia](https://en.wikipedia.org/wiki/Binary_logarithm)


Let's try:

``` ruby
log2 = Math.log2( num )
#=> 252.2534586827243
```

Bingo! `2^252.2534586827243` is an even more accurate calculation
than the expected `2^252.253458683`.

Let's try the winning lucky number example:

```
"Hello, world!4250" => 0000c3af42fc31103f1fdc0151fa747ff87349a4714df7cc52ea464e12dcd4e9 = 2^239.61238653
```

And here we go:

``` ruby
hash = sha256( "Hello, world!4250" )
#=> "0000c3af42fc31103f1fdc0151fa747ff87349a4714df7cc52ea464e12dcd4e9"
```

Note: The "lucky number" hash has four leading zeros in hex(adecimal), that is, `0000`.


``` ruby
num = hash.to_i( 16 )
#=> 1350565582647790482127632554504241516291697500941742491868079705537959145

log2 = Math.log2( num )
#=> 239.61238652983653
```

Bingo! `2^239.61238652983653` is an even more accurate calculation
than the expected `2^239.61238653`.


What's up with `2^252` or `2^239`?

The binary logarithm (e.g. `252` or `239`)
tells you how many binary digits the number has.
The higher (`252`) the binary logarithm (`log2`) the bigger the number,
the lower (`239`) the binary logarithm (`log2`) the smaller the number.

The maximum for a 256-bit number is - surprise, surprise - 256.
Let's double check and calculate:

``` ruby
max = "f"*64
#=> "ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"

num = max.to_i( 16 )
#=> 115792089237316195423570985008687907853269984665640564039457584007913129639935

log2 = Math.log2( num )
#=> 256.0
```

Hashes get printed in hexa(decimal) and NOT binary - the computer's native `0` and `1`
format - because hexa(decimal) is 4 times more compact.
Let's try:

``` ruby
hash = sha256( "Hello, world!4250" )
#=> "0000c3af42fc31103f1fdc0151fa747ff87349a4714df7cc52ea464e12dcd4e9"

num = hash.to_i( 16 )
#=> 1350565582647790482127632554504241516291697500941742491868079705537959145

puts "%0256b" % num
#=> 0000000000000000110000111010111101000010111111000011000100010000
#   0011111100011111110111000000000101010001111110100111010001111111
#   1111100001110011010010011010010001110001010011011111011111001100
#   0101001011101010010001100100111000010010110111001101010011101001
```

If you count the binary number for the `"Hello, world!4250"`
hash, it has 16 leading zeros (that is, `0000000000000000`)
in the 256-bit number.

**Remember: The more leading zeros (in fixed binary or hexadecimal format) the smaller the number
and the more difficult the proof-of-work mining lottery.**



### All together now - Mine hash with proof-of-work for difficulty target


Let's put everything together in a `mine_hash_with_proof_of_work`
method:


``` ruby
def mine_hash_with_proof_of_work( msg, target: 2**240 )
  nonce = 0
  loop do
    hash = sha256( "#{msg}#{nonce}" )

    if hash.to_i(16) < target
      ## bingo! proof of work if hash is smaller than the difficulty target number
      return [nonce,hash]
    else
      ## keep trying (and trying and trying)
      nonce += 1
    end
  end # loop
end
```

(Source: [`proof_of_work.rb`](proof_of_work.rb))


And let's try the
Proof-of-Work example from the Bitcoin Wiki.

Note: The difficulty target `2^240` translates to
`2**240`
and, yes, `2**240` is a big (integer) number.
Try:

``` ruby
2**240    # 2^240
#=> 1766847064778384329583297500742918515827483896875618958121606201292619776
```


And let's use `"Hello, world!"` for the hash:

```ruby
nonce, hash = mine_hash_with_proof_of_work( "Hello, world!", target: 2**240)
#=> 4250, "0000c3af42fc31103f1fdc0151fa747ff87349a4714df7cc52ea464e12dcd4e9"
```

Bingo! The lucky number used once (nonce) is as expected 4250
and the hash `0000c3af42fc31103f1fdc0151fa747ff87349a4714df7cc52ea464e12dcd4e9`
and the only way to find the lucky winning nonce in the lottery is brute force, that is,
trying and trying and trying.


> The proof-of-work involves scanning for a value that when hashed, such as with
> SHA-256, the hash begins with a number of zero bits. The average work required is exponential in the number of zero bits required
> and can be verified by executing a single hash.
>
> -– [Satoshi Nakamoto @ Bitcoin Whitepaper](https://bitsblocks.github.io/bitcoin-whitepaper)


Note: You can always verify (and double-check) if the hash
is smaller than the target difficulty and, thus, valid.

``` ruby
nonce = 4250
msg   = "Hello, world!"

hash = sha256( "#{msg}#{nonce}" )
#=> "0000c3af42fc31103f1fdc0151fa747ff87349a4714df7cc52ea464e12dcd4e9"

target = 2**240
#=> 1766847064778384329583297500742918515827483896875618958121606201292619776
num    = hash.to_i(16)
#=> 1350565582647790482127632554504241516291697500941742491868079705537959145

num < target
#=> true
```

(Source: [`verify.rb`](verify.rb))


Try to change the nonce back to 0, 1, 2, etc. and
you will always get `false` because the resulting hash is bigger
(and NOT smaller) than the target difficulty and, thus, NOT valid.


## Target and Difficulty


> Target - The number you need to get below to mine a block.
>
> Difficulty - The difficulty is a number that regulates how long it takes for miners
> to add new blocks of transactions to the blockchain.
> This difficulty value updates every 2016 blocks (on average every 2 weeks)
> to ensure that it takes 10 minutes (on average)
> to add a new block to the blockchain.
>
> -- [Learn Me A Bitcoin](https://learnmeabitcoin.com/beginners/difficulty)

In the genesis block on Jan/3, 2009 the bitcoin classic network
started with a hard-coded maximum target (`targetmax`) of:

    0x00000000ffff0000000000000000000000000000000000000000000000000000

and the maximum (highest-ever possible) target sets
by definition the (lowest-ever possible) difficulty to 1.

If the difficulty goes up (by two, for example), the target number will go down (by half).



###  Calculating the target using the difficulty

If you have only the difficulty you can
calculate the target number from the difficulty with
the equation:

    target = targetmax / difficulty


Let's use the difficulty of block 100,000 (mined on Dec/29, 2010), that is,
`14,484.162361`. Yes, that's more than 14 thousand times more difficult since genesis.

``` ruby
targetmax  = 0x00000000ffff0000000000000000000000000000000000000000000000000000
#=> 26959535291011309493156476344723991336010898738574164086137773096960
difficulty = 14484.162361

target = targetmax / difficulty
#=> 1861311315012765306929610463010191006516769515973403833769533170
```

(Source: [`difficulty.rb`](difficulty.rb))


Let's try another one and let's use the difficulty seven years later
of block 500,000 (mined on Dec/1, 2017), that is, `1,873,105,475,221.6`.
Yes, that's more than about 2 thousand billion (!) times more difficult since genesis.

Note: As the difficulty goes up, the target goes down.

``` ruby
difficulty = 1873105475221.6

target = targetmax / difficulty
#=> 14392961660539606926930209015440658523615307253181250777
```


Aside:  Floating Point Precision in Calculations with Big Integer Numbers

If you use floating point numbers in your calculations e.g. `14484.162361`
with big integer numbers
you will get imprecise results. One alternate way is to
convert everything to integer using a scale factor
(that is, for six digits after the comma multiple by 10**6 equal to 1000000).
Example:

``` ruby
difficulty = 14484.162361
#=> 14484.162361
difficulty = (14484.162361*1000000).to_i
#=> 14484162361

target = (targetmax*1000000) / difficulty
#=> 1861311315012765306929610463010191006516769515973403833769533170
```

And let's pack up the code in a `difficulty_to_target` method
for easy (re)use:

``` ruby
def difficulty_to_target( difficulty, scale: )
   targetmax = 0x00000000ffff0000000000000000000000000000000000000000000000000000
   factor    = 10**scale

   targetmax*factor / (difficulty*factor).to_i
end

difficulty_to_target( 14484.162361, scale: 6 )
#=> 1861311315012765306929610463010191006516769515973403833769533170
difficulty_to_target( 1873105475221.6, scale: 1 )
#=> 14392961660539606926930209015440658523615307253181250777
```


If you print the target in hex(adecimal) you count the leading zeros:

|  Block         | Date | Difficulty |    Target   | Log2 |
|----------------|------|------------|-------------|------|
|    0 (Genesis) | Jan/3, 2009  |  1 | `00000000FFFF0000000000000000000000000000000000000000000000000000` | 2^224 |
| 100,000   | Dec/29, 2010  | 14,484.162361 | `000000000004864c00004d6ac7cd33f734b8eb28b24729fe151953ec57a21ef2`   | 2^210  |
| 500,000   | Dec/1, 2017   |  1,873,105,475,221.6  | `000000000000000000964500000000fc2cc6932cfb3a8ff7cbbf47bd8e22fcd9`  | 2^183  |
| 614,190   | Jan/23, 2020  |  14,776,367,535,688.64  | `000000000000000000130c77ffffffffccc21951757a6bc6d24a653f04e4c7a9` | 2^180  |



What's today's bitcoin network difficulty?

You can use the `getdifficulty` Bitcoin API service.
The documentation reads:

```
getdifficulty

Returns the proof-of-work difficulty as a multiple of the minimum difficulty.
```

For example, on Jan/23, 2020 you will get:

``` json
{
  "result": 14776367535688.64
}
```

Or lookup the difficulty in a chart:

- [Difficulty Chart @ Blockchain.com](https://www.blockchain.com/charts/difficulty?timespan=all)



## Conclusion

That's all the magic of the proof-of-work / waste mining lottery.
The environmental disaster in Bitcoin is the gigantic industrial scale.
In 2019 the hash rate/second hit an all-time-high.


And the only purpose for burning millions of $$$ in energy every day (or billions every year)
for the proof-of-work / waste hashing is... running a lottery that picks one (!) random winner every 10-minute, that's all.

> Bitcoin's hash rate experienced an explosive increase over 2019, jumping from 42 exahashes per second (EH/s) (or,
> 42,000,000,000,000,000,000 hashes per second) to 112 EH/s (or, 112,000,000,000,000,000,000 hashes per second).
>
> Mining difficulty more than doubled from the beginning to the end of 2019, rising from 6 Trillion to 13 Trillion.
>
> (Source: [Happy Birthday Bitcoin! Here's a Look at Bitcoin's 11th Year by the Numbers](https://bitcoinmagazine.com/articles/happy-birthday-bitcoin-heres-a-look-at-bitcoins-11th-year-by-the-numbers))

Note: No matter how many more lottery tickets (e.g. from 42,000,000,000,000,000,000/s
to 112,000,000,000,000,000,000/s) you "buy" by hashing more and burning more energy - the difficulty will rise
(e.g. from 6 T to 13 T) and the lottery keeps on picking one (!) random winner every 10-minute.

Burn, baby, burn! The Planet cannot win. Is there a Planet B?


[**How to Buy Bitcoin (The CO₂-Friendly Way)**](https://twitter.com/Tr0llyTr0llFace/status/1130390061499990016) by Trolly McTrollface

1. Take one $50 bill, five $10 bills, or ten $5 bills (I wouldn’t recommend change - stay with paper fiat).
2. Go to the bathroom.
3. Lift the lid of the loo.
4. Throw money in.
5. Flush down water.

Congrats! You just purchased $50 worth of Bitcoin - without fucking the planet!  


