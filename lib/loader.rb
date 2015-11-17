require 'json'

module MapLoader
  def self.load(map_name, board)
    map_data = File.read("maps/#{map_name}.json")
    map_data = JSON.parse(map_data, symbolize_names: true)

    map_data[:humans].each { |x, y| board.add_piece Human.new(x, y) }
  end
end
