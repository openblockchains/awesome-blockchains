###
#   type to run:
#     $ ruby ./hashrate.rb

require "digest"

def sha256( msg )
  Digest::SHA256.hexdigest( msg )
end



#################
# Let's calculate 10 million, that is, 10 000 000 hashes.
#    e.g. "Hello, world!0"
#         "Hello, world!1"
#         "Hello, world!2"
#         "Hello, world!3"
#         and on and on and on

t1 = Time.now
10_000_000.times do |i|
  sha256( "Hello, world!#{i}")

  # bonus: print a dot (.) for progress for every one hundred thousand hashes calculated
  print "."    if i % 100_000 == 0
end
t2 = Time.now

delta = t2 - t1
puts ""
puts "Elapsed Time: %.4f seconds" % delta

hashrate = Float( 10_000_000 / delta )
puts "Hash Rate: %d hashes/second" % hashrate
