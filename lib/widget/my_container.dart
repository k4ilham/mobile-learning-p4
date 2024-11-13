import '../core.dart';

class MyContainer extends StatelessWidget {
  final List<Widget> children;
  final Color? containerColor; // Added color parameter
  final EdgeInsetsGeometry? margin; // Added margin parameter
  final EdgeInsetsGeometry? padding; // Added padding parameter
  final BorderRadiusGeometry
      borderRadius; // Added dynamic borderRadius parameter
  final MainAxisAlignment?
      mainAxisAlignment; // Added dynamic mainAxisAlignment parameter
  final CrossAxisAlignment?
      crossAxisAlignment; // Added dynamic crossAxisAlignment parameter

  const MyContainer({
    super.key,
    required this.children,
    this.containerColor = Colors.white, // Default color is white
    this.margin = const EdgeInsets.all(16), // Default margin
    this.padding = const EdgeInsets.all(16), // Default padding
    this.borderRadius = const BorderRadius.all(
        Radius.circular(25)), // Default border radius is 25 for all corners
    this.mainAxisAlignment =
        MainAxisAlignment.start, // Default mainAxisAlignment is start
    this.crossAxisAlignment =
        CrossAxisAlignment.start, // Default crossAxisAlignment is start
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin, // Use dynamic margin here
      padding: padding, // Use dynamic padding here
      decoration: BoxDecoration(
        color: containerColor, // Use dynamic color here
        borderRadius: borderRadius, // Use dynamic border radius here
      ),
      child: Column(
        mainAxisAlignment: mainAxisAlignment ??
            MainAxisAlignment.center, // Use dynamic mainAxisAlignment
        crossAxisAlignment: crossAxisAlignment ??
            CrossAxisAlignment.center, // Use dynamic crossAxisAlignment
        children: children,
      ),
    );
  }
}
