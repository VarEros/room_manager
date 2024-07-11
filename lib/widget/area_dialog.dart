import 'package:flutter/material.dart';
import 'package:room_manager/model/area.dart';

class AreaDialog extends StatelessWidget {
  final Area area;
  const AreaDialog({ super.key, required this.area});

  @override
  Widget build(BuildContext context){
    final double dialogWidth = MediaQuery.of(context).size.width * 0.8;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return AlertDialog(
      elevation: 10,
      title: Text(area.id == 0 ? 'Agregar Area' : 'Editar Area'),
      content: SizedBox(
        width: dialogWidth,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nombre'),
                initialValue: area.name,
                onChanged: (value) => area.name = value,
                validator: (value) => value!.isEmpty ? 'Porfavor, introduzca un nombre' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                textAlignVertical: TextAlignVertical.bottom,
                minLines: 1,
                maxLines: 5,
                decoration: const InputDecoration(labelText: 'Descripción'),
                initialValue: area.description,
                onChanged: (value) => area.description = value,
                validator: (value) => value!.isEmpty ? 'Por favor, introduzca una descripción' : null,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              Navigator.of(context).pop(area);
            } 
          },
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}