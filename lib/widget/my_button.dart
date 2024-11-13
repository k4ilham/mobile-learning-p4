import '../core.dart';

class MyButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback? onPressed;

  const MyButton({
    super.key,
    required this.buttonText,
    this.buttonColor = primaryColor,
    this.textColor = whiteColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed ??
          () => Get.off(const Home()), // Default to navigating to Home
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: 16,
          color: textColor,
        ),
      ),
    );
  }
}
