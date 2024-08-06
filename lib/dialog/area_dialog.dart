import 'package:flutter/material.dart';
import 'package:room_manager/model/area.dart';

class AreaDialog extends StatefulWidget {
  final Area area;
  const AreaDialog({ super.key, required this.area});

  @override
  State<AreaDialog> createState() => _AreaDialogState();
}

class _AreaDialogState extends State<AreaDialog> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context){
    final double dialogWidth = MediaQuery.of(context).size.width * 0.8;

    return AlertDialog(
      elevation: 10,
      title: Text(widget.area.id == 0 ? 'Agregar Area' : 'Editar Area'),
      content: SizedBox(
        width: dialogWidth,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nombre'),
                initialValue: widget.area.name,
                onChanged: (value) => setState(() => widget.area.name = value),
                validator: (value) => value!.isEmpty ? 'Porfavor, introduzca un nombre' : null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 10),
              TextFormField(
                textAlignVertical: TextAlignVertical.bottom,
                minLines: 1,
                maxLines: 5,
                decoration: const InputDecoration(labelText: 'Descripción'),
                initialValue: widget.area.description,
                onChanged: (value) => setState (() => widget.area.description = value),
                validator: (value) => value!.isEmpty ? 'Por favor, introduzca una descripción' : null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
          onPressed: formKey.currentState != null && formKey.currentState!.validate() ? () => Navigator.of(context).pop(widget.area) : null,
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}