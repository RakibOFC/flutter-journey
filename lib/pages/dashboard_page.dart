import 'package:flutter/material.dart';
import 'package:flutter_journey/database/model/db_entities.dart';
import 'package:flutter_journey/model/search_result.dart';
import 'package:flutter_journey/rest/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../database/database_helper.dart';
import '../util/values.dart';
import '../widgets/card_tv_show.dart';
import '../widgets/sliver_search_bar_delegate.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {
  final String defSearchText = "iron";
  late final TextEditingController _searchController =
      TextEditingController(text: defSearchText);
  late Future<List<SearchResult>> futureShows;

  @override
  void initState() {
    super.initState();
    futureShows = ApiService().fetchShows(defSearchText);
  }

  void _handleSearch() {
    String searchText = _searchController.text;
    setState(() {
      futureShows = ApiService().fetchShows(searchText);
    });
  }

  void _logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(Values.isLoggedInKey);
    prefs.remove(Values.userIdKey);

    if (!mounted) return;

    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  void dispose() {
    _searchController.dispose(); // Dispose the controller to free up resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int userId = ModalRoute.of(context)!.settings.arguments as int;

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
                  IconButton(
                      onPressed: () {
                        _logout();
                      },
                      icon: const Icon(Icons.logout))
                ],
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverSearchBarDelegate(
                searchController: _searchController,
                onSearchPressed: _handleSearch,
              ),
            ),
            FutureBuilder<List<SearchResult>>(
              future: futureShows,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return SliverToBoxAdapter(
                    child: Center(child: Text('Error: ${snapshot.error}')),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Center(child: Text('No results found')),
                  );
                } else {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final originalIndex = index % snapshot.data!.length;
                        final show = snapshot.data![originalIndex].show;

                        return CardTVShow(
                          index: index,
                          show: show,
                        );
                      },
                      childCount: snapshot.data!.length * 100,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _getUserInfo(int userId) async {
    final User? user = await DatabaseHelper.instance.getUserById(userId);

    if (user != null) {
      return user.name;
    } else {
      return 'App Name'; // Return default value if user is null
    }
  }
}
