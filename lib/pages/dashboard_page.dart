import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_journey/database/model/db_entities.dart';
import 'package:flutter_journey/model/search_result.dart';
import 'package:flutter_journey/rest/api_service.dart';

import '../database/database_helper.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {
  final TextEditingController _searchController = TextEditingController();
  late Future<List<SearchResult>> futureShows;

  void _handleSearch() {
    String searchText = _searchController.text;
    log('SearchText: $searchText');
    futureShows = ApiService().fetchShows(searchText);
    logShows();
  }

  void logShows() async {
    try {
      List<SearchResult> shows = await futureShows;

      shows.map((show) => show.toJson()).toList();

      List<Map<String, dynamic>> jsonList = shows.map((show) => show.toJson()).toList();

      // Encode the list of JSON maps to a JSON string
      String jsonString = jsonEncode(jsonList);

      // Log the JSON string
      log(jsonString);
    } catch (e) {
      log("Error logging shows: $e");
    }
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
        List<String>.generate(200, (index) => "Item $index");

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              pinned: false,
              floating: true,
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
                    child: FutureBuilder(
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
                  IconButton(onPressed: () {}, icon: const Icon(Icons.logout))
                ],
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverSearchBarDelegate(
                searchController: _searchController,
                onSearchPressed: _handleSearch,
              ),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              return CardTVShow(
                index: index,
              ); /*ListTile(
                leading: const Icon(Icons.label),
                title: Text(items[index]),
              );*/
            }, childCount: items.length))
          ],
        ),
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

class _SliverSearchBarDelegate extends SliverPersistentHeaderDelegate {
  final TextEditingController searchController;
  final VoidCallback onSearchPressed;

  _SliverSearchBarDelegate({
    required this.searchController,
    required this.onSearchPressed,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 56,
        title: TextField(
          controller: searchController,
          decoration: const InputDecoration(
            hintText: 'Search',
            hintStyle:
                TextStyle(color: Colors.grey, fontWeight: FontWeight.w300),
            border: InputBorder.none,
          ),
        ),
        actions: [
          IconButton(
            onPressed: onSearchPressed,
            icon: const Icon(Icons.search),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 56.0;

  @override
  double get minExtent => 56.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class CardTVShow extends StatelessWidget {
  final int index;

  const CardTVShow({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: InkWell(
          onTap: () {
            // Handle on tap
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Image section
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/images/flutter.png', // replace with your image path
                    width: 80.0,
                    height: 120.0,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10.0),
                // Text section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'App Name', // replace with your string
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'Placeholder Text', // replace with your string
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'Genres: S Text', // replace with your string
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'Placeholder Text', // replace with your string
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'Placeholder Text', // replace with your string
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'Schedule: S Text', // replace with your string
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
