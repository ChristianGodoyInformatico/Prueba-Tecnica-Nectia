import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../models/vehicle_model.dart';
import '../providers/vehicle_provider.dart';

class VehicleDataSource extends DataGridSource {
  final VehicleRepository repository;
  final Function(VehicleModel) onDeleteVehicle;
  final Function(VehicleModel) onEditVehicle;
  final int pageSize;
  final String? searchQuery;

  int _currentPage = 1;
  int _totalRecords = 0;
  List<VehicleModel> _vehicles = [];

  String? _sortColumn;
  DataGridSortDirection? _sortDirection;

  VehicleDataSource({
    required this.repository,
    required this.onDeleteVehicle,
    required this.onEditVehicle,
    required this.pageSize,
    required this.searchQuery,
  }) {
    _loadData();
  }

  int get totalRecords => _totalRecords;

  @override
  List<DataGridRow> get rows => _dataGridRows;
  List<DataGridRow> _dataGridRows = [];

  Future<void> _loadData() async {
    try {
      final sortDirectionString =
          _sortDirection == DataGridSortDirection.ascending ? 'asc' : 'desc';

      final vehiclesData = await repository.fetchVehicles(
        page: _currentPage,
        pageSize: pageSize,
        search: searchQuery,
        sortColumn: _sortColumn,
        sortDirection: sortDirectionString,
      );
      _vehicles = vehiclesData.vehicles;
      _totalRecords = vehiclesData.totalRecords;

      _buildDataGridRows();
      notifyListeners();
    } catch (e) {
      _vehicles = [];
      _totalRecords = 0;
      _buildDataGridRows();
      notifyListeners();
    }
  }

  void _buildDataGridRows() {
    _dataGridRows = _vehicles
        .map<DataGridRow>((vehicle) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'brand', value: vehicle.brand),
              DataGridCell<String>(columnName: 'model', value: vehicle.model),
              DataGridCell<int>(columnName: 'year', value: vehicle.year),
              DataGridCell<double>(columnName: 'price', value: vehicle.price),
              DataGridCell<String>(columnName: 'type', value: vehicle.type),
              DataGridCell<VehicleModel>(columnName: 'actions', value: vehicle),
            ]))
        .toList();
  }

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    _currentPage = newPageIndex + 1;
    await _loadData();
    return true;
  }

  @override
  void sort() {
    sortedColumns.clear();

    if (_sortColumn != null && _sortDirection != null) {
      sortedColumns.add(
        SortColumnDetails(
          name: _sortColumn!,
          sortDirection: _sortDirection!,
        ),
      );
    }

    _currentPage = 1;
    _loadData();
  }

  void updateSorting(String columnName, DataGridSortDirection direction) {
    _sortColumn = columnName;
    _sortDirection = direction;
    sort();
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    final vehicle = row
        .getCells()
        .firstWhere((cell) => cell.columnName == 'actions')
        .value as VehicleModel;

    return DataGridRowAdapter(cells: [
      // Marca
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(row.getCells()[0].value.toString()),
      ),
      // Modelo
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(row.getCells()[1].value.toString()),
      ),
      // Año
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(row.getCells()[2].value.toString()),
      ),
      // Precio
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text('\$${row.getCells()[3].value.toStringAsFixed(2)}'),
      ),
      // Tipo
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(row.getCells()[4].value.toString()),
      ),
      // Acciones
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                onEditVehicle(vehicle);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                onDeleteVehicle(vehicle);
              },
            ),
          ],
        ),
      ),
    ]);
  }
}
