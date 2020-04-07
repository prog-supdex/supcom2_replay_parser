module SupCom2ReplayParser
  module GameOptions
    FIELDS = %w[
      FogOfWar
      NoRushOption
      TeamSpawn
      Victory
    ].freeze

    def self.call(line)
      options = Hash[line.scan(/(#{FIELDS.join('|')})+\0{1}\u{ 3 }{0,1}\u{ 1 }{1}([^[[:cntrl:]]]{0,})[[:cntrl:]]{1}/)]

      options.merge!('map' => line.scan(/name+[[:cntrl:]]{2}<{1}[^[[:cntrl:]]]+>{1}([^[[:cntrl:]]]+)[[:cntrl:]]{1}/).to_a.dig(-1, 0))
    end
  end
end
