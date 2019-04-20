class Train

  attr_reader :speed, :wagons, :type, :number

  def initialize(number)
    @number = number
    @speed = 0
    @wagons = []
   end

  def speed_up
    @speed += 10
  end

  def stop
    @speed = 0
  end

  def add_wagon(wagon)
    if @speed.zero?
      @wagons << wagon
    else
      puts "Прицепить вагон нельзя! Остановите поезд!"
    end
  end

  def delete_wagon(wagon)
    if @speed.zero?
      @wagons.delete_if {|wagon_delete| wagon_delete == wagon }
    else
      puts "Отцепить вагон нельзя! Остановите поезд!"
    end
  end

  def add_route(route)
    @route = route
    @station_index = 0
    curr_station.add_train(self)
  end

  def forward
    if next_station
      curr_station.delete_train(self)
      next_station.add_train(self)
      @station_index += 1
    else
      puts "Двигаться некуда!"
    end
  end

  def back
    if @station_index.positive?
      curr_station.delete_train(self)
      prev_station.add_train(self)
      @station_index -= 1
    else
      puts "Двигаться некуда!"
    end
  end

  def next_station
    @route.stations[@station_index + 1]
  end

  def prev_station
    @route.stations[@station_index - 1]
  end

  def curr_station
    @route.stations[@station_index]
  end

end
