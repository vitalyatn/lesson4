require_relative "station"
require_relative "route"
require_relative "train"
require_relative "wagon"
require_relative "cargo_train"
require_relative "cargo_wagon"
require_relative "passenger_train"
require_relative "passenger_wagon"

stations = []
trains = []

loop do
puts "Выберите действие, которое вы хотите сделать
      1 - создать станции
      2 - создать поезд
      3 - назначить маршрут поезду
      4 - добавить вагоны к поезду
      5 - отцепить вагон от поезда
      6 - переместить поезд по маршруту (вперед, назад)
      7 - посмотреть список станций и список поездов на станции
      0 - выход"

act = gets.chomp.to_i

break if act == 0

case act

  when 1
    loop do
     puts "Введите название станции \n(введите 'стоп' для прекращения ввода)"
     title = gets.chomp
     break if title == "стоп"
     stations << Station.new(title)
    end

  when 2
    loop do
      puts "Какой тип поезда вы хотите создать? п - пассажирский, г -грузовой.
      Прекратиь создание поездов, наберите 'стоп' :"
      train_type = gets.chomp
      break if train_type == "стоп"
      puts "Введите номер поезда:"
      number_train = gets.chomp
      if train_type == "п"
        trains << PassengerTrain.new(number_train)
      elsif type_train == "г"
        trains << CargoTrain.new(number_train)
      else
        puts "Такой тип поезда создать невозможно!"
      end
    end

  when 3
    puts "Доступные станции:"
    stations.each {|st| puts st.title}
    puts "Выберите начальную станцию:"
    start_station = gets.chomp
    check_station?


  when 4

  when 5

  when 6

  when 7

  else
    puts "Неизвестное действие"
  end

  stations.each {|st| puts st.title}
  trains.each {|tr| puts "#{tr.number} - #{tr.type}"}
end

def check_station?
  stations.include?(start_station)
end
