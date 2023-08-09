import 'package:consult/pages/launchpage.dart';
import 'package:flutter/material.dart';

import '../custom_widgets/slider.dart';




class Ongoing extends StatefulWidget {
  const Ongoing({super.key});
  @override
  OngoingState createState() => OngoingState();
}

class OngoingState extends State<Ongoing> {
  List<SliderModel> sliders = [];
  int currentState = 0;
  PageController pageController = PageController(initialPage: 0);
  @override
  void initState() {
    super.initState();
    sliders = SliderModel.getSlides();
  }

  Widget pageIndexIndicator(bool isCurrentWidget) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: isCurrentWidget ? 10 : 6,
      width: isCurrentWidget ? 10 : 6,
      decoration: BoxDecoration(
          color: isCurrentWidget ? Colors.grey : Colors.grey[300],
          borderRadius: BorderRadius.circular(12)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView.builder(
        itemCount: sliders.length,
        onPageChanged: (val) {
          setState(() {
            currentState = val;
          });
        },
        itemBuilder: (context, index) {
          return SlideTiles(sliders[index].imagePath, sliders[index].title,
              sliders[index].text);
        },
        controller: pageController,
      ),
      bottomSheet: currentState != sliders.length - 1
          ? Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              child: const Text("SKIP"),
              onTap: () {
                pageController.animateToPage(sliders.length - 1,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.linear);
              },
            ),
            Row(
              children: [
                for (int i = 0; i < sliders.length; i++)
                  i == currentState
                      ? pageIndexIndicator(true)
                      : pageIndexIndicator(false)
              ],
            ),
            GestureDetector(
              child: const Text("NEXT"),
              onTap: () {
                pageController.animateToPage(currentState + 1,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.linear);
              },
            ),
          ],
        ),
      )
          : GestureDetector(
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 60,
          child: Text(
            "Done",
            style: TextStyle(color: Colors.grey[700]),
          ),
        ),
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LaunchPage()),
          );
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const Login()),
          // );
        },
      ),
    );
  }
}

class SlideTiles extends StatelessWidget {
  final String imagePath;
  final String title;
  final String text;

  const SlideTiles(this.imagePath, this.title, this.text, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 200,
            width: 250,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 18, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
