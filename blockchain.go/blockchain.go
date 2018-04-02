/////
// build your own blockchain from scratch in go(lang)
//
//  references:
//  - https://jeiwan.cc/posts/building-blockchain-in-go-part-1/
//  - and (many) others


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


func calcHash( data string ) string {
  h := sha256.New()
  h.Write( []byte(data) )
  hashed := h.Sum(nil)
  return hex.EncodeToString(hashed)
}


func NewBlock(data string, prev string) Block {
  t    := time.Now().Unix()
  hash := calcHash( strconv.FormatInt(t,10) + prev + data )

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
