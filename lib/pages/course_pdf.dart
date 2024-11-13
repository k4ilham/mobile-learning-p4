import '../core.dart';

class CoursePdf extends StatefulWidget {
  final Map<String, dynamic> listData;

  const CoursePdf({super.key, required this.listData});

  @override
  _CoursePdfState createState() => _CoursePdfState();
}

class _CoursePdfState extends State<CoursePdf> {
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
          // Check if 'link_pdf' exists in the data
          widget.listData['link_pdf'] != null &&
                  widget.listData['link_pdf'].isNotEmpty
              ? Expanded(
                  child: const PDF(
                    enableSwipe: true,
                    swipeHorizontal: true,
                    autoSpacing: true,
                    pageFling: true,
                    nightMode: false,
                    fitEachPage: true,
                  ).cachedFromUrl(
                    widget.listData['link_pdf'],
                    placeholder: (progress) =>
                        Center(child: Text('$progress %')),
                    errorWidget: (error) =>
                        Center(child: Text('Failed to load PDF: $error')),
                  ),
                )
              : const Expanded(
                  child: Center(child: Text('No PDF available.')),
                ),
          const BottomNavBar(),
        ],
      ),
    );
  }
}
