import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/presentation/category/screens/category_screen.dart';
import 'package:news_app/presentation/home/screens/home_screen.dart';
import 'package:news_app/presentation/notification/bloc/notification_bloc.dart';
import 'package:news_app/presentation/notification/bloc/notification_event.dart';
import 'package:news_app/presentation/notification/screens/notification_screen.dart';
import 'package:news_app/presentation/profile/screens/profile_screen.dart';
import 'package:news_app/presentation/search/screens/search_screen.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final pages = [
    HomeScreen(),
    SearchScreen(),
    CategoryScreen(),
    BlocProvider(
      create: (context) => NotificationBloc()..add(LoadNotifications()),
      child: NotificationScreen(),
    ),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (i) => setState(() => currentIndex = i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Notif",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
