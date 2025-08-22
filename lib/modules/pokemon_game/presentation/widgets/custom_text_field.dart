import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final Function(String) onSend;

  const CustomTextField({super.key, required this.onSend});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final TextEditingController controller = TextEditingController();
  String text = '';

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onTextChanged(String value) {
    setState(() => text = value);
  }

  void onSend() {
    if (text.isEmpty) return;

    widget.onSend(text);
    setState(() {
      text = '';
      controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      spacing: 5,
      children: [
        Expanded(
          child: _TextField(
            controller: controller,
            onTextChanged: onTextChanged,
          ),
        ),

        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: text.isEmpty ? null : theme.colorScheme.secondaryContainer,
          ),
          // decoration: Decoration(color: Colors.white),
          child: IconButton(
            icon: const Icon(Icons.send),
            onPressed: text.isEmpty ? null : onSend,
          ),
        ),
      ],
    );
  }
}

class _TextField extends StatelessWidget {
  final Function(String) onTextChanged;
  final TextEditingController controller;

  const _TextField({required this.controller, required this.onTextChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      controller: controller,
      onChanged: onTextChanged,
      maxLines: 1, // solo una linea
      minLines: 1, // Comienza con una línea

      decoration: InputDecoration(
        hintText: 'Ingresa un Pokémon',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: theme.colorScheme.primaryContainer,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}
