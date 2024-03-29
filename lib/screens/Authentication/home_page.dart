import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/screens/Authentication/auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:project/screens/Beneficary/dashboard.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:project/screens/Donation/dashboard.dart';
import 'package:project/screens/Donor/dashboard.dart';
import 'package:project/screens/Volunteer/dashboard.dart';
import 'package:project/screens/Authentication/jailbreak_detection.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? user = Auth().currentUser;

  int activeIndex = 0;
  final controller = CarouselController();
  // final urlImages = [
  //   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFbyulT-JGYWgijetJaAu1NoGDPpB29uP7yQ&usqp=CAU',
  //   'https://img.freepik.com/free-vector/people-carrying-donation-charity-related-icons_53876-43091.jpg',
  //   'https://img.freepik.com/premium-vector/donation-box-charity-concept-human-hands-putting-money-cash-love-heart-donation-box-together-helping-doing-charity-vector-illustration_140689-3158.jpg',
  //   'https://media.istockphoto.com/id/1223169247/id/vektor/sumbangan-makanan-dan-bahan-makanan.jpg?b=1&s=170667a&w=0&k=20&c=XLV422GUZh_TfiV5mUNwqwOB7KMpOXNjkhGa0hgqXfo=',
  //   'https://media.istockphoto.com/id/1156535303/vector/volunteer-young-people-with-donation-boxes-isolated-on-white-background-vector-flat-cartoon.jpg?s=612x612&w=0&k=20&c=_CGuGN6LA_2ysMidVPS5oX1T3hy7PVARt3FzcRbYjno=',
  // ];
  final urlImages = [
    'assets/images/image1.png',
    'assets/images/image2.png',
    'assets/images/image3.png',
  ];

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _title() {
    return const Text('Helping Hands');
  }

  Widget _userUid() {
    return Text(user?.email ?? 'User email');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
        actions: <Widget>[
          _userUid(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          signOut();
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.logout_rounded),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://img.freepik.com/free-vector/vibrant-summer-ombre-background-vector_53876-105765.jpg?w=360'),
            // AssetImage("back/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Helping Hands Charity App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            CarouselSlider.builder(
                carouselController: controller,
                itemCount: urlImages.length,
                itemBuilder: (context, index, realIndex) {
                  final urlImage = urlImages[index];
                  return buildImage(urlImage, index);
                },
                options: CarouselOptions(
                    height: 200,
                    autoPlay: true,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: const Duration(seconds: 2),
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) =>
                        setState(() => activeIndex = index))),
            const SizedBox(height: 12),
            buildIndicator(),
            const SizedBox(height: 20),
            MaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DonationHomePage()));
              },
              color: Colors.blue,
              textColor: Colors.white,
              minWidth: 300,
              height: 40,
              child: const Text('Donations'),
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DonorHomePage()));
              },
              color: Colors.blue,
              textColor: Colors.white,
              minWidth: 300,
              height: 40,
              child: const Text('Donar'),
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VolunteerHomePage()));
              },
              color: Colors.blue,
              textColor: Colors.white,
              minWidth: 300,
              height: 40,
              child: const Text('Volunteers'),
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BeneficaryHomePage()));
              },
              color: Colors.blue,
              textColor: Colors.white,
              minWidth: 300,
              height: 40,
              child: const Text('Beneficiary'),
            ),
            const SizedBox(
              height: 40,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => jailBreak()));
              },
              child: const Text('Jailbreak Detection'),
              color: Colors.red,
              textColor: Colors.white,
              minWidth: 300,
              height: 40,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        onDotClicked: animateToSlide,
        effect: const ExpandingDotsEffect(
            dotWidth: 10,
            dotHeight: 8,
            activeDotColor: Color.fromARGB(255, 137, 144, 150)),
        activeIndex: activeIndex,
        count: urlImages.length,
      );

  void animateToSlide(int index) => controller.animateToPage(index);
}

Widget buildImage(String urlImage, int index) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 5),
    child: Image.asset(urlImage, fit: BoxFit.cover));
