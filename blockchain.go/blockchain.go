/////
// build your own blockchain from scratch in go(lang)
//
//  references:
//  - https://jeiwan.cc/posts/building-blockchain-in-go-part-1/
//  - https://jeiwan.cc/posts/building-blockchain-in-go-part-2/
//  - https://medium.com/@mycoralhealth/code-your-own-blockchain-in-less-than-200-lines-of-go-e296282bcffc
//  - https://medium.com/@mycoralhealth/code-your-own-blockchain-mining-algorithm-in-go-82c6a71aba1f
//  - and (many) others
//
//
//  to run use:
//    $ go run blockchain.go


package main

import (
  "fmt"
  "crypto/sha256"
  "encoding/hex"
  "time"
  "strconv"
)

type Block struct {
  Time          int64       // seconds since (unix) epoch (1970-01-01)
  Data          string
  Prev          string      // use []byte/int256/uint256 ??
  Hash          string      // use []byteint256/uint256 ??
}


// bin(ary) bytes and integer number to (conversion) string helpers
func binToStr( bytes []byte ) string {
  return hex.EncodeToString( bytes )
}

func intToStr( num int64 ) string {
  return strconv.FormatInt( num, 10 )
}


func calcHash( data string ) string {
  hashed := sha256.Sum256( []byte(data) )
  return binToStr( hashed[:] )   // note: [:] converts [32]byte to []byte
}


func NewBlock(data string, prev string) Block {
  t    := time.Now().Unix()
  hash := calcHash( intToStr(t) + prev + data )

  return Block { t, data, prev, hash }
}


func main() {
  b0 := NewBlock( "Hello, Cryptos!", "0000000000000000000000000000000000000000000000000000000000000000" )
  b1 := NewBlock( "Hello, Cryptos! - Hello, Cryptos!", b0.Hash )

  fmt.Println( b0 )
  // {1522687834 Hello, Cryptos!
  //    0000000000000000000000000000000000000000000000000000000000000000
  //    d85da0f449ff9ddc2c5ba638b23b9524381811227eb463b8c9e0be40dc1b1a8a}
  fmt.Println( len( b0.Hash ))
  // => 64
  fmt.Println( len( b0.Prev ))
  // => 64

  fmt.Println( b1 )
  // {1522687834 Hello, Cryptos! - Hello, Cryptos!
  //     d85da0f449ff9ddc2c5ba638b23b9524381811227eb463b8c9e0be40dc1b1a8a
  //     e48ba730165d88e15435483fc3a60714be526096a0c9a71ad10623340e33c7e3}
  fmt.Println( len( b1.Hash ))
  // => 64
  fmt.Println( len( b1.Prev ))
  // => 64

  blockchain := []Block {b0, b1}
  fmt.Println( blockchain )
  // => [{1522687834 Hello, Cryptos!
  //           0000000000000000000000000000000000000000000000000000000000000000
  //           d85da0f449ff9ddc2c5ba638b23b9524381811227eb463b8c9e0be40dc1b1a8a}
  //     {1522687834 Hello, Cryptos! - Hello, Cryptos!
  //           d85da0f449ff9ddc2c5ba638b23b9524381811227eb463b8c9e0be40dc1b1a8a
  //           e48ba730165d88e15435483fc3a60714be526096a0c9a71ad10623340e33c7e3}]
}
