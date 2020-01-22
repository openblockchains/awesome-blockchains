# Inside Bitcoin's Proof-of-Work / Waste Environmental Mining Disaster


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

4251 hashes on a modern computer is not very much work (most computers can achieve at least 4 million hashes per second). 
Bitcoin automatically varies the target (and thus the amount of work required to generate a block) 
to keep a roughly constant rate of block generation [,that is, about every 10 minutes].

(Source: [Proof of work @ Bitcoin Wiki](https://en.bitcoin.it/wiki/Proof_of_work))





