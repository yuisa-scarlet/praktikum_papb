import 'package:flutter/material.dart';
import 'package:praktikum_papb/widgets/app_bottom_nav.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
      ),
      body: const Center(
        child: Text('Favorite Page'),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 1),
    );
  }
}