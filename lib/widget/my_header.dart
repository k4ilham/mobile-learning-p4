import '../core.dart';

class MyHeader extends StatelessWidget {
  const MyHeader({
    super.key,
    required this.titleText,
    this.subtitleText = '',
    this.showSearch = false,
    this.showBackButton = false,
    this.searchController,
    this.onSearchChanged,
  });

  final String titleText;
  final String subtitleText;
  final bool showSearch;
  final bool showBackButton;
  final TextEditingController? searchController;
  final Function(String)? onSearchChanged;

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
        Row(
          children: [
            if (showBackButton)
              IconButton(
                icon: const Icon(Icons.arrow_back, color: whiteColor),
                onPressed: () => Navigator.of(context).pop(),
              ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    titleText: titleText,
                    titleStyle: const TextStyle(
                      color: whiteColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Tampilkan subtitleText hanya jika subtitleText tidak kosong
                  if (subtitleText.isNotEmpty)
                    MyText(
                      titleText: subtitleText,
                      titleStyle: const TextStyle(
                        color: whiteColor,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        if (showSearch && searchController != null && onSearchChanged != null)
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
                hintText: 'Mau Belajar Apa Hari Ini?',
                border: InputBorder.none,
                icon: Icon(Icons.search, color: Colors.grey[600]),
              ),
            ),
          ),
      ],
    );
  }
}
