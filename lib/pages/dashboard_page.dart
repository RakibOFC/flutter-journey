import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_journey/database/model/db_entities.dart';

import '../database/database_helper.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final int userId = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 16,
              backgroundColor: Colors.black12,
              child: Icon(
                Icons.person_2_rounded,
                size: 24,
                color: Colors.grey,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: FutureBuilder<String>(
                future: _getUserInfo(userId),
                builder: (context, snapshot) {
                  return Text(
                    snapshot.connectionState == ConnectionState.waiting
                        ? 'Loading...'
                        : snapshot.data ?? 'App Name',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                // Handle logout event
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Welcome, User $userId'),
      ),
    );
  }

  Future<String> _getUserInfo(int userId) async {
    final User? user = await DatabaseHelper.instance.getUserById(userId);

    if (user != null) {
      log('User ${user.name}');
      return user.name;
    } else {
      return 'App Name'; // Return default value if user is null
    }
  }
}
