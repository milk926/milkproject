import 'dart:async'; // Import for Timer
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> imageUrls = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZ6n03pPCJReT0dT5dIhOXsmOXHs9uSVunFw&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9QPI9-QXDHXqjyOLugSd_L4y50rCsiNoI-xmnqXTZ1UHLztWAmc_if56d7RZXYlDLWq0&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwbCe9AB5aSFvjnFP4H4g4nl7WgqwZyUxfyA&s',
  ];

  final List<String> demoTexts = [
    'This is the first product. It is known for its durability and high quality.',
    'This is the second product. It features excellent performance and value.',
    'The third product is popular for its unique design and functionality.',
  ];

  final List<String> productNames = [
    'Fresh Milk',
    'Organic Butter',
    'Premium Cheese',
  ];

  final List<String> cardTitles = [
    'Consumer Level',
    'Dealer\'s Level',
    'Society Level',
    'Farmer\'s Level',
  ];

  int _currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_scrollController.hasClients) {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentScroll = _scrollController.offset;

        if (currentScroll < maxScroll) {
          _scrollController.animateTo(
            currentScroll + 150,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        } else {
          _scrollController.jumpTo(0);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Drawer Header',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'asset/29319f53b462e0e20000f77710213461.png',
          height: 40,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                'asset/ai-generated-7483596_960_720.jpg',
                fit: BoxFit.cover,
                height: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Products',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'This is the home page where you can introduce our products.',
                    style: TextStyle(fontSize: 16),
                  ),
                  Column(
                    children: [
                      CarouselSlider.builder(
                        itemCount: imageUrls.length,
                        carouselController: _carouselController,
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.height / 2.5,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                          viewportFraction: 1,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                        itemBuilder: (context, index, realIndex) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                height: 150,
                                child: Image.network(
                                  imageUrls[index],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  productNames[index],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Text(
                                  demoTexts[index],
                                  style: const TextStyle(fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      AnimatedSmoothIndicator(
                        activeIndex: _currentIndex,
                        count: imageUrls.length,
                        effect: const ScrollingDotsEffect(
                          dotHeight: 8,
                          dotWidth: 8,
                          activeDotColor: Colors.blue,
                          dotColor: Colors.grey,
                        ),
                        onDotClicked: (index) {
                          _carouselController.animateToPage(index);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'WHAT WE DO',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'We are dedicated to empowering dairy farmers and enhancing the dairy industry by implementing sustainable practices and providing valuable services. Our focus is on improving livelihoods, ensuring market stability, and promoting economic development within the farming community.',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: _scrollController,
                    child: Row(
                      children:
                          cardTitles.map((title) => _buildCard(title)).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      width: 150,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
