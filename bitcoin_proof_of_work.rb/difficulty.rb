###
#   type to run:
#     $ ruby ./difficulty.rb


p targetmax = 0x00000000ffff0000000000000000000000000000000000000000000000000000
#=> 26959535291011309493156476344723991336010898738574164086137773096960


###################
#  block 100,000   mined on Dec/29, 2010

p difficulty = 14484.162361

p target = targetmax / difficulty
#=> 1.8613113150127653e+63   -- 1861311315012765306929610463010191006516769515973403833769533170


###################
#  block 500,000   mined on Dec/1, 2017

p difficulty = 1873105475221.6

p target = targetmax / difficulty
#=> 1.4392961660539606e+55   -- 14392961660539606926930209015440658523615307253181250777


#####################
#  use all integer calculations with scale factor (1,000,000)

p difficulty = 14484.162361
p difficulty = (14484.162361*1000000).to_i
#=> 14484162361

p target = (targetmax*1000000) / difficulty
#=> 1861311315012765306929610463010191006516769515973403833769533170


####################
#  difficulty to target helper

def difficulty_to_target( difficulty, scale: )
  factor    = 10**scale

  targetmax = 0x00000000ffff0000000000000000000000000000000000000000000000000000
  targetmax = targetmax*factor

  p difficulty
  p difficulty = (difficulty*factor).to_i  ## convert to integer (with scale factor)

  target = targetmax / difficulty
  target
end


p target100_000 = difficulty_to_target( 14484.162361, scale: 6 )
#=> 1861311315012765306929610463010191006516769515973403833769533170
p target500_000 = difficulty_to_target( 1873105475221.6, scale: 1 )
#=> 14392961660539606926930209015440658523615307253181250777

###########
# block 614,190   minded on Jan/23, 2020

p target614_190 = difficulty_to_target( 14776367535688.64, scale: 2 )
# => 1824503568004603193303406580546152706967274020126640041




##############################################
# print block targets in hex and log2

p '%064x' % target100_000
#=> "000000000004864c00004d6ac7cd33f734b8eb28b24729fe151953ec57a21ef2"
p '%064x' % target500_000
#=> "000000000000000000964500000000fc2cc6932cfb3a8ff7cbbf47bd8e22fcd9"
p '%064x' % target614_190
#=> "000000000000000000130c77ffffffffccc21951757a6bc6d24a653f04e4c7a9"

p Math.log2( targetmax )
#=> 223.99997798605273
p Math.log2( target100_000 )
#=> 210.17778935251798
p Math.log2( target500_000 )
#=> 183.2314087068759
p Math.log2( target614_190 )
#=> 180.25162109618142
