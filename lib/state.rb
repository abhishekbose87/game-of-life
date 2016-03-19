class Cell

  class State

    def dead?
      !alive?
    end

  end


  class Alive < State

    def alive?
      true
    end

    def value
      '1'
    end

    def becomes_dead?(alive_neighbours_count)
      !([2, 3].include? alive_neighbours_count)
    end

    def toggle
      Dead.new
    end

  end

  class Dead < State

    def alive?
      false
    end

    def value
      '0'
    end

    def becomes_alive?(alive_neighbours_count)
      3 == alive_neighbours_count
    end

    def toggle
      Alive.new
    end

  end

end
