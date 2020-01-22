# Inside Bitcoin's Proof-of-Work / Waste Environmental Mining Disaster


Did you know? 




Let's look how Bitcoin's Proof-of-Work / Waste Mining work?


## TL;DR 

_Short for "Too Long; Didn't Read" Management Executive Summary_

[**How Bitcoin Mining Works**]( https://twitter.com/Tr0llyTr0llFace/status/1119657122126602240) by Trolly McTrollface

Me: I just set a $100 bill on fire.  
Everyone: That's stupid.  
Me: I have undeniable proof.  
Bitcoiners: We'll give you $200 for it.  


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

sha256( "Hello, world!0" )   #=> "1312af178c253f84028d480a6adc1e25e81caa44c749ec81976192e2ec934c64"
sha256( "Hello, world!1" )   #=> "e9afc424b79e4f6ab42d99c81156d3a17228d6e1eef4139be78e948a9332a7d8"
sha256( "Hello, world!1" )   #=> "ae37343a357a8297591625e7134cbea22f5928be8ca2a32aa475cf05fd4266b7"
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

4 251 hashes on a modern computer is not very much work 
- most computers can achieve at least 4 million (or 4,000,000) hashes per second.

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















