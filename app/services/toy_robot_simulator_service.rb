class ToyRobotSimulatorService
    TABLE_MATRIX = Matrix.build(5, 5).to_a
    DIRECTIONS = { north: "NORTH", east: "EAST", west: "WEST", south: "SOUTH" }
    COMMANDS = { move: "MOVE", left: "LEFT", right: "RIGHT" }

    attr_accessor :latitude, :longitude, :direction
    attr_reader :commands

    def initialize(input = { latitude: 0, longitude: 0, direction: 'NORTH', commands: ['MOVE'] })
        @latitude = input[:latitude]
        @longitude = input[:longitude]
        @direction = input[:direction]
        @commands = input[:commands]
    end

    # calculate
    def calculate
        commands.each do |command|
            command == COMMANDS[:move] ? move : rotate(command)
            return false unless valid_move?
        end
        return valid_move?
    end

    # update value of either latitude or longitude
    def move
        case direction
        when DIRECTIONS[:north]
            self.longitude += 1
        when DIRECTIONS[:south]
            self.longitude -= 1
        when DIRECTIONS[:east]
            self.latitude += 1
        when DIRECTIONS[:west]
            self.latitude -= 1
        end

        return [latitude, longitude]
    end

    # update the value of direction
    def rotate(command = "LEFT")
        self.direction = case direction
            when DIRECTIONS[:north]
                command == "LEFT" ? DIRECTIONS[:west] : DIRECTIONS[:east]
            when DIRECTIONS[:south]
                command == "LEFT" ? DIRECTIONS[:east] : DIRECTIONS[:west]
            when DIRECTIONS[:east]
                command == "LEFT" ? DIRECTIONS[:north] : DIRECTIONS[:south]
            when DIRECTIONS[:west]
                command == "LEFT" ? DIRECTIONS[:south] : DIRECTIONS[:north]
            end
        return direction
    end

    # check for valid moves
    def valid_move?
        TABLE_MATRIX.include? [latitude, longitude]
    end

    def output
        "#{latitude}, #{longitude}, #{direction}"
    end
end
