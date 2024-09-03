import 'package:flutter/material.dart';

class SliverSearchBarDelegate extends SliverPersistentHeaderDelegate {
  final TextEditingController searchController;
  final VoidCallback onSearchPressed;

  SliverSearchBarDelegate({
    required this.searchController,
    required this.onSearchPressed,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: AppBar(
        scrolledUnderElevation: 0.0,
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
