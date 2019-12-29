import java.security.MessageDigest
import java.time.Instant

class Block(
    val index: Int,
    val data: Any,
    val previousHash: String,
    var difficulty: Int = 2 // This is an example
) {
    val timestamp = Instant.now()
    val hash = computeHashWithProofOfWork()
    var nonce = 0

    fun next(data: Any) = Block(index + 1, data, hash)

    private fun computeHashWithProofOfWork(): String {
        val hashPrefix = "0".repeat(difficulty)
        fun hashWithNonce(difficulty: Int) = sha256
            .digest("$difficulty$index$timestamp$data$previousHash".toByteArray())
            .joinToString("") { "%02x".format(it) }

        for (nonce in 0..Int.MAX_VALUE) {
            val hash = hashWithNonce(nonce)
            if (hash.startsWith(hashPrefix)) {
                this.nonce = nonce
                return hash
            }
        }

        throw IllegalStateException("Unable to complete work: $this")
    }

    override fun toString(): String {
        return "Block(data=$data, hash=$hash, index=$index, difficulty=$difficulty, nonce=$nonce, previousHash=$previousHash, timestamp=$timestamp)"
    }

    companion object {
        private val sha256 = MessageDigest.getInstance("SHA-256")

        fun first(data: Any = "Genesis") = Block(0, data, "0")
    }
}

/**
 * Will pretty print (without line wrapping) something like:
 * ```
 * [Block(data=Genesis,
 *        hash=004ba69ea184a25a02a7fbfe5d9c574df925c6a65a14b0e2c14811c5a9e93997,
 *        index=0,
 *        difficulty=2,
 *        nonce=378,
 *        previousHash=0,
 *        timestamp=2019-12-29T18:51:48.763407Z),
 *  Block(data=Transaction Data...,
 *        hash=00e1bf3a24ae4f9891a78a34ac6b20681605366010cb06f15700efb205e3534e,
 *        index=1,
 *        difficulty=2,
 *        nonce=11,
 *        previousHash=004ba69ea184a25a02a7fbfe5d9c574df925c6a65a14b0e2c14811c5a9e93997,
 *        timestamp=2019-12-29T18:51:48.827031Z),
 *  Block(data=Transaction Data......,
 *        hash=00d8f64fa17057247524e2d1fb861b11e63df8b20dbd21f63129dcbd00f58809,
 *        index=2,
 *        difficulty=2,
 *        nonce=277,
 *        previousHash=00e1bf3a24ae4f9891a78a34ac6b20681605366010cb06f15700efb205e3534e, t
 *        imestamp=2019-12-29T18:51:48.827810Z),
 *  Block(data=More Transaction Data...,
 *        hash=00246f05ad6d62cbe9cac9eb09c997e9031268033556cbc75d79f0ae16400821,
 *        index=3,
 *        difficulty=2,
 *        nonce=510,
 *        previousHash=00d8f64fa17057247524e2d1fb861b11e63df8b20dbd21f63129dcbd00f58809,
 *        timestamp=2019-12-29T18:51:48.842315Z)]
 * ```
 */
val b0 = Block.first("Genesis")
val b1 = b0.next("Transaction Data...")
val b2 = b1.next("Transaction Data......")
val b3 = b2.next("More Transaction Data...")

val blockchain = listOf(b0, b1, b2, b3)

println(blockchain)
