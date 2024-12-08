import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:milkproject/society/page/profilepage.dart';

class MilkProjectHomePage extends StatelessWidget {
  const MilkProjectHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Milk Project Dashboard'),
        backgroundColor: const Color(0xFF3EA120),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Navigate to Notifications Page
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => NotificationPage()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Navigate to Profile Page
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ProfilePage()));
            },
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Carousel Slider for Announcements
              _buildCarouselSlider(),
              const SizedBox(height: 20),

              // Quick Stats Dashboard
              _buildQuickStats(),

              const SizedBox(height: 20),

              // Feature Sections
              _buildFeatureSections(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  // Side Navigation Drawer
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF3EA120)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/profile.png'),
                ),
                SizedBox(height: 10),
                Text(
                  'Admin Name',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  'Admin Email',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text('Sales Report'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => SalesReportPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('User Accounts'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => UserAccountPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Order Management'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => OrderManagementPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.inventory),
            title: const Text('Product Catalog'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ProductCatalogPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.feedback),
            title: const Text('Feedback'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const FeedbackPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => NotificationPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.check_circle),
            title: const Text('Order Status'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => OrderStatusPage()));
            },
          ),
        ],
      ),
    );
  }

  // Carousel Slider Widget
  Widget _buildCarouselSlider() {
    final List<String> imgList = [
      'assets/images/announcement1.png',
      'assets/images/announcement2.png',
      'assets/images/announcement3.png',
    ];

    return CarouselSlider(
      options: CarouselOptions(
        height: 180.0,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        autoPlayInterval: const Duration(seconds: 5),
      ),
      items: imgList
          .map((item) => Container(
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: AssetImage(item),
                    fit: BoxFit.cover,
                  ),
                ),
              ))
          .toList(),
    );
  }

  // Quick Stats Dashboard
  Widget _buildQuickStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatCard(
            'Total Sales', '₹12,000', Icons.attach_money, Colors.green),
        _buildStatCard('New Orders', '25', Icons.shopping_cart, Colors.blue),
        _buildStatCard('Feedback', '18', Icons.feedback, Colors.orange),
      ],
    );
  }

  // Individual Stat Card
  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(icon, size: 30, color: color),
              const SizedBox(height: 10),
              Text(
                value,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(height: 5),
              Text(
                title,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Feature Sections
  Widget _buildFeatureSections(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Features',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildFeatureCard(context, 'Sales Report', Icons.bar_chart,
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3VAs9YEVMBkwCJt_DcEbuwL_rdBy0zRIOxA&s',
                () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => SalesReportPage()));
            }),
            _buildFeatureCard(context, 'User Accounts', Icons.people,
                'https://c8.alamy.com/comp/2CBA14N/milk-bottle-production-process-vector-illustration-cartoon-flat-infographic-poster-with-processing-line-in-automated-dairy-factory-making-pasteurization-and-bottling-milk-product-isolated-on-white-2CBA14N.jpg',
                () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => UserAccountPage()));
            }),
            _buildFeatureCard(context, 'Order Management', Icons.shopping_cart,
                'data:image/png;base64,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',
                () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => OrderManagementPage()));
            }),
            _buildFeatureCard(context, 'Product Catalog', Icons.inventory,
                'data:image/jpeg;base64,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',
                () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ProductCatalogPage()));
            }),
            _buildFeatureCard(context, 'Feedback', Icons.feedback,
                'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAilBMVEX///8AAADu7u7t7e3m5uYEBAQdHR37+/saGhrx8fHW1tbh4eHZ2dkhISH09PTT09MkJCQqKiqSkpIuLi6Dg4PNzc2KioqamprFxcVhYWG6urp4eHhra2sVFRUzMzOpqalISEhUVFR0dHRAQECzs7NTU1NHR0dcXFyhoaF+fn45OTmWlpa1tbW/v7+fGgnyAAALVklEQVR4nO2di3qjKhCABTGEaIhJmlubNNm2u2ma0/d/vcNg4gXQ3BSNn3O+Pd3tiM7vIDIDgoMz4jpZcZ9ei52O8Nm1HWEzrOwIO8Im2NERdoQdYf12dIQdYRGhmxX16NZprVwYl3xmJk+JcQ6Seq7qKg8TljCMGceMMaxo4XeJ3KYVZ2XAx1zTde0RYsIoI/7gJCQrg6zcpBX3josLSs46CRmbzVdh2OtH0stKPys3aIe99/1xKRwI9b9WwtnHEFUm4Sqg4pK1EVJK+RYM8apjRHM3es7rIXTooWI+IW+EYYFYkw8PAs+rlFCc/a3GWvp9cmCFjJ5AnFPCXfVdYoUwmFbswBMhCuCda5tQPIPOuupH8CwraE8tE1L4PVRPK4zhUu/xVO5DIVtbgAhNOKuhpaHryhvSWPZXtKXlxxb8jy0PIjQWd9kCUlbLRhX21lTpE90qfE/Fu17rYjYI7RH2iPUshmXCvt8RPjthDbVUSGCzpbHvw46wI+wIO8KOsCN8CsLKYws8sE1YaFUVwETttUE87Mmw30N6/u2k8M7/UrXxQZ4hqu6P6sgm6oRe2lBVsvAaoZc+UCvdH+gRcC2EKTONjKa/GsTgw0FjfPhzmHwfX3YbnQH+3V/PF4vJamyAgF/8OSwWx49Pg7YhPkRoug2kis32Jt+8zCAJ6VB/YtL++eXR5V5/muhDWStfOI+1r2H6gYKff4NES1ZJTY0SduEXjwDhJnwjpb1piA8XzD3lbakwc7SJIWQbs4eRwPickKhLa8P/eHxmUXixydbU+gnBnA8qAElM6HwlVoqfQ8JJOqtLdpmGd8vTbynqzLMPYwNqKUL/fKmObXScQ8rKzRd3+ZlBPo2/6fuzFx5M6rDQ451KWHct9dCCY1FL01aOYqWH/pKUNmpv9icGeDsuQZkZe91mbl8TfDgO9BkTq6QibnXta8qFRNFyB7836zkULSXhWtl54qWlroWm6CQvutbZN4vQQx9cH4v+L9b2fd2H7jQuvjUQvjWrlnroYCD8jbUh0c5M2Xv8lH4ZCF9u9WG1sYWH3jDWysZPGhr6TNVSNo0LbzWtSmiILSpAymoz8aFoLKhaFvP4OfTQSDsznm3OZdFEv67oEqQJDfEhvqfi3aQNMoQh0cq6qQHGrap1+fl9IPhXPBo2T7TYH2uEWSTbWQxPZ+BLL2HYc+3MKf7+SOWHiSxNI/xLVCs/Uv3SzX/yRZ/i/0r3y9ZybkeiZf5ntk9TOyGgzLNl+VfyvhPaMc1omb9LBRfifanwT7IBZv2EUr6FH6gsIf7jSyWQ3ZO4LHM52WURNq+iLLwzYV4w42oA2RDCzQRHWoYp207VUH01Aq1sB+lshRT1dEsd2QALLZmoaZCGEIqu26u4/5Qz93flnUPbpKaGxwALLWfBfJzOW0VatF66UJaS7U4t2xRCMOnz42UxP3xuzBnFcHU4Tl7+hnHmMSkLf9+tJ8fj6j0+WeMI02adzM8wJEReBJjxoYLbUMLKpCPsCJ+T0G5sYYWw0CorY09VEjZj7KlKwtrzNBYIOx8+P2Hnw46w+YRdLX12QvtvfEqtEm6COnzovl+2rCwZ+nV8ncf+2SN89+1/90Qd+mGPcI8vE5YdW1A5J8SWHKheSysIlxQt89Gl6VsliLxALzBYhW+veLdoIXXLV8Z5hGUjij9rTlWrKs9iMAIjgGHln6pHacYA5i5YJnRh/hM7Vk8I1XQBTz21TQhLOTB3VTUfAH7oY48WCM/yhk75bT1Hn2/0NY5PcuIHbrLKDiGsVrE4AXlpuUDhIeV4Tc5q0ZtZUKNVdghh8R0+O2xyIIocdNmJUoYr/zRJrCYfwnCm4wwW65/3cVrC4loKPhoXShiKP/9Wi4DmWWXJhy5MCoV2jvhnmY2EwPTZAkIRK3zDYTM/K7JsIphG8zhr9KFJC0s/8dE4Dy6qn7sRv2PZqIYQylHuXMKoBVr5hiliN163qYTSh5NokbK2EsKUBJgt/Dhh9bFFvhbn11I0XTIX333mfK1lYH+qo0Vj86ceWBlI6tFWK62ZUAAeGXVyX3G3Xbd5hELC79OHCm0l3C0hkG2xD/+ItyDNuLCBhHL1u8gPtKhsljCa37UQvRRWolXVEIrInkRW0sKyqg898QhyV1+RrHmEnHDqv35P/hslbryqlv7M5Gz84q5mEwhdTo7Rx4FvQVHZhDAKMdbQEXUZaT4hw/E3Aj+DqwilzInspl0KF+onFOHgJInep/rkfI1QHis6oo/eWSuEkD3kSWQLjeMFwlOq4jP65Kn5hJAg9ZPQXZj/hxUTRowrwt1HrmuPEN6F68Qz4se7f4EQDj3K1LEVwoejB0xl4jD50Cf0c8uen8PNF8OXz3xnbPE4Ukor33xL5R0XzvKWKIf4EBy4G/FLZ35Aix+oAJoWupNkp+TPwhnLKXuK8SEd89h1C7SlZjFk74W+qWneS4QyHfMchA5U04WWqS4inKL3KB3zJISijhrGe4sIe9Ml9LQrDNNKJnR8w8ySYT7h4I08nhG1WkvpWgcsIIT+nVvGdW0RyofwJkIR6z4VofNrHA0s9KH7TITM/WccDywgPGXtn4FQRhR784BnEWEZDJZ8SAmPuqNtJXQJf+2Z1uZqDSFjwaf2QWdDCEvqxbM1Os+K0AnL3v7oEe1dhSE/bXwTRg/mMKgXST369uoBgLNx/pSDM6Glalk+IXxcz8d5U3+8FhAK4W/GRQzb4kPhxG/1q/kW+dCYmFEkfG5CU2KmRbU0JzHTIkLHnJhpE6E5MdMqQmNipk2E5sRMiwhzEjMtIsxJzDSc8IZePM5JzOQQ1hVbXF0YZ0cX4F24u+pDkV7N8SFWXJydjJSaawwb3aYJKYXF8C4RCn1vKacyK3awrKhWllZpTVkMP7URbZCS0SDInGnZu+6bj+GrLK5scRtkhRCWb2XJhP5PfxhLZsvaHsoMZM7RFR9EwD2IzjLMirIfbm843R9gsDh/elF5hP18e1l6otr8um/ubvikazzhdzDcTtjLN0HzYdny6VsgJPURwtqX6rqR7SIExLXjZFa3bBehbJpHjvala4sIoek60KoJa21phITkRoZn8qEUb9R2QvTbesJlyYRaP712QllLKwym8KCg1+anZhDyl/zj7hXoBX6OmLa2xUNINxGSZAooroBQdmFXrr4+SblZjHoJPbSlbnsJpRNJydPcmkUIS7ZTXO5kzEYRQqdNbtLRYkI0HZU9caNphGvDLiRtIjTvJNMqwo1hr6R2Ea7ZHQxPRIjQN2854diP5gy3l3BNH18m4jHCJLbAlcQWC0r03aCcsseero4PjVto3i3QJf1xrzP6Ni1WXVwTIcgbNa9mVVcWo2xCDzYCMq6E1A5CqKV5az21gxDJhL6VWnp1RrhUQsjQLO9jeBIfCsLzyFp7CV/uZHgSQhTlultMKKJ7906GZ2lpRCUtaVGhhvoQode2E/64bSc8OGUt7lXe2FO5hF+Z+WZlxhbaDbhy7AmzskbX5GjFv9NGwBUg3USYxPhyF9/SxEMHcUpLa5vUQih3HG8vIYxWhPF3620khD7pgQvAZvkQsxJ9iDYj9gDDMxCuOX6AofGEsP8NLe8V30TC/qu6oUGVhPj6nHdphFtty4ZKfegGpuXvT+Jjfn5rleXDfjRn1h4hY7Ppph9Leh57v4eI3K5Cnoe5c0+ZjN7PygUt/C/8PCy57HLbIySYzwbJkvXKgvayQxq5EGOiarOr3V/QyhX2XXpeMNgeIc+sWY9pLA4kM09s53PRrCjL3Rdr5dWK12+tyIcF/XQaLSMXhRamJcgqC3keC5caaVaZWvxABXgGbb07B3SEHWFH2BE2x8qOsCNsgh0dYUfYEdZvR4WE/wOtLEqvwvntnwAAAABJRU5ErkJggg==',
                () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const FeedbackPage()));
            }),
            _buildFeatureCard(context, 'Notifications', Icons.notifications,
                'data:image/jpeg;base64,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',
                () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => NotificationPage()));
            }),
            _buildFeatureCard(context, 'Order Status', Icons.check_circle,
                'https://www.shutterstock.com/image-vector/order-delivery-status-post-parcel-260nw-2303714819.jpg',
                () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => OrderStatusPage()));
            }),
          ],
        ),
      ],
    );
  }

  // Individual Feature Card
  Widget _buildFeatureCard(BuildContext context, String title, IconData icon,
      String imagePath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(imagePath,
                height: 50, width: 50, fit: BoxFit.contain),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Bottom Navigation Bar
  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: 'Reports',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: 0,
      selectedItemColor: const Color(0xFF3EA120),
      onTap: (index) {
        // Handle navigation based on index
        switch (index) {
          case 0:
            // Already on Home
            break;
          case 1:
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => SalesReportPage()));
            break;
          case 2:
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => ProfilePage()));
            break;
        }
      },
    );
  }
}

