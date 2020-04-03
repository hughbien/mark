require "./mark/**"

module Mark
  VERSION = {{ `shards version "#{__DIR__}"`.chomp.stringify }}
end
