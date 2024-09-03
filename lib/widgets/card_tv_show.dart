import 'package:flutter/material.dart';
import 'package:flutter_journey/model/search_result.dart';

class CardTVShow extends StatelessWidget {
  final int index;
  final Show show;

  const CardTVShow({super.key, required this.index, required this.show});

  @override
  Widget build(BuildContext context) {
    String genres = show.genres.isNotEmpty ? show.genres.join(', ') : 'N/A';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
                  child: show.image?.medium != null &&
                          show.image!.medium.isNotEmpty
                      ? Image.network(
                          show.image!.medium,
                          width: 100.0,
                          height: 150.0,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/flutter.png',
                          // Replace with your asset image path
                          width: 100.0,
                          height: 150.0,
                          fit: BoxFit.cover,
                        ),
                ),
                const SizedBox(width: 10.0),
                // Text section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        show.name, // replace with your string
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        show.language ?? '-',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        'Genres: $genres',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        'Runtime: ${show.runtime != null ? '${show.runtime} min' : 'N/A'}',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        'Premiered: ${show.premiered ?? 'N/A'}',
                        // replace with your string
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        'Avg. Rating: ${show.rating.average ?? 'N/A'}',
                        // replace with your string
                        style: const TextStyle(
                          fontSize: 14.0,
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
