import 'package:flutter/material.dart';
import 'package:room_manager/Utils.dart';
import 'package:room_manager/model/area.dart';
import 'package:room_manager/screen/area_list_screen.dart';
import 'package:room_manager/screen/calendar_screen.dart';
import 'package:room_manager/screen/login_screen.dart';
import 'package:room_manager/screen/room_list_screen.dart';
import 'package:room_manager/service/area_service.dart';
import 'package:room_manager/service/room_service.dart';
import 'package:room_manager/widget/area_dialog.dart';
import 'package:room_manager/widget/area_select_dialog.dart';
import 'package:room_manager/widget/room_dialog.dart';

class Screen extends StatefulWidget {
  const Screen({ super.key });

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  int selectedIndex = 0;
  Area ?selectedArea;
  Utils utils = Utils();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text(utils.getAppbarTitle(selectedIndex, selectedArea?.name)),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).primaryColorLight,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child:  GestureDetector(
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Text('Usuario'),
                    SizedBox(width: 8),
                    Icon(Icons.person),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      body: Row(
        children: [
          NavigationRail(
            onDestinationSelected: (int index) {
              setState(() {
                selectedIndex = index;
              });
            },
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(
                icon: Icon(Icons.date_range),
                selectedIcon: Icon(Icons.date_range),
                label: Text('Calendario'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.meeting_room),
                label: Text('Areas'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.room_service), 
                label: Text('Salas')
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings),
                label: Text('Ajustes'),
              ),
            ],
            selectedIndex: selectedIndex,
            labelType: NavigationRailLabelType.all,
            elevation: 5,
            trailing: Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: IconButton(
                    icon: const Icon(Icons.logout), 
                    tooltip: 'Cerrar Sesión',
                    onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()))
                  ),
                ),
              ),
            ),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: <Widget>[
              if (selectedArea != null) 
                CalendarScreen(areaId: selectedArea!.id)
              else 
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    FilledButton(onPressed: () => showAreaSelectDialog(), child: const Text('Seleccione un area')),
                  ],
                ),
              const AreaListScreen(),
              const RoomListScreen()
            ][selectedIndex],
          ),
        ],
      ),
      floatingActionButton: 
      switch (selectedIndex) {
        0 =>  selectedArea != null ? FloatingActionButton.extended(
          onPressed: () => showAreaSelectDialog(),
          label: const Text('Cambiar Area'),
          icon: const Icon(Icons.meeting_room),
        ) : null,
        1 => FloatingActionButton(
          tooltip: 'Agregar Area',
          onPressed: () {
            showDialog(
              context: context, 
              builder: (BuildContext context) {
                return AreaDialog(area: AreaService().emptyArea());
              }
            ).then((value) {
              if (value != null) {
                AreaService().saveArea(value).then((_) {
                  utils.showSuccessNotification(context, 'Create');
                });
              }
            });
          },
          child: const Icon(Icons.add),
        ),
        2 => FloatingActionButton(
          tooltip: 'Agregar Sala',
          onPressed: () {
            showDialog(
              context: context, 
              builder: (BuildContext context) {
                return RoomDialog(room: RoomService().emptyRoom());
              }
            ).then((value) {
              if (value != null) {
                RoomService().saveRoom(value).then((_) {
                  utils.showSuccessNotification(context, 'Create');
                });
              }
            });
          },
          child: const Icon(Icons.add),
        ),
        _ => null,
      }
    );
  }

  void showAreaSelectDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AreaSelectDialog(idArea: selectedArea?.id);
      }
    ).then((value) {
      if (value != null) {
        setState(() {
          selectedArea = value;
        });
      }
    });
  }
}