import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_journey/database/model/db_entities.dart';

import '../database/database_helper.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {
  final TextEditingController _searchController = TextEditingController();

  void _handleSearch() {
    String searchText = _searchController.text;
    log('SearchText: $searchText');
  }

  @override
  void dispose() {
    _searchController.dispose(); // Dispose the controller to free up resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int userId = ModalRoute.of(context)!.settings.arguments as int;
    final List<String> items =
        List<String>.generate(20, (index) => "Item $index");

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: [
          AppBar(
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
          AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            toolbarHeight: 56,
            title: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
              ),
            ),
            actions: [
              IconButton(
                onPressed: _handleSearch,
                icon: const Icon(Icons.search),
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.label),
                  title: Text(items[index]),
                );
              },
              itemCount: items.length,
            ),
          )
        ],
      )),
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
