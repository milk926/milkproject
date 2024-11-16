import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> imageUrls = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZ6n03pPCJReT0dT5dIhOXsmOXHs9uSVunFw&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9QPI9-QXDHXqjyOLugSd_L4y50rCsiNoI-xmnqXTZ1UHLztWAmc_if56d7RZXYlDLWq0&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwbCe9AB5aSFvjnFP4H4g4nl7WgqwZyUxfyA&s',
  ];

  int _currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Right drawer
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Handle item tap
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Handle item tap
              },
            ),
          ],
        ),
      ),

      appBar: AppBar(
        centerTitle: true, // Center the title
        title: Image.asset(
          'asset/29319f53b462e0e20000f77710213461.png', // Your logo
          height: 40,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // Open the drawer
              Scaffold.of(context).openEndDrawer();
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Banner Image Section
            Container(
              width: double.infinity, // Make it full width
              child: Image.asset(
                'asset/ai-generated-7483596_960_720.jpg', // Path to your banner image
                fit: BoxFit.cover, // Ensures the image covers the area
                height: 200, // Adjust height as needed
              ),
            ),

            // Main content section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to the Home Screen!',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'This is the home page where you can introduce your app.',
                    style: TextStyle(fontSize: 16),
                  ),
                  Column(
                    children: [
                      CarouselSlider.builder(
                        itemCount: imageUrls.length,
                        carouselController: _carouselController,
                        options: CarouselOptions(
                          height: 250.0,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          viewportFraction: 0.8,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                        itemBuilder: (context, index, realIndex) {
                          return Column(
                            children: [
                              Image.network(
                                imageUrls[index],
                                fit: BoxFit.cover,
                                height: 150,
                                width: double.infinity,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Image ',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),

                                
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: 16),
                      // Smooth Page Indicator
                      AnimatedSmoothIndicator(
                        activeIndex: _currentIndex,
                        count: imageUrls.length,
                        effect: ScrollingDotsEffect(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
