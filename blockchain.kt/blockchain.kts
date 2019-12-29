import java.security.MessageDigest
import java.time.Instant

class Block(
    val index: Int,
    val data: Any,
    val previousHash: String
) {
    val timestamp = Instant.now()
    val hash = calcHash()

    fun next(data: Any) = Block(index + 1, data, hash)

    private fun calcHash() = sha256
        .digest("$index$timestamp$data$previousHash".toByteArray())
        .joinToString("") { "%02x".format(it) }

    override fun toString(): String {
        return "Block(data=$data, hash=$hash, index=$index, previousHash=$previousHash, timestamp=$timestamp)"
    }

    companion object {
        private val sha256 = MessageDigest.getInstance("SHA-256")

        fun first(data: Any = "Genesis") = Block(0, data, "0")
    }
}

/*
 * Will pretty print (without line wrapping) something like:
 * ```
 * [Block(data=Genesis,
 *        hash=8145610a47769c76136d0c844d1e88d9782e1d8bfcae74314e472ca0ac25d684,
 *        index=0,
 *        previousHash=0,
 *        timestamp=2019-12-29T16:17:21.805435Z),
 *  Block(data=Transaction Data...,
 *        hash=08b138384bc2645272de76a060b19d2b2dee8d87208a872bfd859b9fe9333370,
 *        index=1,
 *        previousHash=8145610a47769c76136d0c844d1e88d9782e1d8bfcae74314e472ca0ac25d684,
 *        timestamp=2019-12-29T16:17:21.837617Z),
 *  Block(data=Transaction Data......,
 *        hash=1cce7b717ca1409cbded1d9dd7d2475dd99de515676d2842b1e2592324772053,
 *        index=2,
 *        previousHash=08b138384bc2645272de76a060b19d2b2dee8d87208a872bfd859b9fe9333370,
 *        timestamp=2019-12-29T16:17:21.838652Z),
 *  Block(data=More Transaction Data...,
 *        hash=e5723ab31156e91d27db8ad4441a29f3ecfd9cda3e91284bd5d583bed8e91212,
 *        index=3,
 *        previousHash=1cce7b717ca1409cbded1d9dd7d2475dd99de515676d2842b1e2592324772053,
 *        timestamp=2019-12-29T16:17:21.839509Z)]
 * ```
 */

val b0 = Block.first("Genesis")
val b1 = b0.next("Transaction Data...")
val b2 = b1.next("Transaction Data......")
val b3 = b2.next("More Transaction Data...")

val blockchain = listOf(b0, b1, b2, b3)

println(blockchain)
