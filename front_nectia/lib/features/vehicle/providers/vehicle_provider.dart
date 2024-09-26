import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../models/vehicle_model.dart';
import '../../../core/providers/dio_provider.dart';

class VehiclesData {
  final List<VehicleModel> vehicles;
  final int totalRecords;

  VehiclesData({required this.vehicles, required this.totalRecords});
}

class VehicleRepository {
  final Dio _dio;

  VehicleRepository(this._dio);

  Future<VehiclesData> fetchVehicles({
    required int page,
    required int pageSize,
    String? search,
    String? sortColumn,
    String? sortDirection,
  }) async {
    try {
      final response = await _dio.get(
        '/vehicles',
        queryParameters: {
          'limit': pageSize,
          'offset': (page - 1) * pageSize,
          if (search != null && search.isNotEmpty) 'search': search,
          if (sortColumn != null && sortDirection != null) ...{
            'sortColumn': sortColumn,
            'sortDirection': sortDirection,
          },
        },
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        final total = response.data['total'] as int;

        final vehicles =
            data.map((json) => VehicleModel.fromJson(json)).toList();
        return VehiclesData(vehicles: vehicles, totalRecords: total);
      } else {
        throw Exception('Error al obtener los vehículos');
      }
    } catch (e) {
      throw Exception('Error de red: $e');
    }
  }

  Future<void> deleteVehicle(String vehicleId) async {
    try {
      final response = await _dio.delete('/vehicles/$vehicleId');

      if (response.statusCode != 200) {
        throw Exception('Error al eliminar el vehículo');
      }
    } catch (e) {
      throw Exception('Error de red: $e');
    }
  }

  Future<void> createVehicle(VehicleModel vehicle) async {
    try {
      final response =
          await _dio.post('/vehicles', data: vehicle.toCreateJson());

      if (response.statusCode != 201) {
        throw Exception('Error al crear el vehículo');
      }
    } catch (e) {
      throw Exception('Error de red: $e');
    }
  }

  Future<void> updateVehicle(String id, VehicleModel vehicle) async {
    try {
      final response = await _dio.patch(
        '/vehicles/$id',
        data: vehicle.toCreateJson(),
      );

      if (response.statusCode != 200) {
        throw Exception('Error al actualizar el vehículo');
      }
    } catch (e) {
      throw Exception('Error de red: $e');
    }
  }
}

final vehicleRepositoryProvider = Provider<VehicleRepository>((ref) {
  final dio = ref.read(dioProvider);
  return VehicleRepository(dio);
});
