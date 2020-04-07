module SupCom2ReplayParser
  module PlayersInfo
    extend self

    PLAYERS_FIELDS = %w[
      PlayerName
      PlayerColor
      Faction
      Team
    ].freeze

    def call(line)
      prepare_data(line.scan(/(?:#{PLAYERS_FIELDS.join('|')})+[[:cntrl:]]{2}[^[[:cntrl:]]]{0,}[^\u{ 1 }]+/))
    end

    private

    def prepare_data(data)
      data = data.each_slice(PLAYERS_FIELDS.size).to_a

      data.each_with_object([]) do |elements, acum|
        player = {}

        elements.each do |element|
          if element.start_with?('PlayerName')
            player[:nickname] = element.encode('iso-8859-1').force_encoding('utf-8').gsub(/[[:cntrl:]]|PlayerName/, '')
          elsif element.start_with?('PlayerColor')
            player[:color] = Data::COLORS[element[-2..-1]]
          elsif element.start_with?('Faction')
            player[:faction] = Data::FACTIONS[element[-2..-1]]
          elsif element.start_with?('Team')
            player[:team] = Data::TEAMS[element[-2..-1]]
          end
        end

        acum << player
      end
    end
  end
end
