package main

import(
  "fmt"
  "crypto/sha256"
  "strings"
  "time"
  "encoding/hex"
  "strconv"
)



func binToHex( bytes []byte ) string {
	return hex.EncodeToString( bytes )
}

func int64ToStr( num int64 ) string {
  return strconv.FormatInt( num, 10 )
}



func calcHash( data string ) string {
  hashed := sha256.Sum256( []byte(data) )
  return binToHex( hashed[:] )   // note: use [:] to convert [32]byte to slice ([]byte)
}

func computeHashWithProofOfWork( data string, difficulty string ) (int64,string) {
  nonce := int64( 0 )
  for {
    hash := calcHash( int64ToStr(nonce) + data )

    if strings.HasPrefix( hash, difficulty ) {
        return nonce,hash    // bingo! proof of work if hash starts with leading zeros (00)
    } else {
        nonce += 1           // keep trying (and trying and trying)
    }
  }
}



func main() {

  factors := []int{1,2,3,4,5,6}   // add 7 (~10 mins)

  for _, factor := range factors {
     difficulty := strings.Repeat( "0", factor )
     fmt.Printf( "Difficulty: %s (%d bits)\n", difficulty, len(difficulty)*4 )
  }


  for _, factor := range factors {
     difficulty := strings.Repeat( "0", factor )
     fmt.Printf( "\nDifficulty: %s (%d bits)\n", difficulty, len(difficulty)*4 )

     fmt.Println( "Starting search..." )
     t1 := time.Now()
     nonce, _ := computeHashWithProofOfWork( "Hello, Cryptos!", difficulty )
     t2 := time.Now()

     delta := t2.Sub( t1 )
     fmt.Printf( "Elapsed Time: %s, Hashes Calculated: %d\n", delta, nonce )

     if delta.Seconds() > 0.001 {
       hashrate := float64(nonce)/delta.Seconds()
       fmt.Printf( "Hash Rate: %d hashes per second\n", int64(hashrate))
     }
  }
}


// Difficulty: 0 (4 bits)
// Difficulty: 00 (8 bits)
// Difficulty: 000 (12 bits)
// Difficulty: 0000 (16 bits)
// Difficulty: 00000 (20 bits)
// Difficulty: 000000 (24 bits)
//
// Difficulty: 0 (4 bits)
// Starting search...
// Elapsed Time: 0s, Hashes Calculated: 56
//
// Difficulty: 00 (8 bits)
// Starting search...
// Elapsed Time: 1.0001ms, Hashes Calculated: 143
// Hash Rate: 142985 hashes per second
//
// Difficulty: 000 (12 bits)
// Starting search...
// Elapsed Time: 5.0002ms, Hashes Calculated: 3834
// Hash Rate: 766769 hashes per second
//
// Difficulty: 0000 (16 bits)
// Starting search...
// Elapsed Time: 33.0019ms, Hashes Calculated: 26762
// Hash Rate: 810923 hashes per second
//
// Difficulty: 00000 (20 bits)
// Starting search...
// Elapsed Time: 137.0078ms, Hashes Calculated: 118592
// Hash Rate: 865585 hashes per second
//
// Difficulty: 000000 (24 bits)
// Starting search...
// Elapsed Time: 26.5378148s, Hashes Calculated: 21554046
// Hash Rate: 812201 hashes per second
