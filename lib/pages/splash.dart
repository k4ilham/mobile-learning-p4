import '../core.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: ImageSection()),
          Expanded(
            flex: 2,
            child: MainContainer()),
        ],
      ),
    );
  }
}

class ImageSection extends StatelessWidget {
  const ImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        imageSplash,
        fit: BoxFit.contain,
      ),
    );
  }
}

class MainContainer extends StatelessWidget {
  const MainContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return MyContainer(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 5),
        const Center(
          child: MyText(
            titleText: 'Mobile Learning\nUniversitas Negeri Semarang',
            titleStyle: TextStyle(
              color: blackColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 5),
        const Center(
          child: MyText(
            titleText: 'Temukan keterampilan baru\nBelajar kapan saja, di mana saja!',
            titleStyle: TextStyle(
              color: Colors.black54,
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: MyButton(
            buttonText: 'Ayo Mulai',
            buttonColor: primaryColor,
            textColor: whiteColor,
            onPressed: () {
              Get.off(const Home());
            },
          ),
        ),
      ],
    );
  }
}
