import 'package:flutter/material.dart';
import 'package:room_manager/dialog/docent_dialog.dart';
import 'package:room_manager/model/docent.dart';
import 'package:room_manager/service/docent_service.dart';
import 'package:room_manager/utils.dart';

class DocentElemWidget extends StatelessWidget {
  final Docent docent;
  final DocentService docentService;
  const DocentElemWidget({ super.key, required this.docent, required this.docentService});

  @override
  Widget build(BuildContext context){
    Utils utils = Utils();

    return ListTile(
      title: Text(docent.name),
      onTap: () {
        showDialog(
          context: context, 
          builder: (context) => DocentDialog(docent: docent)
        ).then((value) {
          if (value != null) {
            docentService.saveDocent(docent).then((value) => utils.showSuccessNotification(context, 'Update'));
          }
        });
      },
    );
  }
}