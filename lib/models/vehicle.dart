class VehicleModel {
  final String id;
  final String name;
  final String model;
  final String engine;
  final String milage;
  final String color;
  final int rides; //rides with this car

  VehicleModel(
      {required this.id,
      required this.name,
      required this.model,
      required this.engine,
      required this.milage,
      required this.color,
      required this.rides});
}
