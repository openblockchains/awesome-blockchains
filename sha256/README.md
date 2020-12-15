# Awesome SHA256

A collection about the most awesome crypto (one-way) hash function / digest / fingerprint - Secure Hash Algorithm 256-Bit (SHA256)



Trivia Quiz: What's SHA256?

- (A) Still Hacking Anyway
- (B) Secure Hash Algorithm
- (C) Sweet Home Austria
- (D) Super High Aperture

A: SHA256 == Secure Hash Algorithm 256-Bit

SHA256 is a (secure) hashing algorithm designed
by the National Security Agency (NSA) of the United States of America (USA).

Find out more @ [Secure Hash Algorithms (SHA) @ Wikipedia](https://en.wikipedia.org/wiki/Secure_Hash_Algorithms).

A (secure) hash is also known as:

- Digital (Crypto) Fingerprint == (Secure) Hash
- Digital (Crypto) Digest      == (Secure) Hash
- Digital (Crypto) Checksum    == (Secure) Hash



## Hello, Cryptos!

Print the SHA256 hash digest as a 64 hex string for "Hello, Cryptos!"

Note: 1 hex char is 4-bits, 2 hex chars are 4x2=8 bits
and 64 hex chars are 4x64=256 bits.

Hexa(decimal) chart:

|binary|hex (2^4=16)|decimal|binary|hex (2^4=16)|decimal|
|------|------------|-------|------|------------|-------|
| 0000 | **0**      | 0     | 1000 | **8**      | 8     |
| 0001 | **1**      | 1     | 1001 | **9**      | 9     |
| 0010 | **2**      | 2     | 1010 | **a**      | 10    |
| 0011 | **3**      | 3     | 1011 | **b**      | 11    |
| 0100 | **4**      | 4     | 1100 | **c**      | 12    |
| 0101 | **5**      | 5     | 1101 | **d**      | 13    |
| 0110 | **6**      | 6     | 1110 | **e**      | 14    |
| 0111 | **7**      | 7     | 1111 | **f**      | 15    |


### Ruby

``` ruby
require "digest"

p Digest::SHA256.hexdigest( "Hello, Cryptos!" )
# => 33eedea60b0662c66c289ceba71863a864cf84b00e10002ca1069bf58f9362d
```

### Go

``` go
package main

import(
  "fmt"
  "crypto/sha256"
)

func main() {
  fmt.Printf( "%x\n", sha256.Sum256( []byte( "Hello, Cryptos!" )))
  // => 33eedea60b0662c66c289ceba71863a864cf84b00e10002ca1069bf58f9362d5
}
```


