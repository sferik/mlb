require 'faraday'

module MLB
  class Team
    attr_reader :name, :league, :division, :manager, :wins, :losses, :founded, :mascot, :ballpark, :logo_url, :players

    # Returns an array of Team objects
    #
    # @example
    #   MLB::Team.all.first.name                    # => "Arizona Diamondbacks"
    #   MLB::Team.all.first.league                  # => "National League"
    #   MLB::Team.all.first.division                # => "National League West"
    #   MLB::Team.all.first.manager                 # => "Bob Melvin"
    #   MLB::Team.all.first.wins                    # => 82
    #   MLB::Team.all.first.losses                  # => 80
    #   MLB::Team.all.first.founded                 # => 1998
    #   MLB::Team.all.first.mascot                  # => nil
    #   MLB::Team.all.first.ballpark                # => "Chase Field"
    #   MLB::Team.all.first.logo_url                # => "http://img.freebase.com/api/trans/image_thumb/wikipedia/images/en_id/13104064"
    #   MLB::Team.all.first.players.first.name      # => "Alex Romero"
    #   MLB::Team.all.first.players.first.number    # => 28
    #   MLB::Team.all.first.players.first.position  # => "Right fielder"
    def self.all
      # Attempt to read the from the cached fixture file.
      # If it doesn't work, load it from the repository.
      @all ||= results_to_team(results_from_cache || results_from_source)
    end

    def self.reset
      @all = nil
    end

  private

    def initialize(attributes = {})
      attributes.each do |key, value|
        instance_variable_set("@#{key}", value) if self.respond_to?(key)
      end
    end

    def self.cache_dirs
      [
       "#{Dir.pwd}/tmp/cache",
       "#{Dir.pwd}/cache",
       File.expand_path('../../../cache', __FILE__),
      ]
    end

    def self.results_from_cache
      data = nil
      cache_dirs.each do |dir|
        begin
          data = JSON.load(file_from_cache(dir, 'teams.json').read)
        rescue
        end
        break if data
      end
      data
    end

    def self.file_from_cache(cache_dir, file_name)
      File.new(cache_dir + '/' + file_name)
    end

    def self.results_from_source
      # Write the results to cache to avoid abuse of the source service.
      results = load_results_from_source
      cache_dirs.each do |dir|
        file = "#{dir}/teams.json"
        next unless File.writable?(file) || (!File.exist?(file) && File.writable?(dir))
        begin
          File.write(file, results)
          break
        rescue
        end
      end
      results
    end

    def self.load_results_from_source
      connection = Faraday.new('https://raw.githubusercontent.com') do |conn|
        conn.use FaradayMiddleware::ParseJson
        conn.adapter Faraday.default_adapter
      end
      connection.get('/sferik/mlb/e5b9384fc388f34ec5baca291343864135dcb0fe/cache/teams.json').body
    end

    def self.results_to_team(results) # rubocop:disable AbcSize, CyclomaticComplexity, MethodLength, PerceivedComplexity
      results['result'].map do |result|
        league      = result['league']
        division    = result['division']
        manager     = result['current_manager']
        stats       = result['team_stats'].first
        founded     = result['/sports/sports_team/founded'].first
        mascot      = result['/sports/sports_team/team_mascot'].first
        ballpark    = result['/sports/sports_team/arena_stadium'].first
        logo_prefix = 'http://img.freebase.com/api/trans/image_thumb'
        logo_suffix = result['/common/topic/image'].first
        players     = result['/sports/sports_team/roster']

        new(:name     => result['name'],
            :league   => (league ? league['name'] : nil),
            :division => (division ? division['name'] : nil),
            :manager  => (manager ? manager['name'] : nil),
            :wins     => (stats ? stats['wins'].to_i : nil),
            :losses   => (stats ? stats['losses'].to_i : nil),
            :founded  => (founded ? founded['value'].to_i : nil),
            :mascot   => (mascot ? mascot['name'] : nil),
            :ballpark => (ballpark ? ballpark['name'] : nil),
            :logo_url => (logo_suffix ? logo_prefix + logo_suffix['id'] : nil),
            :players  => (players ? Player.all_from_roster(players) : []))
      end
    end
  end
end
