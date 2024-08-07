import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:room_manager/dialog/docent_dialog.dart';
// import 'package:room_manager/Utils.dart';
import 'package:room_manager/model/area.dart';
import 'package:room_manager/model/user.dart';
import 'package:room_manager/screen/area_list_screen.dart';
import 'package:room_manager/screen/calendar_screen.dart';
import 'package:room_manager/screen/docent_list_screen.dart';
import 'package:room_manager/screen/login_screen.dart';
import 'package:room_manager/screen/room_list_screen.dart';
import 'package:room_manager/service/area_service.dart';
import 'package:room_manager/service/docent_service.dart';
import 'package:room_manager/service/room_service.dart';
import 'package:room_manager/utils.dart';
import 'package:room_manager/dialog/area_dialog.dart';
import 'package:room_manager/widget/area_select_dialog.dart';
import 'package:room_manager/dialog/room_dialog.dart';

class Screen extends StatefulWidget {
  final User user;
  const Screen({ super.key, required this.user });

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  int selectedIndex = 0;
  Area ?selectedArea;
  bool isAdmin = true;
  Utils utils = Utils();

  @override
  void initState() {
    if (widget.user.area != null) {
      selectedArea = widget.user.area;
      isAdmin = false;
    }
    super.initState();
  }
  
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
              child:  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Text(widget.user.email),
                    const SizedBox(width: 8),
                    const Icon(Icons.person),
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
            destinations: <NavigationRailDestination>[
              const NavigationRailDestination(
                icon: Icon(Icons.date_range),
                label: Text('Calendario'),
              ),
              NavigationRailDestination(
                disabled: !isAdmin,
                icon: const Icon(Icons.meeting_room),
                label: const Text('Areas'),
              ),
              const NavigationRailDestination(
                icon: Icon(Icons.room_service), 
                label: Text('Salas')
              ),
              const NavigationRailDestination(
                icon: Icon(Icons.people), 
                label: Text('Docentes')
              ),
              const NavigationRailDestination(
                disabled: true,
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
              RoomListScreen(areaId: isAdmin ? null : selectedArea!.id),
              const DocentListScreen()
            ][selectedIndex],
          ),
        ],
      ),
      floatingActionButton: 
      switch (selectedIndex) {
        0 =>  selectedArea != null && isAdmin ? FloatingActionButton.extended(
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
        3 => FloatingActionButton(
          tooltip: 'Agregar Docente',
          onPressed: () {
            showDialog(
              context: context, 
              builder: (BuildContext context) {
                return DocentDialog(docent: DocentService().emptyDocent());
              }
            ).then((value) {
              if (value != null) {
                DocentService().saveDocent(value).then((_) {
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
