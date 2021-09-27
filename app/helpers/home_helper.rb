module HomeHelper
    def coordinate_options
        (0..4).inject([]) {|acc, val| acc << [val, val]; acc;}
    end

    def direction_options
        [
            ['North', 'NORTH'],
            ['East', 'EAST'],
            ['West', 'WEST'],
            ['South', 'SOUTH']
        ]
    end
end
