import 'package:flutter/material.dart';

class MyTextfieldShow extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final FocusNode? focusNode;

  const MyTextfieldShow({
    super.key,
    required this.hintText,
    required this.controller,
    this.focusNode,
  });

  @override
  State<MyTextfieldShow> createState() => _MyTextfieldShowState();
}

class _MyTextfieldShowState extends State<MyTextfieldShow> {
  bool _obscureText = true; // Mover la variable aquí para que sea una variable de instancia

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary, // Color del texto
        ),
        obscureText: _obscureText, // Usar la variable de instancia aquí
        focusNode: widget.focusNode,
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.hintText,
          labelStyle: TextStyle( // Asegurar el color del texto de la etiqueta
            color: Theme.of(context).colorScheme.primary,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText; // Cambiar el valor y llamar a setState
              });
            },
            icon: Icon(
              _obscureText
                  ? Icons.visibility_off_rounded
                  : Icons.visibility_outlined,
              color: Theme.of(context).colorScheme.primary,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}