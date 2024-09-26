import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_nectia/features/views.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../models/vehicle_model.dart';
import '../providers/vehicle_provider.dart';

class VehiclesScreen extends ConsumerStatefulWidget {
  const VehiclesScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VehiclesScreenState createState() => _VehiclesScreenState();
}

class _VehiclesScreenState extends ConsumerState<VehiclesScreen> {
  int _rowsPerPage = 10;
  String? _searchQuery;
  final TextEditingController _searchController = TextEditingController();

  late VehicleDataSource _vehicleDataSource;
  late VehicleRepository _vehicleRepository;

  @override
  void initState() {
    super.initState();
    _vehicleRepository = ref.read(vehicleRepositoryProvider);
    _initializeDataSource();
  }

  void _initializeDataSource() {
    _vehicleDataSource = VehicleDataSource(
      repository: _vehicleRepository,
      onDeleteVehicle: _showDeleteDialog,
      onEditVehicle: _onEditVehicle,
      pageSize: _rowsPerPage,
      searchQuery: _searchQuery,
    );

    _vehicleDataSource.addListener(_updateUI);
  }

  void _updateUI() {
    setState(() {
      // Actualiza la UI cuando los datos cambian
    });
  }

  void _onSearch() {
    _vehicleDataSource.removeListener(_updateUI);

    setState(() {
      _searchQuery =
          _searchController.text.isNotEmpty ? _searchController.text : null;
      _initializeDataSource();
    });
  }

  void _onRowsPerPageChanged(int? rowsPerPage) {
    _vehicleDataSource.removeListener(_updateUI);

    setState(() {
      _rowsPerPage = rowsPerPage ?? 10;
      _initializeDataSource();
    });
  }

  void _onEditVehicle(VehicleModel vehicle) {
    // Navegar a la pantalla de edición
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => EditVehicleScreen(vehicle: vehicle),
      ),
    )
        .then((_) {
      _initializeDataSource();
    });
  }

  void _showDeleteDialog(VehicleModel vehicle) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content:
            const Text('¿Estás seguro de que deseas eliminar este vehículo?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await _deleteVehicle(vehicle.id);
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteVehicle(String vehicleId) async {
    try {
      await _vehicleRepository.deleteVehicle(vehicleId);
      _initializeDataSource(); // Recargar los datos después de eliminar
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error al eliminar: $e')));
    }
  }

  @override
  void dispose() {
    _vehicleDataSource.removeListener(_updateUI);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int totalRecords = _vehicleDataSource.totalRecords;
    final int totalPages = (totalRecords / _rowsPerPage).ceil();

    final List<GridColumn> gridColumns = _buildColumns();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehículos'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Buscar',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: _onSearch,
                      ),
                    ),
                    onSubmitted: (_) => _onSearch(),
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  flex: 1,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context)
                          .push(
                        MaterialPageRoute(
                            builder: (context) => const AddVehicleScreen()),
                      )
                          .then((_) {
                        _initializeDataSource();
                      });
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Nuevo'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _vehicleDataSource.rows.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Expanded(
                        child: SfDataGrid(
                          source: _vehicleDataSource,
                          columns: _buildColumns(),
                          allowSorting: true,
                          columnWidthMode: ColumnWidthMode.auto,
                          onCellTap: (DataGridCellTapDetails details) {
                            if (details.rowColumnIndex.rowIndex == 0) {
                              final columnIndex =
                                  details.rowColumnIndex.columnIndex;
                              final column = gridColumns[columnIndex];
                              _sort(column.columnName);
                            }
                          },
                        ),
                      ),
                      SfDataPager(
                        delegate: _vehicleDataSource,
                        pageCount: totalPages > 0 ? totalPages.toDouble() : 1.0,
                        availableRowsPerPage: const [5, 10, 20],
                        onRowsPerPageChanged: _onRowsPerPageChanged,
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  void _sort(String columnName) {
    if (columnName == 'actions') return;
    final currentSortColumn = _vehicleDataSource.sortedColumns.isNotEmpty
        ? _vehicleDataSource.sortedColumns.first
        : null;

    DataGridSortDirection newDirection;

    if (currentSortColumn != null && currentSortColumn.name == columnName) {
      newDirection =
          currentSortColumn.sortDirection == DataGridSortDirection.ascending
              ? DataGridSortDirection.descending
              : DataGridSortDirection.ascending;
    } else {
      newDirection = DataGridSortDirection.ascending;
    }

    _vehicleDataSource.updateSorting(columnName, newDirection);
  }

  List<GridColumn> _buildColumns() {
    return <GridColumn>[
      GridColumn(
        columnName: 'brand',
        width: 100,
        label: Container(
          padding: const EdgeInsets.all(4.0),
          alignment: Alignment.center,
          child: const Text('Marca', overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: 'model',
        width: 100,
        label: Container(
          padding: const EdgeInsets.all(4.0),
          alignment: Alignment.center,
          child: const Text('Modelo', overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: 'year',
        width: 80,
        label: Container(
          padding: const EdgeInsets.all(4.0),
          alignment: Alignment.center,
          child: const Text('Año', overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: 'price',
        width: 100,
        label: Container(
          padding: const EdgeInsets.all(4.0),
          alignment: Alignment.center,
          child: const Text('Precio', overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: 'type',
        width: 100,
        label: Container(
          padding: const EdgeInsets.all(4.0),
          alignment: Alignment.center,
          child: const Text('Tipo', overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: 'actions',
        allowSorting: false,
        allowEditing: false,
        allowFiltering: false,
        width: 120,
        label: Container(
          padding: const EdgeInsets.all(4.0),
          alignment: Alignment.center,
          child: const Text('Opciones', overflow: TextOverflow.ellipsis),
        ),
      ),
    ];
  }
}
