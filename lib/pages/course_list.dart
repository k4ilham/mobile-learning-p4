import '../core.dart';

class Courselist extends StatefulWidget {
  final Map<String, dynamic> listData;

  const Courselist({super.key, required this.listData});

  @override
  _CourselistState createState() => _CourselistState();
}

class _CourselistState extends State<Courselist> {
  late List<dynamic> _filteredData;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final courses = widget.listData['course'] as List<dynamic>? ?? [];

      setState(() {
        _filteredData = courses;
      });
    } catch (error) {
      print('Failed to load data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          MyHeader(
            titleText: widget.listData['title'] ?? 'Courses',
            showBackButton: true,
          ),
          const SizedBox(height: 20),
          _filteredData.isEmpty
              ? const Expanded(
                  child: Center(child: Text('No courses available.')))
              : Expanded(child: CourseList(data: _filteredData)),
          const BottomNavBar(),
        ],
      ),
    );
  }
}

class CourseList extends StatelessWidget {
  const CourseList({super.key, required this.data});

  final List data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final course = data[index];
        return Card(
          elevation: 5, // Menambahkan shadow
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Rounded corners
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: Image.asset(
                imageSplash), // Ganti dengan image dari course jika perlu
            title: Text(course['title'] ?? 'No Title'),
            subtitle: Text(course['description'] ?? 'No description'),
            onTap: () => Get.to(CourseDetail(listData: course)),
          ),
        );
      },
    );
  }
}
