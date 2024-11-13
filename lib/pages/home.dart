import '../core.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _filteredData = [];
  List<dynamic> _originalData = [];

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    try {
      final response = await rootBundle.loadString('assets/database.json');
      final data = json.decode(response) as List<dynamic>;
      setState(() {
        _originalData = data;
        _filteredData = data;
      });
    } catch (error) {
      print('Failed to load JSON data: $error');
    }
  }

  void _filterData(String query) {
    setState(() {
      _filteredData = query.isEmpty || query.length < 3
          ? _originalData
          : _originalData.where((item) {
              final title = (item['title'] ?? '').toLowerCase();
              final description = (item['description'] ?? '').toLowerCase();
              final searchQuery = query.toLowerCase();
              return title.contains(searchQuery) ||
                  description.contains(searchQuery);
            }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          MyHeader(
            titleText: 'Mobile Learning',
            subtitleText: 'Universitas Negeri Semarang',
            showSearch: true,
            searchController: _searchController,
            onSearchChanged: _filterData,
          ),
          const SizedBox(height: 20),
          _filteredData.isEmpty
              ? const Expanded(child: Center(child: Text('No data available.')))
              : Expanded(child: CategoryGrid(data: _filteredData)),
          const BottomNavBar(),
        ],
      ),
    );
  }
}

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key, required this.data});

  final List data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GridView.builder(
        itemCount: data.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          final program = data[index];
          return GestureDetector(
            onTap: () => Get.to(Courselist(listData: program)),
            child: MyCard(
              title: program['title'] ?? 'No Title',
              description: program['description'] ?? '0 Courses',
              imagePath: imageSplash,
            ),
          );
        },
      ),
    );
  }
}
