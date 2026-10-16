import 'package:flutter/material.dart';
import 'package:praktikum_papb/controller/post_controller.dart';
import 'package:praktikum_papb/pages/favorite_page.dart';
import 'package:praktikum_papb/pages/post_list_page.dart';
import 'package:praktikum_papb/pages/profile_page.dart';

class MainPage extends StatefulWidget {
  final PostController postController;
  
  const MainPage({super.key, required this.postController});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  late final List<Widget> _pages = [
    PostListPage(postController: widget.postController),
    const FavoritePage(),
    const ProfilePage(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onTabSelected,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.list),
            label: 'Posts',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite),
            label: 'Favorit',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ]
      ),
    );
  }
}