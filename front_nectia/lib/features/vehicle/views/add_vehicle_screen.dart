// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_nectia/core/widgets/custom_button.dart';
import '../models/vehicle_model.dart';
import '../providers/vehicle_provider.dart';

class AddVehicleScreen extends ConsumerStatefulWidget {
  const AddVehicleScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddVehicleScreenState createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends ConsumerState<AddVehicleScreen> {
  final _formKey = GlobalKey<FormState>();

  Widget spaceBetween = const SizedBox(height: 5);

  // Controladores para los campos de texto
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();

  @override
  void dispose() {
    _brandController.dispose();
    _modelController.dispose();
    _yearController.dispose();
    _priceController.dispose();
    _typeController.dispose();
    super.dispose();
  }

  Future<void> _addVehicle() async {
    if (_formKey.currentState!.validate()) {
      final vehicle = VehicleModel(
        id: '', // Se genera en el backend
        brand: _brandController.text,
        model: _modelController.text,
        year: int.parse(_yearController.text),
        price: double.parse(_priceController.text),
        type: _typeController.text,
      );

      try {
        final repository = ref.read(vehicleRepositoryProvider);
        await repository.createVehicle(vehicle);

        // Navegar hacia atrás después de crear el vehículo
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Vehículo creado exitosamente')),
        );
        Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al crear el vehículo: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Vehículo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Campo de marca
                TextFormField(
                  controller: _brandController,
                  decoration: const InputDecoration(labelText: 'Marca'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Campo requerido' : null,
                ),
                spaceBetween,
                // Campo de modelo
                TextFormField(
                  controller: _modelController,
                  decoration: const InputDecoration(labelText: 'Modelo'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Campo requerido' : null,
                ),
                spaceBetween,
                // Campo de año
                TextFormField(
                  controller: _yearController,
                  decoration: const InputDecoration(labelText: 'Año'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo requerido';
                    }
                    final year = int.tryParse(value);
                    if (year == null || year <= 0) {
                      return 'Debe ser un año válido';
                    }
                    return null;
                  },
                ),
                spaceBetween,
                // Campo de precio
                TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(labelText: 'Precio'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo requerido';
                    }
                    final price = double.tryParse(value);
                    if (price == null || price <= 0) {
                      return 'Debe ser un precio válido';
                    }
                    return null;
                  },
                ),
                spaceBetween,
                // Campo de tipo
                TextFormField(
                  controller: _typeController,
                  decoration: const InputDecoration(labelText: 'Tipo'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Campo requerido' : null,
                ),
                const SizedBox(height: 20),
                // Botón para agregar el vehículo
                Center(
                    child: CustomButton(
                  onPressed: _addVehicle,
                  text: 'Agregar Vehículo',
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
