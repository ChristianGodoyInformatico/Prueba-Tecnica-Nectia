// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/vehicle_model.dart';
import '../providers/vehicle_provider.dart';

class EditVehicleScreen extends ConsumerStatefulWidget {
  final VehicleModel vehicle;

  const EditVehicleScreen({Key? key, required this.vehicle}) : super(key: key);

  @override
  _EditVehicleScreenState createState() => _EditVehicleScreenState();
}

class _EditVehicleScreenState extends ConsumerState<EditVehicleScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _brandController;
  late TextEditingController _modelController;
  late TextEditingController _yearController;
  late TextEditingController _priceController;
  late TextEditingController _typeController;

  Widget spaceBetween = const SizedBox(height: 5);

  @override
  void initState() {
    super.initState();
    _brandController = TextEditingController(text: widget.vehicle.brand);
    _modelController = TextEditingController(text: widget.vehicle.model);
    _yearController = TextEditingController(text: widget.vehicle.year.toString());
    _priceController = TextEditingController(text: widget.vehicle.price.toString());
    _typeController = TextEditingController(text: widget.vehicle.type);
  }

  Future<void> _updateVehicle() async {
    if (_formKey.currentState?.validate() ?? false) {
      final updatedVehicle = VehicleModel(
        id: widget.vehicle.id,
        brand: _brandController.text,
        model: _modelController.text,
        year: int.parse(_yearController.text),
        price: double.parse(_priceController.text),
        type: _typeController.text,
      );

      try {
        final vehicleRepository = ref.read(vehicleRepositoryProvider);
        await vehicleRepository.updateVehicle(widget.vehicle.id, updatedVehicle);

        Navigator.of(context).pop(); // Volver a la lista de vehículos
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error al actualizar el vehículo: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Vehículo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _brandController,
                decoration: const InputDecoration(labelText: 'Marca'),
                validator: (value) => value?.isEmpty ?? true ? 'Campo requerido' : null,
              ),
              spaceBetween,
              TextFormField(
                controller: _modelController,
                decoration: const InputDecoration(labelText: 'Modelo'),
                validator: (value) => value?.isEmpty ?? true ? 'Campo requerido' : null,
              ),
              spaceBetween,
              TextFormField(
                controller: _yearController,
                decoration: const InputDecoration(labelText: 'Año'),
                keyboardType: TextInputType.number,
                validator: (value) => value?.isEmpty ?? true ? 'Campo requerido' : null,
              ),
              spaceBetween,
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
                validator: (value) => value?.isEmpty ?? true ? 'Campo requerido' : null,
              ),
              spaceBetween,
              TextFormField(
                controller: _typeController,
                decoration: const InputDecoration(labelText: 'Tipo'),
                validator: (value) => value?.isEmpty ?? true ? 'Campo requerido' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateVehicle,
                child: const Text('Guardar cambios'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
