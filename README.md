# Supcom2ReplayParser

Gem for parsing replays of Supreme Commander 2. It returns all info about players, map and game options from replay

___
#####Parsing Game options
    FogOfWar
    NoRushOption
    TeamSpawn
    Victory
    
#####Parsing players info
    Nickname
    Player Color
    Faction
    Team
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'supcom2_replay_parser'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install supcom2_replay_parser

## Usage

```
require 'pp'
replay_info = SupCom2ReplayParser.call(file_path)
pp replay_info

###
#{:game_version=>"Supreme Commander v1.26",
# :replay_version=>"Replay v1.9",
# :players_info=>
#  [{:nickname=>"lvl0 <| m.o.b", :color=>:orange, :faction=>:cybran, :team=>1},
#   {:nickname=>"HUECTRUM", :color=>:white, :faction=>:uef, :team=>2}],
# :game_options=>
#  {"FogOfWar"=>"explored",
#   "NoRushOption"=>"Off",
#   "TeamSpawn"=>"fixed",
#   "Victory"=>"demoralization",
#   "map"=>"[2] Spring Duel"}}
###
```

## License

[MIT License](https://opensource.org/licenses/MIT).