// Placeholder Pages
//import 'package:flutter/material.dart';

class SalesReportPage extends StatelessWidget {
  final List<Map<String, dynamic>> salesData = [
    {
      'date': '2024-11-15',
      'product': 'Milk',
      'quantity': 20,
      'totalAmount': 200.0,
      'image':
          'data:image/jpeg;base64,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', // Replace with actual milk image URL
    },
    {
      'date': '2024-11-16',
      'product': 'Butter',
      'quantity': 10,
      'totalAmount': 150.0,
      'image':
          'data:image/jpeg;base64,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'
    },
    {
      'date': '2024-11-17',
      'product': 'Cheese',
      'quantity': 15,
      'totalAmount': 225.0,
      'image':
          'data:image/jpeg;base64,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', // Replace with actual cheese image URL
    },
  ];

  SalesReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3EA120),
        title: const Text('Sales Report'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: salesData.length,
          itemBuilder: (context, index) {
            final sale = salesData[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Image.network(
                      sale['image'],
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, size: 50),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sale['product'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text('Date: ${sale['date']}'),
                          Text('Quantity: ${sale['quantity']}'),
                          Text(
                            'Total Amount: \$${sale['totalAmount'].toStringAsFixed(2)}',
                            style: const TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
//import 'package:flutter/material.dart';

class UserAccountPage extends StatelessWidget {
  final List<Map<String, dynamic>> users = [
    {
      'name': 'John Doe',
      'email': 'john.doe@example.com',
      'phone': '+1234567890',
      'status': 'Active',
    },
    {
      'name': 'Jane Smith',
      'email': 'jane.smith@example.com',
      'phone': '+1987654321',
      'status': 'Inactive',
    },
    {
      'name': 'Alex Brown',
      'email': 'alex.brown@example.com',
      'phone': '+1122334455',
      'status': 'Active',
    },
  ];

  UserAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3EA120),
        title: const Text('User Accounts'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return _buildUserCard(
              context,
              name: user['name'],
              email: user['email'],
              phone: user['phone'],
              status: user['status'],
            );
          },
        ),
      ),
    );
  }

  Widget _buildUserCard(
    BuildContext context, {
    required String name,
    required String email,
    required String phone,
    required String status,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: $email'),
            Text('Phone: $phone'),
            Text('Status: $status'),
            const SizedBox(height: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3EA120),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                _manageUserAccount(context, name);
              },
              child: const Text(
                'Manage Account',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to simulate managing user accounts
  void _manageUserAccount(BuildContext context, String userName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Managing account for $userName')),
    );
  }
}

//import 'package:flutter/material.dart';

class OrderManagementPage extends StatelessWidget {
  final List<Map<String, dynamic>> orders = [
    {
      'orderId': 'ORD001',
      'customerName': 'John Doe',
      'orderDate': '2024-11-15',
      'status': 'Pending',
      'totalAmount': 150.0,
    },
    {
      'orderId': 'ORD002',
      'customerName': 'Jane Smith',
      'orderDate': '2024-11-17',
      'status': 'Shipped',
      'totalAmount': 200.0,
    },
    {
      'orderId': 'ORD003',
      'customerName': 'Alex Brown',
      'orderDate': '2024-11-18',
      'status': 'Delivered',
      'totalAmount': 100.0,
    },
  ];

  OrderManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3EA120),
        title: const Text('Order Management'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return _buildOrderCard(
              context,
              orderId: order['orderId'],
              customerName: order['customerName'],
              orderDate: order['orderDate'],
              status: order['status'],
              totalAmount: order['totalAmount'],
            );
          },
        ),
      ),
    );
  }

  Widget _buildOrderCard(
    BuildContext context, {
    required String orderId,
    required String customerName,
    required String orderDate,
    required String status,
    required double totalAmount,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          'Order ID: $orderId',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Customer: $customerName'),
            Text('Order Date: $orderDate'),
            Text('Total Amount: ₹${totalAmount.toStringAsFixed(2)}'),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Status: $status',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _getStatusColor(status),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3EA120),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    _updateOrderStatus(context, orderId, status);
                  },
                  child: const Text(
                    'Update Status',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Function to change the status color based on the order status
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Shipped':
        return Colors.blue;
      case 'Delivered':
        return Colors.green;
      default:
        return Colors.black;
    }
  }

  // Function to simulate order status update
  void _updateOrderStatus(
      BuildContext context, String orderId, String currentStatus) {
    String newStatus;
    if (currentStatus == 'Pending') {
      newStatus = 'Shipped';
    } else if (currentStatus == 'Shipped') {
      newStatus = 'Delivered';
    } else {
      newStatus = 'Pending'; // Reset to Pending for demo
    }

    // Show a confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Order $orderId status updated to $newStatus')),
    );
  }
}

