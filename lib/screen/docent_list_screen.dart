import 'package:flutter/material.dart';
import 'package:room_manager/dialog/docent_dialog.dart';
import 'package:room_manager/service/docent_service.dart';
import 'package:room_manager/utils.dart';
import 'package:room_manager/widget/docent_elem_widget.dart';

class DocentListScreen extends StatefulWidget {
  const DocentListScreen({ super.key });

  @override
  State<DocentListScreen> createState() => _DocentListScreenState();
}

class _DocentListScreenState extends State<DocentListScreen> {
  DocentService docentService = DocentService();
  bool isLoading = true;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() {
    setState(() => isLoading = true);
    docentService.getDocents().then((value) {
      if (mounted) setState(() => isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context){

    return isLoading ? 
      const Center(child: CircularProgressIndicator()) : Stack(
        children: [
          ListView(
            children: docentService.docents.map((docent) => DocentElemWidget(docent: docent, onTap: loadData)).toList(),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context, 
                  builder: (BuildContext context) {
                    return DocentDialog(docent: DocentService().emptyDocent());
                  }
                ).then((value) {
                  if (value != null) {
                    DocentService().saveDocent(value).then((_) {
                      loadData();
                      Utils().showSuccessNotification(context, 'Create');
                    });
                  }
                });
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      );
  }
}