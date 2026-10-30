import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:praktikum_papb/service/auth_service.dart';
import 'package:praktikum_papb/widgets/app_bottom_nav.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthService>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Obx(() {
        final user = auth.currentUser.value;
        if (user == null) {
          return const Center(
            child: Text('No user logged in'),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${user.name}'),
              const SizedBox(height: 8),
              Text('Email: ${user.email}'),
              const SizedBox(height: 8),
              Text('Created at: ${user.createdAt}'),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: () {
                  _confirmDialog(auth);
                },
                child: const Text('Logout'),
              )
            ],
          ),
        );
      }),
      bottomNavigationBar: const AppBottomNav(currentIndex: 2),
    );
  }

  Future<void> _confirmDialog(AuthService auth) async {
    final result = await showDialog<bool>(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      auth.logout();
    }
  }
}