import 'package:front_nectia/features/vehicle/models/vehicle_model.dart';

class VehiclesData {
  final List<VehicleModel> vehicles;
  final int totalRecords;

  VehiclesData({required this.vehicles, required this.totalRecords});
}