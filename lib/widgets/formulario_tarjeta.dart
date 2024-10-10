import 'package:flutter/material.dart';

class FormularioTarjeta extends StatefulWidget {
  const FormularioTarjeta({super.key});

  @override
  _FormularioTarjetaState createState() => _FormularioTarjetaState();
}

class _FormularioTarjetaState extends State<FormularioTarjeta> {
  final _formKey = GlobalKey<FormState>();

  final _nombreController = TextEditingController();
  final _apellidosController = TextEditingController();
  final _direccionController = TextEditingController();
  final _tarjetaController = TextEditingController();
  final _mesController = TextEditingController();
  final _anioController = TextEditingController();
  final _cvvController = TextEditingController();

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidosController.dispose();
    _direccionController.dispose();
    _tarjetaController.dispose();
    _mesController.dispose();
    _anioController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  String? _validarNombre(String? value) {
    if (value == null || value.isEmpty) {
      return 'El nombre es obligatorio';
    }

    // Permitir caracteres especiales y letras, pero sin acentos
    if (!RegExp(r'^[a-zA-Z¨\[\]{ñ+´}p\s]+$').hasMatch(value)) {
      return 'El nombre solo puede contener letras y caracteres especiales permitidos';
    }
    return null;
  }

  String? _validarApellidos(String? value) {
    if (value == null || value.isEmpty) {
      return 'Los apellidos son obligatorios';
    }

    // Permitir caracteres especiales y letras, pero sin acentos
    if (!RegExp(r'^[a-zA-Z¨\[\]{ñ+´}p\s]+$').hasMatch(value)) {
      return 'Los apellidos solo pueden contener letras y caracteres especiales permitidos';
    }
    return null;
  }

  String? _validarDireccion(String? value) {
    if (value == null || value.isEmpty) {
      return 'La dirección es obligatoria';
    }

    // Permitir cualquier caracter excepto acentos
    if (!RegExp(r'^[a-zA-Z0-9¨\[\]{ñ+´}p\s,.-]+$').hasMatch(value)) {
      return 'La dirección contiene caracteres no permitidos';
    }
    return null;
  }

  String? _validarNumeroTarjeta(String? value) {
    if (value == null || value.isEmpty) {
      return 'El número de tarjeta es obligatorio';
    }
    if (value.length != 16) {
      return 'El número de tarjeta debe tener 16 dígitos';
    }
    if (!RegExp(r'^\d{16}$').hasMatch(value)) {
      return 'El número de tarjeta debe ser numérico';
    }
    return null;
  }

  String? _validarMes(String? value) {
    if (value == null || value.isEmpty) {
      return 'El mes de vencimiento es obligatorio';
    }
    if (!RegExp(r'^(0[1-9]|1[0-2])$').hasMatch(value)) {
      return 'Introduce un mes válido (01-12)';
    }
    return null;
  }

  String? _validarAnio(String? value) {
    final actualYear = DateTime.now().year % 100;

    if (value == null || value.isEmpty) {
      return 'El año de vencimiento es obligatorio';
    }

    if (!RegExp(r'^\d{2}$').hasMatch(value)) {
      return 'Introduce un año válido (2 dígitos)';
    }

    final enteredYear = int.parse(value);

    if (enteredYear < actualYear) {
      return 'El año de vencimiento no puede ser menor al año actual';
    }

    return null;
  }

  String? _validarCVV(String? value) {
    if (value == null || value.isEmpty) {
      return 'El CVV es obligatorio';
    }
    if (value.length != 3) {
      return 'El CVV debe tener 3 dígitos';
    }
    if (!RegExp(r'^\d{3}$').hasMatch(value)) {
      return 'El CVV debe ser numérico';
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Formulario Enviado')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color.fromARGB(255, 15, 63, 221);
    const accentColor = Color(0xFF4C264B);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Formulario de Tarjeta',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildInputField(
                  _nombreController, 'Nombre', _validarNombre, 20, accentColor),
              _buildInputField(_apellidosController, 'Apellidos',
                  _validarApellidos, 25, accentColor),
              _buildInputField(_direccionController, 'Dirección',
                  _validarDireccion, 100, accentColor),
              _buildInputField(_tarjetaController, 'Número de Tarjeta',
                  _validarNumeroTarjeta, 16, accentColor, TextInputType.number),
              Row(
                children: [
                  Expanded(
                    child: _buildInputField(
                        _mesController,
                        'Mes de Vencimiento (MM)',
                        _validarMes,
                        2,
                        accentColor,
                        TextInputType.number),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildInputField(
                        _anioController,
                        'Año de Vencimiento (YY)',
                        _validarAnio,
                        2,
                        accentColor,
                        TextInputType.number),
                  ),
                ],
              ),
              _buildInputField(_cvvController, 'CVV', _validarCVV, 3,
                  accentColor, TextInputType.number),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: _submitForm,
                child: const Text(
                  'Enviar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
    TextEditingController controller,
    String labelText,
    String? Function(String?) validator,
    int maxLength,
    Color borderColor, [
    TextInputType? keyboardType,
  ]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.black87),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: validator,
        maxLength: maxLength,
        keyboardType: keyboardType ?? TextInputType.text,
      ),
    );
  }
}
