import '../core.dart';

class CourseDetail extends StatefulWidget {
  final Map<String, dynamic> listData;

  const CourseDetail({super.key, required this.listData});

  @override
  _CourseDetailState createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  late List<dynamic> _filteredData;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final chapters = widget.listData['chapter'] as List<dynamic>? ?? [];

      setState(() {
        _filteredData = chapters;
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
            titleText: widget.listData['title'] ?? 'Course Details',
            showBackButton: true,
          ),
          const SizedBox(height: 20),
          _filteredData.isEmpty
              ? const Expanded(
                  child: Center(child: Text('No chapters available.')))
              : Expanded(child: CourseDetailList(data: _filteredData)),
          const BottomNavBar(),
        ],
      ),
    );
  }
}

class CourseDetailList extends StatelessWidget {
  const CourseDetailList({super.key, required this.data});

  final List data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final chapter = data[index];
        // Determine the icon based on chapter['type']
        IconData leadingIcon;
        if (chapter['type'] == 'youtube') {
          leadingIcon = Icons.video_library; // YouTube icon
        } else if (chapter['type'] == 'pdf') {
          leadingIcon = Icons.picture_as_pdf; // PDF document icon
        } else {
          leadingIcon = Icons.book; // Default book icon
        }

        return Card(
          elevation: 5, // Shadow for card
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Rounded corners on card
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: Icon(
              leadingIcon, // Dynamic icon based on type
              size: 40,
              color: primaryColor,
            ),
            title: Text(
              chapter['title'] ?? 'No Title',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              chapter['description'] ?? 'No description',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
            onTap: () {
              // Navigate to the correct screen based on type
              if (chapter['type'] == 'youtube') {
                Get.to(CourseVideo(listData: chapter)); 
              } else if (chapter['type'] == 'pdf') {
                Get.to(CoursePdf(listData: chapter));
              } else {
                // Handle other types of content here
                print("Unknown chapter type");
              }
            },
          ),
        );
      },
    );
  }
}
