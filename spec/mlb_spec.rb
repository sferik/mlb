require 'helper'

describe MLB::Team, '.all' do
  after do
    described_class.reset
  end
  subject do
    described_class.all
  end
  it 'there are thirty teams' do
    expect(subject.size).to eq 30
  end
  it 'teams are sorted alphabetically, by name' do
    # Arizona Diamondbacks..Washington Nationals
    expect(subject).to eq subject.sort_by(&:name)
  end
  it 'every team belongs to a league' do
    subject.each do |team|
      expect(team.league).to match(/^(American|National|Major) League( Baseball)?$/)
    end
  end
  it 'every team belongs to a division' do
    subject.each do |team|
      expect(team.division).to match(/^(American|National) League (East|Central|West)$/)
    end
  end
  it 'every team has win and loss statistics' do
    subject.each do |team|
      expect(team.wins).to be_between(0, 162), "got: #{team.wins} for #{team.name}"
      expect(team.losses).to be_between(0, 162), "got: #{team.losses} for #{team.name}"
      games = team.wins + team.losses
      # Allow up to 163 total games, since there may be a tie-breaking game
      expect(games).to be <= 163, "got: #{games} for #{team.name}"
    end
  end
  it 'every team has a founding year' do
    subject.each do |team|
      # Chicago Cubs..Washington Nationals
      expect(team.founded).to be_between(1870, 2005), "got: #{team.founded} for #{team.name}"
    end
  end
  it 'every team has a ballpark' do
    subject.each do |team|
      expect(team.ballpark).to match(/(Ballpark|Centre|Coliseum|Field|Park|Stadium)( (at|in|of) .+)?$/)
    end
  end
  it 'every team has a 25-player roster' do
    subject.each do |team|
      expect(team.players.size).to be >= 25, "got: #{team.players.size} for #{team.name}"
    end
  end
  it 'every player has a first and last name' do
    subject.each do |team|
      team.players.each do |player|
        expect(player.name.size).to be >= 7, "got: #{player.name.size} for #{player.name}"
        expect(player.name.split.size).to be >= 2, "got: #{player.name.split.size} for #{player.name}"
      end
    end
  end
  it 'every player has a one- or two-digit number' do
    subject.each do |team|
      team.players.each do |player|
        expect(player.number).to be_between(0, 99), "got: #{player.number} for #{player.name}"
        # Jackie Robinson
        expect(player.number).not_to eq(42), "got: #{player.number} for #{player.name}"
      end
    end
  end
  it 'every player has at least one position' do
    subject.each do |team|
      team.players.each do |player|
        pending 'Some players do not have a position'
        expect(player.positions.size).to be >= 1, "got: #{player.positions.size} for #{player.name}"
      end
    end
  end
  it 'every player has a starting year' do
    subject.each do |team|
      team.players.each do |player|
        pending 'Some players do not have a starting year'
        expect(player.from).to be >= 1995, "got: #{player.from} for #{player.name}"
      end
    end
  end
  it 'every player is active' do
    subject.each do |team|
      team.players.each do |player|
        expect(player.to).to eq('Present'), "got: #{player.to} for #{player.name}"
      end
    end
  end
end
