class PassengerTrain < Train

def initialize(number)
  super
  @type = "пассажирский"
end

 def add_wagon(wagon)
  if wagon.class == PassengerWagon
    super
  else
    "Данный тип вагона нельзя добавить к пассажирскому поезду!"
  end
 end

end
