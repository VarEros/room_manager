import 'package:flutter/material.dart';
import 'package:room_manager/model/docent.dart';

class DocentDialog extends StatelessWidget {
  final Docent docent;
  const DocentDialog({ super.key, required this.docent});

  @override
  Widget build(BuildContext context){
    return AlertDialog(
      title: Text(docent.id == 0 ? 'Agregar Docente' : 'Editar Docente'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: TextEditingController(text: docent.name),
            decoration: const InputDecoration(labelText: 'Nombre'),
            onChanged: (value) => docent.name = value,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, null),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () => docent.name.isNotEmpty ? Navigator.pop(context, docent) : null,
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}