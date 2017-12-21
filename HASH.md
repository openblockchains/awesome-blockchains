

# (Crypto) Hash

Synonyms (also known as):

- Digital Fingerprint
- Digital Digest
- Digital Checksum



## SHA256 - Secure Hash Algorithm 256-Bits

``` ruby
Digest::SHA256.hexdigest( 'Hello, World!' )
#=> "dffd6021bb2bd5b0af676290809ec3a53191dd81c7f70a4b28688a362182986f"

Digest::SHA256.hexdigest( 'Hello, World! - Hello, World! - Hello, World! - Hello, World! - Hello, World!' )
#=> "9e513dbdfe60a14f0cac37aeacbe24fa961b428e8ddeb4d6a66006b29425bbd2"
```

note: 1 hex digit (0-9a-f) = 4 bits; 2 hex digits = 1 byte = 8 bits;
always 64 hex digits (0-9a-f) = 32x8 bytes = 256 bits  


convert from hex (base 16) to decimal number (base 10)

``` ruby
hex = Digest::SHA256.hexdigest( 'Hello, World!' )
#=> "dffd6021bb2bd5b0af676290809ec3a53191dd81c7f70a4b28688a362182986f"

hex.to_i( 16 )
#=> 101313441018496298855616188252934726526525012911655317211406949275718146758767
```

convert to 256-bits (32-bytes) binary number (base 2)

``` ruby
h.to_i( 16 ).to_s( 2 )
# => "1101 1111 1111 1101 0110 0000 0010 0001 1011 1011 0010 1011 1101 0101 1011 0000 
#     1010 1111 0110 0111 0110 0010 1001 0000 1000 0000 1001 1110 1100 0011 1010 0101
#     0011 0001 1001 0001 1101 1101 1000 0001 1100 0111 1111 0111 0000 1010 0100 1011
#     0010 1000 0110 1000 1000 1010 0011 0110 0010 0001 1000 0010 1001 1000 0110 1111"
```

double check (32x8 bytes = 256 bits):

| bin       | hex | bin       | hex | bin       | hex | bin       | hex |
|-----------|-----|-----------|-----|-----------|-----|-----------|-----|
| 1101 1111 | d f | 1010 1111 | a f | 0011 0001 | 3 1 | 0010 1000 | 2 8 |
| 1111 1101 | f d | 0110 0111 | 6 7 | 1001 0001 | 9 1 | 0110 1000 | 6 8 |
| 0110 0000 | 6 0 | 0110 0010 | 6 2 | 1101 1101 | d d | 1000 1010 | 8 a |
| 0010 0001 | 2 1 | 1001 0000 | 9 0 | 1000 0001 | 8 1 | 0011 0110 | 3 6 |
| 1011 1011 | b b | 1000 0000 | 8 0 | 1100 0111 | c 7 | 0010 0001 | 2 1 |
| 0010 1011 | 2 b | 1001 1110 | 9 e | 1111 0111 | f 7 | 1000 0010 | 8 2 |
| 1101 0101 | d 5 | 1100 0011 | c 3 | 0000 1010 | 0 a | 1001 1000 | 9 8 |
| 1011 0000 | b 0 | 1010 0101 | a 5 | 0100 1011 | 4 b | 0110 1111 | 6 f |



Articles:

- [Secure Hash Algorithms @ Wikipedia](https://en.wikipedia.org/wiki/Secure_Hash_Algorithms)
- [SHA-2 @ Wikipedia](https://en.wikipedia.org/wiki/SHA-2) - Secure Hash Algorithm 2



