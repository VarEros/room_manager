import 'package:flutter/material.dart';
import 'package:room_manager/Utils.dart';
import 'package:room_manager/model/area.dart';
import 'package:room_manager/screen/area_list_screen.dart';
import 'package:room_manager/screen/calendar_screen.dart';
import 'package:room_manager/screen/login_screen.dart';
import 'package:room_manager/widget/area_select_dialog.dart';

class Screen extends StatefulWidget {
  const Screen({ super.key });

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  int selectedIndex = 1;
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
                icon: Icon(Icons.door_front_door),
                selectedIcon: Icon(Icons.door_front_door),
                label: Text('Areas'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings),
                selectedIcon: Icon(Icons.settings),
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
              selectedArea != null ? const CalendarScreen() : const Text('Seleccione un area', textAlign: TextAlign.center),
              AreaListScreen(),
            ][selectedIndex],
          ),
        ],
      ),
      floatingActionButton: selectedIndex < 1 ? 
      // change area callendar
      FloatingActionButton.extended(
        onPressed: () {
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
        },
        isExtended: selectedArea == null,
        label: const Text('Cambiar Area'),
        icon: const Icon(Icons.door_front_door)
      )
      : 
      FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: const Icon(Icons.add),
      )
    );
  }
}

void handleClick(String value) {
    switch (value) {
      case 'Info':

        break;
      case 'Cerrar Sesión':
        break;
    }
}

