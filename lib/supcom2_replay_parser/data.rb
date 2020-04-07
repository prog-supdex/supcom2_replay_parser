module SupCom2ReplayParser
  module Data
    FACTIONS = {
      "@@"           => :illuminate,
      "\u0000@"      => :cybran,
      "\u0080?"      => :uef
    }.freeze

    COLORS = {
      "@@"           => :purple,
      "\u0000@"      => :red,
      "\u00A0@"      => :white,
      "\u0080?"      => :green,
      "\u0000\u0000" => :blue,
      "\u0010A"      => :orange,
      "\u0000A"      => :yellow,
      "\u00E0@"      => :turquoise,
      "\u00C0@"      => :khaki,
      "\u0080@"      => :brown
    }.freeze

    TEAMS = {
      "\u0000@"      => 1,
      "@@"           => 2,
      "\u0080@"      => 3,
      "\u00A0@"      => 4,
      "\u00C0@"      => 5,
      "\u00E0@"      => 6,
      "\u0000A"      => 7,
      "\u0010A"      => 8
    }
  end
end
