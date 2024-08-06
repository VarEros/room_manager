import 'package:flutter/material.dart';
import 'package:room_manager/service/docent_service.dart';
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
    docentService.getDocents().then((value) {
      if (mounted) setState(() => isLoading = false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context){

    return isLoading ? 
      const Center(child: CircularProgressIndicator()) : ListView(
      children: docentService.docents.map((docent) => DocentElemWidget(docent: docent, docentService: docentService)).toList(),
    );
  }
}