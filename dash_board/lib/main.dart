/*
import 'package:dash_board/Views/Screens/dash_board_screen.dart';
import 'package:dash_board/Views/Screens/dgr_screen.dart';
import 'package:dash_board/Views/Screens/splesh_screen.dart';
import 'package:flutter/material.dart';


void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'dashboard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            color: Colors.white,
            fontSize: 46,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      home:  const DashBoardScreen(),
    );
  }
}


*/
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'easy_sidemenu Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: false
      ),
      home: const MyHomePage(title: 'easy_sidemenu Demo'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();

  @override
  void initState() {
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
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
                        height: 150,
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
          ),
          const VerticalDivider(width: 0,),
         /* Expanded(
            child: PageView(
              controller: pageController,
              children: [
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Dashboard',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Users',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Expansion Item 1',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Expansion Item 2',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Files',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Download',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),

                // this is for SideMenuItem with builder (divider)
                const SizedBox.shrink(),

                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Settings',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
              ],
            ),
          ),*/
        ],
      ),
    );
  }
}