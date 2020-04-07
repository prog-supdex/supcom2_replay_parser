require 'supcom2_replay_parser/version'
require 'supcom2_replay_parser/data'
require 'supcom2_replay_parser/game_options'
require 'supcom2_replay_parser/players_info'

module SupCom2ReplayParser
  extend self

  ALLOWED_EXTENSION = '.SC2ReplayDLC'

  def call(filepath)
    raise Exception, "Allowed only files with extension #{ALLOWED_EXTENSION}" unless allow_file_extension?(filepath)

    replay_info = {}

    file_lines = File.new(filepath, encoding: 'ISO-8859-1:UTF-8')

    file_lines.each do |line|
      current_line = file_lines.lineno

      if current_line == 1
        replay_info[:game_version] = line.sub(/[[:cntrl:]]/, '').chomp
      end

      if current_line == 2
        replay_info[:replay_version] = line.sub(/[[:cntrl:]]/, '').chomp
      end

      if current_line == 4 || current_line == 5
        next if !has_line_full_needed_data?(line) && current_line == 4

        raise Exception, 'Replay is broken' unless has_line_full_needed_data?(line)

        replay_info.merge!({
          players_info: PlayersInfo.call(line),
          game_options: GameOptions.call(line)
        })

        break
      end
    end

    raise Exception, 'Replay is broken' if replay_info.empty?

    replay_info
  end

  private

  def has_line_full_needed_data?(line)
    line.match?(/(#{GameOptions::FIELDS.join('|')})/)
  end

  def allow_file_extension?(file)
    File.extname(file) == ALLOWED_EXTENSION
  end
end