//import 'package:flutter/material.dart';

class ProductCatalogPage extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Fresh Milk',
      'price': 50.0,
      'image':
          'https://t3.ftcdn.net/jpg/08/51/45/82/360_F_851458299_bkXFOQmJwjVmjjip6J5XEntc3v9izSmR.jpg', // Replace with actual asset paths
    },
    {
      'name': 'Cheese',
      'price': 120.0,
      'image': 'data:image/jpeg;base64,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',
    },
    {
      'name': 'Butter',
      'price': 90.0,
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8XJpsaDblWM66kj_jVRxPbMUijGbmr8Pyog&s',
    },
    {
      'name': 'Yogurt',
      'price': 60.0,
      'image': 'data:image/jpeg;base64,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',
    },
  ];

  ProductCatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3EA120),
        title: const Text('Product Catalog'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.75,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return _buildProductCard(
              context,
              name: product['name'],
              price: product['price'],
              imagePath: product['image'],
            );
          },
        ),
      ),
    );
  }

  Widget _buildProductCard(
    BuildContext context, {
    required String name,
    required double price,
    required String imagePath,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Product Image
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Product Name
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 4),

          // Product Price
          Text(
            '₹${price.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 8),

          // Add to Cart Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3EA120),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              // Add product to cart logic
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$name added to cart!')),
              );
            },
            child: const Text(
              'Add to Cart',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _feedbackController = TextEditingController();
  double _rating = 0;

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3EA120),
        title: const Text('Feedback'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'We value your feedback!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),

              // Rating Section
              const Text(
                'Rate your experience:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _rating = index + 1.0;
                      });
                    },
                    child: Icon(
                      Icons.star,
                      size: 40,
                      color: index < _rating ? Colors.amber : Colors.grey,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),

              // Feedback Text Input
              TextFormField(
                controller: _feedbackController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Your Feedback',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please provide your feedback';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Submit Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3EA120),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 40.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Collect feedback data
                      final feedback = _feedbackController.text;
                      print('Rating: $_rating');
                      print('Feedback: $feedback');

                      // Show confirmation message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Thank you for your feedback!'),
                        ),
                      );

                      // Clear the form
                      setState(() {
                        _feedbackController.clear();
                        _rating = 0;
                      });
                    }
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//import 'package:flutter/material.dart';

