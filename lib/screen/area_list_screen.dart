import 'package:flutter/material.dart';
import 'package:room_manager/service/area_service.dart';
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
    areaService.getAreas().then((value) {
      if (mounted) setState(() => isLoading = false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context){

    return isLoading ? 
      const Center(child: CircularProgressIndicator()) : ListView(
      children: areaService.areas.map((area) => AreaElemWidget(area: area, areaService: areaService)).toList(),
    );
  }
}