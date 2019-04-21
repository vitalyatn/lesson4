class PassengerTrain < Train

def initialize(number)
  super
  @type = "пассажирский"
end

 def add_wagon(wagon)
  if wagon.is_a? PassengerWagon
    super
  else
    "Данный тип вагона нельзя добавить к пассажирскому поезду!"
  end
 end

end
