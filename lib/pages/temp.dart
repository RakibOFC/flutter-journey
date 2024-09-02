import 'package:flutter/material.dart';
import '/rest/api_service.dart';
import 'package:flutter_journey/model/search_result.dart';

class ShowSearchPage extends StatefulWidget {
  @override
  _ShowSearchPageState createState() => _ShowSearchPageState();
}

class _ShowSearchPageState extends State<ShowSearchPage> {
  late Future<List<SearchResult>> futureShows;

  @override
  void initState() {
    super.initState();
    futureShows = ApiService().fetchShows('iron');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TV Shows'),
      ),
      body: FutureBuilder<List<SearchResult>>(
        future: futureShows,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<SearchResult> shows = snapshot.data!;
            return ListView.builder(
              itemCount: shows.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(shows[index].show.name),
                  subtitle: Text(shows[index].show.name),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
