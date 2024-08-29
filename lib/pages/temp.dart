import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // AppBar Layout
            Container(
              child: Column(
                children: [
                  // RelativeLayout equivalent in Flutter using Stack
                  InkWell(
                    onTap: () {
                      // Handle click event
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                      color: Colors.white,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundImage:
                            AssetImage('assets/drawable/ic_profile.png'),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'App Name',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.logout),
                            onPressed: () {
                              // Handle logout event
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  // MaterialToolbar equivalent in Flutter using AppBar
                  AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    toolbarHeight: 56, // appBarSize equivalent
                    title: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                      ),
                    ),
                    actions: [
                      IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          // Handle search action
                        },
                      ),
                    ],
                  ),

                  // Divider
                  Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),

            // ShimmerFrameLayout equivalent in Flutter
            Visibility(
              visible: true, // toggle this to control shimmer visibility
              child: Column(
                children: List.generate(5, (index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Placeholder(
                      fallbackHeight: 100.0, // Example placeholder height
                    ),
                  );
                }),
              ),
            ),

            // Status Text
            Visibility(
              visible: false, // Toggle this based on the status
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    'No Results Found',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),

            // RecyclerView equivalent in Flutter using ListView
            Expanded(
              child: Visibility(
                visible: false, // Toggle this based on search results visibility
                child: ListView.builder(
                  itemCount: 5, // Example item count
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Search Result Item $index'),
                      // Add your search result item layout here
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
