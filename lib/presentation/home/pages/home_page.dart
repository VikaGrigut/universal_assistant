import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_assistant/presentation/recurring/pages/recurring_page.dart';

import '../../calendar/pages/calendar_page.dart';
import '../../matrix/pages/matrix_page.dart';
import '../../menu/pages/menu_page.dart';
import '../../pomodoro/pages/pomodoro_page.dart';
import '../../tags/cubit/tags_cubit.dart';
import '../../tags/pages/change_tags_page.dart';
import '../../tags/pages/tags_page.dart';
import '../../widgets/new_event_sheet.dart';
import '../../widgets/new_task_sheet.dart';
import '../cubit/home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // TaskRepositoryImpl taskRep = TaskRepositoryImpl();
  // EventRepositoryImpl eventRep = EventRepositoryImpl();
  // SettingsRepositoryImpl settingsRep = SettingsRepositoryImpl();
  //final LocaleDBProvider dbProvider = LocaleDBProvider.dbProvider;
  // final List<Widget> pages = [
  //   CalendarPage(),
  //   TagsPage(),
  //   MatrixPage(),
  //   MenuPage()//PomodoroPage(),
  // ];

  int currentPage = 0;

  final List<String> iconsPaths = [
    'assets/icons/main.png',
    'assets/icons/tags.png',
    'assets/icons/statistics.png',
    'assets/icons/menu.png',
  ];
  final List<String> selectedIconsPaths = [
    'assets/icons/main_selected.png',
    'assets/icons/tags_selected.png',
    'assets/icons/statistics_selected.png',
    'assets/icons/menu_selected.png',
  ];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     currentPage = index;
  //   });
  // }


  final TextEditingController nameController = TextEditingController();
  final TextEditingController infoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        extendBody: true,
        body: getPage(selectedTab),
        floatingActionButton: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: FloatingActionButton(
              onPressed: () {
                showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                              ),
                              context: context,
                              builder: (context) {
                                context.read<TagsCubit>().fetchTags();
                                return NewTaskSheet(
                                  nameController: nameController,
                                  infoController: infoController,
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey),
                          child: const Text(
                            'task',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                              ),
                              context: context,
                              builder: (context) => NewEventSheet(
                                nameController: nameController,
                                infoController: infoController,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey),
                          child: const Text(
                            'event',
                            style: TextStyle(color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  );
                });
              },
              elevation: 0,
              shape: const CircleBorder(),
              //foregroundColor: Colors.white,
              backgroundColor: Colors.deepPurpleAccent,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomAppBar(
            //shape: CircularNotchedRectangle(),
            //notchMargin: 0,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(iconsPaths.length, (index) {
                return Padding(
                    padding: EdgeInsets.only(right: index == 1 ? 30.0 : 0),
                    child: IconButton(
                      icon: Image.asset(
                        selectedTab == HomeTab.values[index]
                            ? selectedIconsPaths[index]
                            : iconsPaths[index],
                        height: 30,
                        // color: currentPage == index
                        //     ? Colors.black
                        //     : Colors.grey.shade600,
                      ),
                      onPressed: () => context.read<HomeCubit>().setTab(HomeTab.values[index]) ,//_onItemTapped(index),
                    ),
                  );
                // if (index == 2) {
                //    // space for FAB
                // }
                // return IconButton(
                //   icon: Icon(
                //     icons[index],
                //     color: currentPage == index
                //         ? Colors.black
                //         : Colors.grey.shade600,
                //   ),
                //   onPressed: () => _onItemTapped(index),
                // );
              }),
            ),
          ),
        ),
        // BottomNavigationBar(
        //   type: BottomNavigationBarType.fixed,
        //   currentIndex: currentPage,
        //   onTap: (index) => setState(() {
        //     currentPage = index;
        //   }),
        //   items: const [
        //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Calendar'),
        //     BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Matrix'),
        //     BottomNavigationBarItem(icon: Icon(Icons.add,size: 35,), label: ''),
        //     BottomNavigationBarItem(icon: Icon(Icons.monitor_heart), label: 'Tags'),
        //     BottomNavigationBarItem(icon: Icon(Icons.data_thresholding_sharp), label: 'Statistic'),
        //   ],
        // ),
      ),
    );
  }

  Widget getPage(HomeTab tab){
    switch(tab){
      case HomeTab.calendar:
        return CalendarPage();
      case HomeTab.tags:
        return TagsPage();
      case HomeTab.matrix:
        return MatrixPage();
      case HomeTab.pomodoro:
        return PomodoroPage();
      case HomeTab.menu:
        return MenuPage();
      case HomeTab.changeTags:
        return ChangeTagsPage();
      case HomeTab.recurring:
        return RecurringPage();
    }
  }

}