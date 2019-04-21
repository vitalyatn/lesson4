class CargoTrain < Train

  def initialize(number)
    super
    @type = "грузовой"
  end

  def add_wagon(wagon)
  if wagon.is_a? CargoWagon
    super
  else
    "Данный тип вагона нельзя добавить к грузовому поезду!"
  end
 end
end