class OrderStatusPage extends StatelessWidget {
  final List<Map<String, String>> orders = [
    {
      'orderId': 'ORD12345',
      'date': '2024-11-22',
      'status': 'Delivered',
    },
    {
      'orderId': 'ORD12346',
      'date': '2024-11-20',
      'status': 'In Transit',
    },
    {
      'orderId': 'ORD12347',
      'date': '2024-11-18',
      'status': 'Processing',
    },
    {
      'orderId': 'ORD12348',
      'date': '2024-11-15',
      'status': 'Cancelled',
    },
  ];

  OrderStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3EA120),
        title: const Text('Order Status'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return _buildOrderCard(
              orderId: order['orderId'] ?? '',
              date: order['date'] ?? '',
              status: order['status'] ?? '',
            );
          },
        ),
      ),
    );
  }

  Widget _buildOrderCard({
    required String orderId,
    required String date,
    required String status,
  }) {
    IconData statusIcon;
    Color statusColor;

    switch (status) {
      case 'Delivered':
        statusIcon = Icons.check_circle;
        statusColor = Colors.green;
        break;
      case 'In Transit':
        statusIcon = Icons.local_shipping;
        statusColor = Colors.blue;
        break;
      case 'Processing':
        statusIcon = Icons.hourglass_top;
        statusColor = Colors.orange;
        break;
      case 'Cancelled':
        statusIcon = Icons.cancel;
        statusColor = Colors.red;
        break;
      default:
        statusIcon = Icons.info;
        statusColor = Colors.grey;
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: statusColor.withOpacity(0.2),
          child: Icon(statusIcon, color: statusColor),
        ),
        title: Text(
          'Order ID: $orderId',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date: $date'),
            const SizedBox(height: 4),
            Text(
              'Status: $status',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: statusColor,
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () {
            // Navigate to order details or perform an action
            print('View details for $orderId');
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: OrderStatusPage(),
  ));
}

//import 'package:flutter/material.dart';


  Widget _buildEditableField({
    required BuildContext context,
    required String label,
    required String initialValue,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onChanged: (value) {
          print('$label updated to $value');
        },
      ),
    );
  }


