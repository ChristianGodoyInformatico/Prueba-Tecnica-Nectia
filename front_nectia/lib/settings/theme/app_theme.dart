import 'package:flutter/material.dart';

const MaterialColor primarySwatch = Colors.green;
const seedColor = Color.fromARGB(255, 7, 80, 59);

class AppTheme {
  static ThemeData myTheme = ThemeData(
    primarySwatch: primarySwatch,
    brightness: Brightness.light,
    // Estilos globales para TextFields
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        gapPadding: 20,
        borderSide: BorderSide(width: 10),
      ),
      contentPadding: EdgeInsets.symmetric(
          vertical: 12, horizontal: 20), // Ajuste de padding
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromARGB(255, 213, 216, 218), width: 3),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue, width: 3),
      ),
      labelStyle: TextStyle(color: Colors.blueGrey),
    ),
    // Estilos globales para botones
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    ),
    // Definir el TextTheme personalizado
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold), // Título1
      displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold), // Título2
      displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // Título3
      bodyLarge: TextStyle(fontSize: 16), // Texto1
      bodyMedium: TextStyle(fontSize: 14), // Texto2
      bodySmall: TextStyle(fontSize: 12), // Texto3
    ),
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    listTileTheme: const ListTileThemeData(
      iconColor: seedColor,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
      displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
      displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.white),
      bodySmall: TextStyle(fontSize: 12, color: Colors.white),
    ),
  );
}
