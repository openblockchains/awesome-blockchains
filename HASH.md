

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

Articles:

- [Secure Hash Algorithms @ Wikipedia](https://en.wikipedia.org/wiki/Secure_Hash_Algorithms)
- [SHA-2 @ Wikipedia](https://en.wikipedia.org/wiki/SHA-2) - Secure Hash Algorithm 2