class NotificationPage extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      'title': 'New Order Placed',
      'description': 'A new order has been placed by User123.',
      'time': '2 mins ago',
    },
    {
      'title': 'Product Updated',
      'description': 'Milk price has been updated to \$2.50/L.',
      'time': '15 mins ago',
    },
    {
      'title': 'Order Dispatched',
      'description': 'Order #456 has been dispatched for delivery.',
      'time': '30 mins ago',
    },
    {
      'title': 'Feedback Received',
      'description': 'You received a 5-star feedback for your service.',
      'time': '1 hour ago',
    },
    {
      'title': 'Low Inventory Alert',
      'description': 'Stock for Yogurt is running low.',
      'time': '3 hours ago',
    },
    {
      'title': 'New User Registered',
      'description': 'A new user has signed up: User789.',
      'time': '1 day ago',
    },
  ];

  NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3EA120),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];
            return _buildNotificationCard(
              title: notification['title'] ?? '',
              description: notification['description'] ?? '',
              time: notification['time'] ?? '',
            );
          },
        ),
      ),
    );
  }

  // Notification card widget
  Widget _buildNotificationCard({
    required String title,
    required String description,
    required String time,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notification icon
            CircleAvatar(
              backgroundColor: const Color(0xFF3EA120).withOpacity(0.2),
              child: const Icon(Icons.notifications, color: Color(0xFF3EA120)),
            ),
            const SizedBox(width: 12),
            // Notification details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    time,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
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
}
