import 'package:flutter/material.dart';
import 'package:room_manager/screen/area_list_screen.dart';
import 'package:room_manager/screen/calendar_screen.dart';

class Screen extends StatefulWidget {
  const Screen({ super.key });

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {

  int selectedIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: const Text('Room Manager'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).primaryColorLight,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: PopupMenuButton<String>(
              onSelected: handleClick,
              position: PopupMenuPosition.under,
              icon: const Icon(Icons.account_circle),
              itemBuilder: (BuildContext context) {
                return {'Info', 'Cerrar Sesión'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ),
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
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: <Widget>[
              const CalendarScreen(),
              AreaListScreen(),
            ][selectedIndex],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
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

