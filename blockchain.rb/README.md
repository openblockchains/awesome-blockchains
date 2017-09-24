# blockchain.rb - Build your own blockchain from scratch in 20 lines of ruby

inspired by
[Let's Build the Tiniest Blockchain In Less Than 50 Lines of Python](https://medium.com/crypto-currently/lets-build-the-tiniest-blockchain-e70965a248b)
by Gerald Nash


**Starter (Version)**

to run use:

    $ ruby ./blockchain.rb


**Proof of Work (Version)**

to run use:

    $ ruby ./blockchain_with_proof_of_work.rb


**Transactions (Version)**

to run use:

    $ ruby ./blockchain_with_transactions.rb




## Questions? Comments?

From the [reddit ruby posting](https://www.reddit.com/r/ruby/comments/70c30f/build_your_own_blockchain_in_20_lines_of_ruby/):

> Wait, so a blockchain is just a linked list?
>
>> No. A linked list is only required to have a reference to the previous element, a block must
>> have an identifier depending on the previous block's identifier, meaning that you cannot
>> replace a block without recomputing every single block that comes after.
>> In this implementation that happens as the previous digest is input in the calc_hash method.

---

> This is a "blockchain" in only the most literal sense of the word.
>
>> That's the best sense of the word.
>>
>>> No, this ruby class misses the whole point...
>>> a distributed data structure built by independent actors all putting in real work
>>> and receiving rewards for successfully solving the next block.
>>>
>>>> While you're on to the fact that blockchain is not quite as interesting without proof of
>>>> work, those are two totally independent concepts, and one is not needed to illustrate the
>>>> other.



## Alternatives

[blockchain.rb](https://github.com/MatiasFMolinari/blockchain-ruby) by Matias Fernandez -- It's 8 lines, but that's because I removed the class methods.
