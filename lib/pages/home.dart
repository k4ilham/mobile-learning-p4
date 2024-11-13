// ignore_for_file: library_private_types_in_public_api, prefer_final_fields

import 'dart:convert';

import 'package:flutter/services.dart';

import '../core.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _filteredData = [];
  List<dynamic> _originalData = [];

  @override
  void initState() {
    super.initState();
    loadJsonData().then((data) {
      setState(() {
        _originalData = data;
        _filteredData = data;
      });
    });
  }

  Future<List<dynamic>> loadJsonData() async {
    try {
      final String response =
          await rootBundle.loadString('assets/database.json');
      return json.decode(response);
    } catch (error) {
      throw Exception('Failed to load JSON data: $error');
    }
  }

  void _filterData(String query) {
    if (query.isEmpty || query.length < 3) {
      setState(() {
        _filteredData = _originalData;
      });
      return;
    }

    setState(() {
      _filteredData = _originalData.where((item) {
        final title = item['title']?.toLowerCase() ?? '';
        final description = item['description']?.toLowerCase() ?? '';
        final searchQuery = query.toLowerCase();
        return title.contains(searchQuery) || description.contains(searchQuery);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          // Header Section with search input
          MyHeader(
            searchController: _searchController,
            onSearchChanged: _filterData,
          ),
          const SizedBox(height: 20),
          // Categories Section
          // ignore: prefer_const_constructors
          CategoryHeader(),
          if (_filteredData.isEmpty)
            const Expanded(
              child: Center(child: Text('No data available.')),
            )
          else
            CategoryBody(data: _filteredData),
          // Bottom Navigation Bar
          const BottomNavBar(),
        ],
      ),
    );
  }
}

class MyHeader extends StatelessWidget {
  const MyHeader({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
  });

  final TextEditingController searchController;
  final Function(String) onSearchChanged;

  @override
  Widget build(BuildContext context) {
    return MyContainer(
      containerColor: primaryColor,
      margin: const EdgeInsets.all(0),
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(25),
        bottomRight: Radius.circular(25),
      ),
      children: [
        const SizedBox(height: 20),
        const MyText(
          titleText: 'Hello',
          titleStyle: TextStyle(
            color: whiteColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const MyText(
          titleText: 'Good Morning',
          titleStyle: TextStyle(
            color: whiteColor,
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
            controller: searchController,
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Search your topic',
              border: InputBorder.none,
              icon: Icon(Icons.search, color: Colors.grey[600]),
            ),
          ),
        ),
      ],
    );
  }
}

class CategoryHeader extends StatelessWidget {
  const CategoryHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const MyText(
            titleText: 'Explore Categories',
            titleStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: () {
              Get.snackbar(appName, 'Coming Soon');
            },
            child: const Text('See all'),
          ),
        ],
      ),
    );
  }
}

class CategoryBody extends StatelessWidget {
  const CategoryBody({
    super.key,
    required this.data,
  });

  final List data;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: GridView.builder(
          itemCount: data.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            final program = data[index];
            final title = program['title'] ?? 'No Title';
            final description = program['description'] ?? '0 Courses';

            return MyCard(
              title: title,
              description: description,
              imagePath: imageSplash,
            );
          },
        ),
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          label: 'Bookmark',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info),
          label: 'About',
        ),
      ],
    );
  }
}
