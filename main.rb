require_relative "station"
require_relative "route"
require_relative "train"
require_relative "wagon"
require_relative "cargo_train"
require_relative "cargo_wagon"
require_relative "passenger_train"
require_relative "passenger_wagon"

$stations = []
$trains = []
$routes = []
$train = nil
$route = nil
$station = nil
$wagon = nil

def check_station? (station)
  $stations.any? {|st| st.title == station}
end

def check_route? (route)
  $routes.any? do |rt|
    rt.start_station.title == route.first && rt.end_station.title == route.last
  end
end

def check_wagon? (wagon)
  $train.wagons.any? do |w|
    w.id == wagon
  end
end

def list_of_trains
  puts "Доступные поезда:"
  $trains.each {|tr| puts tr.number}
end

def list_of_stations
  puts "Доступные станции:"
  $stations.each {|st| puts st.title}
end

def list_of_routes
  puts "Доступные маршруты:"
  $routes.each do |route|
    print "#{route.start_station.title} - #{route.end_station.title} ПОЛНЫЙ МАРШРУТ:"
    route = route.stations
    route.each {|station| print "#{station.title} - "}
    puts ""
  end
end

def choose_of_train
loop do
      puts "Выберите номер поезда"
      train_number = gets.chomp
      if $trains.any? {|tr| tr.number == train_number}
        puts "Поезд номер #{train_number} выбран!"
        index_train = $trains.index {|tr| tr.number == train_number}
        $train = $trains[index_train]
        break
      else
        puts "ОШИБКА: Поезда с таким номером нет.
        \rПопробывать еще? (введите 'д' или 'н')"
        user_answer = gets.chomp
        break if user_answer == 'н'
      end
    end
end

loop do
puts "Выберите действие, которое вы хотите сделать
      1 - создать станции
      2 - создать поезд
      3 - создать маршрут
      4 - назначить маршрут поезду
      5 - добавить вагоны к поезду
      6 - отцепить вагон от поезда
      7 - переместить поезд по маршруту (вперед, назад)
      8 - посмотреть список станций и список поездов на станции
      0 - выход"

act = gets.chomp.to_i

break if act == 0

case act

  when 1
    loop do
     puts "Введите название станции
     \r(введите 'стоп' для прекращения ввода)"
     title = gets.chomp
     break if title == "стоп"
     $stations << Station.new(title)
    end

  when 2
    loop do
      puts "Какой тип поезда вы хотите создать?
      \rп - пассажирский, г -грузовой.
      \rПрекратиь создание поездов, наберите 'стоп' :"
      train_type = gets.chomp
      break if train_type == "стоп"
      puts "Введите номер поезда:"
      number_train = gets.chomp
      if train_type == "п"
        $trains << PassengerTrain.new(number_train)
      elsif train_type == "г"
        $trains << CargoTrain.new(number_train)
      else
        puts "Такой тип поезда создать невозможно!"
      end
    end

  when 3
    list_of_stations
    loop do
      puts "Выберите начальную станцию"
      start_station = gets.chomp
      puts "Выберите конечную станцию"
      end_station = gets.chomp
      if check_station?(start_station) && check_station?(end_station)
        index_start_station = $stations.index do |st|
         st.title == start_station
        end
        index_end_station = $stations.index do |st|
         st.title == end_station
        end
        start_station = $stations[index_start_station]
        end_station = $stations[index_end_station]
        $routes << Route.new(start_station,end_station)
        puts "Маршрут создан!
        \rДобавить промежуточные станции? (введите 'д' или 'н' )"
         user_answer = gets.chomp
         if user_answer == 'д'
          loop do
            puts "введите промежуточную станцию"
            middle_station = gets.chomp
            if check_station?(middle_station)
              index_middle_station = $stations.index do |st|
               st.title == middle_station
              end
              middle_station = $stations[index_middle_station]
              $routes.last.add_station(middle_station)
            else
              puts "Такой станции не существует"
            end
            puts "Добавить еще станцию? (введите 'д' или 'н')"
            user_answer = gets.chomp
            break if user_answer == 'н'
          end
        end
      else
        puts "ОШИБКА: Такой маршрут невозможно создать."
      end
      puts "Создать еще маршрут? (введите 'д' или 'н')"
      user_answer = gets.chomp
      break if user_answer == 'н'
    end

  when 4
    list_of_trains
    choose_of_train
    list_of_routes
    loop do
      puts "Выберите маршрут (напишите в формате 'начало-конец')"
      route = gets.chomp
      route = route.split('-')
      route.each {|r| puts r}
      if check_route?(route)
        index_route = $routes.index do |rt|
          rt.start_station.title == route.first && rt.end_station.title == route.last
        end
        $route = $routes[index_route]
        $train.add_route($route)
        puts "Маршрут к поезду добавлен!"
        break
      else
        puts "ОШИБКА: Такого маршрута нет
        \rПопробывать еще? (введите 'д' или 'н')"
        user_answer = gets.chomp
        break if user_answer == 'н'
      end
    end

  when 5
    list_of_trains
    choose_of_train
    # $train содержит выбранный поезд
    puts $train.class
    loop do
      puts "Укажите номер вагона"
      number_wagon = gets.chomp.to_i
      if $train.is_a? PassengerTrain
        $wagon = PassengerWagon.new(number_wagon)
      else
        $wagon = CargoWagon.new(number_wagon)
      end
      $train.add_wagon($wagon)
      puts "Добавить еще вагон? (введите 'д' или 'н')"
      user_answer = gets.chomp
      break if user_answer == 'н'
    end
   # $train.wagons.each {|w| puts w.id}

  when 6
    list_of_trains
    choose_of_train
    # $train содержит выбранный поезд
    puts "Выберите вагон, который хотите отцепить"
    $train.wagons.each {|wagon| print wagon.id.to_s + " "}
    puts ""
    wagon = gets.chomp.to_i
    if check_wagon?(wagon)
      index_wagon = $train.wagons.index do |w|
        w.id == wagon
      end
      puts index_wagon
      $wagon = $train.wagons[index_wagon]
      $train.delete_wagon($wagon)
      #$train.wagons.each {|w| puts w.id.to_s}
    end

  when 7
    list_of_trains
    choose_of_train
    # $train содержит выбранный поезд
    puts "Куда перемещаем? в-вперед, н-назад"
    move = gets.chomp
    if move == "в"
      $train.forward
    elsif move == "н"
      $train.back
    else
      puts "Неизвестное направление"
    end

  when 8
    list_of_stations
    puts "выберите станцию"
    station = gets.chomp
    if check_station?(station)
      index_station = $stations.index do |st|
        st.title == station
      end
      station = $stations[index_station]
      station.trains.each {|train| puts train.number }
    end

  else
    puts "Неизвестное действие"
  end

  #$stations.each {|st| puts st.title}
  #$trains.each {|tr| puts "#{tr.number} - #{tr.type}"}
end


