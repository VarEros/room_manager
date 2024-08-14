import 'package:flutter/material.dart';
import 'package:room_manager/dialog/area_dialog.dart';
import 'package:room_manager/service/area_service.dart';
import 'package:room_manager/utils.dart';
import 'package:room_manager/widget/area_elem_widget.dart';

class AreaListScreen extends StatefulWidget {
  const AreaListScreen({ super.key });

  @override
  State<AreaListScreen> createState() => _AreaListScreenState();
}

class _AreaListScreenState extends State<AreaListScreen> {
  AreaService areaService = AreaService();
  bool isLoading = true;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() {
    setState(() => isLoading = true);
    areaService.getAreas().then((value) {
      if (mounted) setState(() => isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context){

    return isLoading ? 
      const Center(child: CircularProgressIndicator()) : Stack(
      children: [
        ListView(
          children: areaService.areas.map((area) => AreaElemWidget(area: area, onTap: loadData)).toList(),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context, 
                builder: (BuildContext context) {
                  return AreaDialog(area: AreaService().emptyArea());
                }
              ).then((value) {
                if (value != null) {
                  AreaService().saveArea(value).then((_) {
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