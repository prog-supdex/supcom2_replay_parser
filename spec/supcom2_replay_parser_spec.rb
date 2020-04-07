RSpec.describe SupCom2ReplayParser do
  let(:file_path_with_wrong_ext) { 'spec/fixtures/files/replay.txt' }
  let(:file_path_with_empty_content) { 'spec/fixtures/files/replay_fake.SC2ReplayDLC' }

  it 'reads replay file' do
    data = described_class.call('spec/fixtures/files/replay.SC2ReplayDLC')

    expect(data[:game_options]).to eq(
      {
        'FogOfWar' => 'none',
        'NoRushOption' => '10',
        'AllowObservers' => '',
        'TeamSpawn' => 'fixed',
        'Victory' => 'demoralization',
        'map' => '[2] Spring Duel'
      }
    )

    expect(data[:players_info]).to eq(
      [
        { nickname: 'lvl0 <| m.o.b', color: :red, faction: :uef, team: 1 },
        { nickname: 'Maxabillion', color: :purple, faction: :illuminate, team: 2 }
      ]
    )
  end

  it 'reads replay with data in five line' do
    data = described_class.call('spec/fixtures/files/replay_with_five_line.SC2ReplayDLC')

    expect(data[:game_options]).to eq(
      {
        'FogOfWar' => 'none',
        'NoRushOption' => '10',
        'AllowObservers' => '',
        'TeamSpawn' => 'fixed',
        'Victory' => 'demoralization',
        'map' => '[2] Spring Duel'
      }
    )

    expect(data[:players_info]).to eq(
      [
        { nickname: 'lvl0 <| m.o.b', color: :red, faction: :uef, team: 1 },
        { nickname: 'Maxabillion', color: :purple, faction: :illuminate, team: 2 }
      ]
    )
  end

  it 'raises exception "Replay is broken"' do
    io = StringIO.new
    io.puts "\t\n\t\n\t\n"

    allow(File).to receive(:new).with(file_path_with_empty_content, { encoding: 'ISO-8859-1:UTF-8' }).and_return(io)

    expect{ described_class.call(file_path_with_empty_content) }.to raise_error('Replay is broken')
  end

  it 'raises exception "Allowed only files with extension .SC2ReplayDLC"' do
    allow(File).to receive(:new).with(file_path_with_wrong_ext, { encoding: 'ISO-8859-1:UTF-8' })

    expect{ described_class.call(file_path_with_wrong_ext) }.to raise_error('Allowed only files with extension .SC2ReplayDLC')
  end
end
