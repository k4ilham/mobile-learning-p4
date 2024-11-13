import '../core.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        if (index == 0) {
          // Navigate to the Home page
          Get.to(const Home());
        } else if (index == 1) {
          // Show "Coming Soon" message for Bookmark
          _showComingSoonDialog(context);
        } else if (index == 2) {
          // Show the "About" dialog box
          _showAboutDialog(context);
        }
      },
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

  // Show a "Coming Soon" dialog for the Bookmark tab
  void _showComingSoonDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Coming Soon"),
          content: const Text("This feature is under development."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  // Show an "About" dialog box with app details and developer information
  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("About This App"),
          content: const Text(
            "Mobile Learning Application for Universitas Negeri Semarang\n\n"
            "This app provides educational resources for students, "
            "including courses, videos, and interactive content. "
            "It aims to enhance learning through mobile technology.\n\n"
            "Developer: Ilham Maulana\n"
            "Email: k4ilham@gmail.com\n"
            "Website: www.inercorp.com",
            style: TextStyle(fontSize: 16),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
