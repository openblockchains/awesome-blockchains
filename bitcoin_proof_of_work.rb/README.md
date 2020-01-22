# Inside Bitcoin's Proof-of-Work / Waste

## TL;DR 

_Too Long; Didn't Read Management Executive Summary_

[**How Bitcoin Mining Works**]( https://twitter.com/Tr0llyTr0llFace/status/1119657122126602240) by Trolly McTrollface

Me: I just set a $100 bill on fire.  
Everyone: That's stupid.  
Me: I have undeniable proof.  
Bitcoiners: We'll give you $200 for it.  



## Intro

Did you know? 



Let's look how Bitcoin's Proof-of-Work / Waste Mining work 
and what's the lucky number used one (nonce) that wins the mining lottery 
and what's the difficulty target to make it easier or harder to find the nonce?



## Proof-of-Work By Example - Step by Step Guide

_The Ruby Version_

Let's say the base string that we are going to do work on is `"Hello, world!"`. 
Our target is to find a variation of it that SHA-256 hashes to a value smaller than `2^240`. 
We vary the string by adding an integer value to the end called a nonce and incrementing it each time, 
then interpreting the hash result as a long integer and checking whether 
it's smaller than the target `2^240`. 
Finding a match for `"Hello, world!"` takes us 4251 tries.

```
"Hello, world!0" => 1312af178c253f84028d480a6adc1e25e81caa44c749ec81976192e2ec934c64 = 2^252.253458683
"Hello, world!1" => e9afc424b79e4f6ab42d99c81156d3a17228d6e1eef4139be78e948a9332a7d8 = 2^255.868431117
"Hello, world!2" => ae37343a357a8297591625e7134cbea22f5928be8ca2a32aa475cf05fd4266b7 = 2^255.444730341
...
"Hello, world!4248" => 6e110d98b388e77e9c6f042ac6b497cec46660deef75a55ebc7cfdf65cc0b965 = 2^254.782233115
"Hello, world!4249" => c004190b822f1669cac8dc37e761cb73652e7832fb814565702245cf26ebb9e6 = 2^255.585082774
"Hello, world!4250" => 0000c3af42fc31103f1fdc0151fa747ff87349a4714df7cc52ea464e12dcd4e9 = 2^239.61238653
```

4 251 hashes on a modern computer is not very much work (most computers can achieve at least 4 million hashes per second). 
Bitcoin automatically varies the target (and thus the amount of work required to generate a block) 
to keep a roughly constant rate of block generation [,that is, about every 10 minutes].

(Source: [Proof of work @ Bitcoin Wiki](https://en.bitcoin.it/wiki/Proof_of_work))


Let's calculate the SHA-256 hash:

``` ruby
require "digest"

def sha256( msg )
  Digest::SHA256.hexdigest( msg )
end

sha256( "Hello, world!0" )   
#=> "1312af178c253f84028d480a6adc1e25e81caa44c749ec81976192e2ec934c64"
sha256( "Hello, world!1" )   
#=> "e9afc424b79e4f6ab42d99c81156d3a17228d6e1eef4139be78e948a9332a7d8"
sha256( "Hello, world!1" )   
#=> "ae37343a357a8297591625e7134cbea22f5928be8ca2a32aa475cf05fd4266b7"

# ...
```

Note: The resulting hash is always 256-bit in size or 64 hex(adecimal) chars (0-9,a-f) 
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


Let's get back to:

4 251 hashes on a modern computer is not very much work - most computers can achieve 
at least 4 million (or 4,000,000) hashes per second.

> Bitcoin's hash rate experienced an explosive increase over 2019, jumping from 42 exahashes per second (EH/s) (or,
> 42,000,000,000,000,000,000 hashes per second) to 112 EH/s.
>
> (Source: [Happy Birthday Bitcoin! Here's a Look at Bitcoin's 11th Year by the Numbers](https://bitcoinmagazine.com/articles/happy-birthday-bitcoin-heres-a-look-at-bitcoins-11th-year-by-the-numbers))

What's your hash rate per second? Let's calculate 10 million (or 10,000,000) hashes and wait...

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
  print "."    if i % 100_000 == 0      # print a dot (.) for progress for every one hundred thousand hashes calculated
end
puts ""
t2 = Time.now

delta = t2 - t1
pp delta
puts "Elapsed Time: %.4f seconds" % delta

hashrate = Float( 10_000_000 / delta )
puts "Hash Rate: %d hashes/second" % hashrate
```

Resulting in (using a plain-vanilla personal computer):

```
....................................................................................................
Elapsed Time: 26.7724 seconds
Hash Rate: 373518 hashes/second
```

Try the script at your computer. What's your hash rate?


### Hitting the target - Find the lucky number used once (nonce)

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
puts hash
#=> "1312af178c253f84028d480a6adc1e25e81caa44c749ec81976192e2ec934c64"

num = hash.to_i( 16 )  ## convert hex(adecimal) hash to (integer) number
#=> 8626955810696577806643191367156697543225924734479747394789354329720975740004
```

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

puts "2^#{log2}"
#=> 2^252.2534586827243
```

Bingo! `2^252.2534586827243` is an even more accurate calculation
than the expected `2^252.253458683`.

Let's try the winning lucky number example:

```
"Hello, world!4250" => 0000c3af42fc31103f1fdc0151fa747ff87349a4714df7cc52ea464e12dcd4e9 = 2^239.61238653
```

And here we go:

```
hash = sha256( "Hello, world!4250" )
#=> "0000c3af42fc31103f1fdc0151fa747ff87349a4714df7cc52ea464e12dcd4e9"
```

Note: The "lucky number" hash has four leading zeros in hex(adecimal), that is, `0000`.

```
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

num = hash.to_i( 16 )
puts num
#=> 115792089237316195423570985008687907853269984665640564039457584007913129639935

log2 = Math.log2( num )
#=> 256
puts "2^#{log2}"
#=> 2^256
```

Trivia Quiz: How many leading zeros has a `0000` hash in hexa(decimal)
with four zeros in binary?

- (A)  4
- (B)  8   - 2 times (e.g. 4×2)
- (C)  12  - 3 times (e.g. 4×3)
- (D)  16  - 4 times (e.g. 4×4)

Hashes get printed in hexa(decimal) and NOT binary - the computer's native `0` and `1`
format - because hexa(decimal) is 4 times more compact.
Let's try:

``` ruby
hash = sha256( "Hello, world!4250" )
#=> "0000c3af42fc31103f1fdc0151fa747ff87349a4714df7cc52ea464e12dcd4e9"

num = hash.to_i( 16 )
#=> 1350565582647790482127632554504241516291697500941742491868079705537959145

num = hash.to_i( 16 )
puts "%0256b" % num
#=> 0000000000000000110000111010111101000010111111000011000100010000
#   0011111100011111110111000000000101010001111110100111010001111111
#   1111100001110011010010011010010001110001010011011111011111001100
#   0101001011101010010001100100111000010010110111001101010011101001
```

If you count the binary number for the `"Hello, world!4250"`
hash, has 16 leading zeros (that is, `0000000000000000`)
in the 256-bit number.

**Remember: The more leading (binary) zeros the smaller the number
and the more difficult the proof-of-work mining.**







