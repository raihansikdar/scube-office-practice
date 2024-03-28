import 'package:dash_board/Views/Screens/ac_power_screen.dart';
import 'package:dash_board/Views/Screens/radiation_screen.dart';
import 'package:dash_board/Views/Screens/shed_wise/shed_wise_todays_screen.dart';
import 'package:dash_board/Views/Screens/shed_wise/shed_wise_yesterday_screen.dart';
import 'package:dash_board/Views/Screens/temperature_screen.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SidebarMenuWidget extends StatelessWidget {
  const SidebarMenuWidget({
    super.key,
    required this.sideMenu,
  });

  final SideMenuController sideMenu;

  @override
  Widget build(BuildContext context) {
    return SideMenu(
      controller: sideMenu,
      style: SideMenuStyle(
        backgroundColor: Colors.deepPurple,
        showTooltip: true,
        displayMode: SideMenuDisplayMode.auto,
        //showHamburger: true,
        hoverColor: Colors.black26,
        selectedHoverColor: Colors.black26,
        selectedColor: Colors.black26,
        selectedTitleTextStyle: const TextStyle(color: Colors.white),
        selectedIconColor: Colors.white,
        unselectedIconColor: Colors.white,
        unselectedTitleTextStyle: const TextStyle(color:Colors.white),
        unselectedIconColorExpandable: Colors.white,
        selectedIconColorExpandable: Colors.white,
        arrowOpen: Colors.white,
        arrowCollapse: Colors.white,

        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.all(Radius.circular(10)),
        // ),

      ),
      title: Column(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              //maxHeight: 210,
              // maxWidth: 150,
            ),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 100,
                ),
                const Text("Solar Monitoring System",style: TextStyle(color: Colors.white),)
              ],
            ),
          ),
          const Divider(
            indent: 8.0,
            endIndent: 8.0,
          ),
        ],
      ),
      footer: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.lightBlue[50],
              borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
            child: Text(
              'copyright©Scube Technologies Limited',
              style: TextStyle(fontSize: 15, color: Colors.grey[800]),
            ),
          ),
        ),
      ),
      items: [
        SideMenuItem(
          title: 'Home',
          onTap: (index, _) {
            sideMenu.changePage(index);
            
          },
          icon: const Icon(Icons.home,),

        ),
        SideMenuItem(
          builder: (context, displayMode) {
            return const Divider(
              height: 0,
              color: Colors.grey,
            );
          },
        ),
        SideMenuItem(
          title: 'DGR',
          onTap: (index, _) {
            sideMenu.changePage(index);
          },
          icon: const Icon(Icons.tv),
        ),
        SideMenuItem(
          builder: (context, displayMode) {
            return const Divider(
              height: 0,
              color: Colors.grey,
            );
          },
        ),
        SideMenuExpansionItem(
          title: "ShedWise",
          iconWidget:  const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: FaIcon(FontAwesomeIcons.houseMedical,color: Colors.white,size: 18,),
          ),
          children: [
            SideMenuItem(
              title: 'Today Energy',
              onTap: (index, _) {
                sideMenu.changePage(index);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ShedWiseTodaysScreen()));
              },
              iconWidget: const FaIcon(FontAwesomeIcons.calendarDay,color: Colors.white,size: 18,),
            ),
            SideMenuItem(
              builder: (context, displayMode) {
                return const Divider(
                  height: 0,
                  color: Colors.grey,
                );
              },
            ),
            SideMenuItem(
              title: 'Yesterday Energy',
              onTap: (index, _) {
                sideMenu.changePage(index);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ShedWiseYesterdayScreen()));
              },
              iconWidget: const FaIcon(FontAwesomeIcons.calendarDay,color: Colors.white,size: 18,),
              //icon: const Icon(Icons.supervisor_account),
            ),
          ],
        ),
        SideMenuItem(
          builder: (context, displayMode) {
            return const Divider(
              height: 0,
              color: Colors.grey,
            );
          },
        ),
        SideMenuItem(
          title: 'Temperature',
          onTap: (index, _) {
            sideMenu.changePage(index);
            Navigator.push(context, MaterialPageRoute(builder: (context)=>TemperatureScreen()));
          },
          //icon: const Icon(Icons.tv),
          iconWidget:  const FaIcon(FontAwesomeIcons.temperatureQuarter,color: Colors.white,),
        ),
        SideMenuItem(
          builder: (context, displayMode) {
            return const Divider(
              height: 0,
              color: Colors.grey,
            );
          },
        ),
        SideMenuItem(
          title: 'Radiation',
          onTap: (index, _) {
            sideMenu.changePage(index);
            Navigator.push(context, MaterialPageRoute(builder: (context)=>RadiationScreen()));
          },
          //icon: const Icon(Icons.tv),
          iconWidget:  const FaIcon(FontAwesomeIcons.radiation,color: Colors.white,),
        ),
        SideMenuItem(
          builder: (context, displayMode) {
            return const Divider(
              height: 0,
              color: Colors.grey,
            );
          },
        ),
        SideMenuItem(
          title: 'AC Power',
          onTap: (index, _) {
            sideMenu.changePage(index);
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AcPowerScreen()));
          },
          icon: const Icon(Icons.power),
        ),
        SideMenuItem(
          builder: (context, displayMode) {
            return const Divider(
              height: 0,
              color: Colors.grey,
            );
          },
        ),
        SideMenuItem(
          title: 'Setting',
          onTap: (index, _) {
            sideMenu.changePage(index);
          },
          icon: const Icon(Icons.settings),
        ),
        SideMenuItem(
          builder: (context, displayMode) {
            return const Divider(
              color: Colors.grey,
            );
          },
        ),
        const SideMenuItem(
          title: 'Exit',
          icon: Icon(Icons.exit_to_app),
        ),
      ],
    );
  }
}