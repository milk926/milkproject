import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
                  MaterialPageRoute(builder: (_) => const NotificationPage()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Navigate to Profile Page
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const ProfilePage()));
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
                  MaterialPageRoute(builder: (_) => const SalesReportPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('User Accounts'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const UserAccountPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Order Management'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const OrderManagementPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.inventory),
            title: const Text('Product Catalog'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const ProductCatalogPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.feedback),
            title: const Text('Feedback'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const FeedbackPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const NotificationPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.check_circle),
            title: const Text('Order Status'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const OrderStatusPage()));
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
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3VAs9YEVMBkwCJt_DcEbuwL_rdBy0zRIOxA&s', () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const SalesReportPage()));
            }),
            _buildFeatureCard(context, 'User Accounts', Icons.people,
                'https://c8.alamy.com/comp/2CBA14N/milk-bottle-production-process-vector-illustration-cartoon-flat-infographic-poster-with-processing-line-in-automated-dairy-factory-making-pasteurization-and-bottling-milk-product-isolated-on-white-2CBA14N.jpg', () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const UserAccountPage()));
            }),
            _buildFeatureCard(context, 'Order Management', Icons.shopping_cart,
                'data:image/png;base64,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', () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const OrderManagementPage()));
            }),
            _buildFeatureCard(context, 'Product Catalog', Icons.inventory,
                'data:image/jpeg;base64,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',
                 () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const ProductCatalogPage()));
            }),
            _buildFeatureCard(context, 'Feedback', Icons.feedback,
                'data:image/png;base64,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', () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const FeedbackPage()));
            }),
            _buildFeatureCard(context, 'Notifications', Icons.notifications,
                'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBw8NDg0NDQ8NDg8PDw8PEA8QDg8PEA4PFREWFhUWFRUYHSgsGholGxUVITEhJSkrLjA6Fx81ODMsNygtLisBCgoKBQUFDgUFDisZExkrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrK//AABEIAOEA4QMBIgACEQEDEQH/xAAcAAEAAQUBAQAAAAAAAAAAAAAAAQIDBQYHBAj/xABHEAACAgEBBAcEBAoIBgMAAAAAAQIDBBEFBhIhBxMxQVFhcRQigZEyUqHBIyRCYnJzgpKisRUzQ2NkssLRU5OjtNLhCCUm/8QAFAEBAAAAAAAAAAAAAAAAAAAAAP/EABQRAQAAAAAAAAAAAAAAAAAAAAD/2gAMAwEAAhEDEQA/AO4gAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMLvLvRibLgp5VnvyTddMEpXW6fVj4eb0Xmcv2z0sZtraw66sWHdKSV1vrz91emj9QO1A+b8rfDaVv8AWZ2Tz7oz6pfKGiPH/TGQ3q7Zy/SfE/mwPpwHzjh7y5NTXBfdX+hbOK+WvM2vY3STm1NK7gyod/ElXYl5SitPmmB2MGC3e3sxNoaRqk67dOdNmkZ+fD3SXp8dDOgAAAAAAAAAAAAAAAAAAAAAAAAAAANW3+3uhsmhcCjPKtTVNb7Fp22T0/JXh3vl4tbHm5UKKrL7ZKNdUJWTk/yYxWrfyRwjCx7949qWXWcUK21Kb7eox0/crj3cXd6uUvEDy7G2DnbbvsvnOT4pfhsq3mk/qxXe0uyK0S5di0OlbH3B2fjJcdXtM++d+klr5Q7NPVN+ZsWFiV49cKaYRrrguGMV2Jfe+9vvL4FirBpgtIU0xXhGuEV8kjzZmwcO9aXYuPPzdUFL4SS1RkQBoO2ujHHsTlhWSx591c27Kn8XzXrq/Q55tbZGVs6zq8mtw1+jJe9XZ5xku307fFH0CWM/Bqya5U31xtrl2xktV5NeD81zA4ThZSbjz4ZJppp6NNdjT7mdO3S32kuGjPlquShkPtXlZ4r875+JpW+W5lmzm76OK3Fb+k+c6G+xT8V4S+D88Lh7RaShN8uxPw8mB9IJ6pNc0+afiScs3F306iccPKl+Bk9K7JP+pk+yLf1H9np2dTAAAAAAAAAAAAAAAAAAAAAAAAA590zbWdODViweksuz3ufPqa9JS/ida9Gz0bgbFWFgVcS0tvSvt8U5L3Y/COnLxcvE1rpAj7fvBh4L0lCuNMJx8pN22/OvT5HSgAAAkAx9W28SeRLEjkVPIi2nVxe9qu1LubXelzQGRAAFNtcZxlCaUoyTjKMkmpRfJprvRxvfrdR7Pt62pOWJa9IdrdM+3q5Pw7dH961fZzzbRwa8qmzHujxV2R4ZL+TXg09Gn5AfPHWNcnz8/FHXeire72mH9H5Etbqo60zb521L8nzlH7V6M5lvBsezByLMaznKD1hLsVlb+jL0a5eTT8DHYmZPGtqvpk4WVTjZXLwkn3rw7mvVAfUQMXuztqvaOHRl18usj78e+uyL0nF+jT9eT7zKAAAAAAAAAAAAAAAAAAAAAAHJtmLrt6s+b59XGyS8uCuqj/UdENA3Wj/+h2y32pXr4O+v/ZG/gSJSSTbaSSbbb0SS7W2DVukvOdGzbIxejyJwx9fzZaymvjGEl8QMHtnpOUZyhg0xsjHkrrXJRm/GMFo9PNtehzlZNit69Sat6zrVPvVnFxcXz5lokD6C2LtanOohfROMk0uNJ8656auMl3NGQ0OH7qZ88GvOzq5NSjXXj1w/IndbJuMpLv4Y12S0PRsDZe1NoznkV33wcU5rJttuhGc0/oxku3v7FotAO0A0ro93ulnJ42S08iEOOE9EuvrXbql+WuWunb29zN1A1DpK2F7Vi+0VrW7FTny7Z0/lx+H0l6PxOKZ64ea7H9j7/n2/Bn001ryfNeZwXfTYnsuVk4qWkdesp/Vy5w+XOPwYGa6E95OpzLNnWS/B5ac6tX2ZEI80v0oJ/wDLXidxPj/EzbMe2rIpfDbTZC2tvXlOElJa+Wq5n1psfaMMzGx8ur+rvqrtj4pTino/PmB7AAAAAAAAAAAAAAAAAAAAAHLtjrq96NqV90qZy+MvZrF9kmb6aRtyPs29GJZ2RyqFGT8ZcFkEvnCv5o3cAaH0vP8AFcRf4lv5VSX3m+Gh9Ly/FcR/4hr/AKcv9gOWEkgDKYq48DLgu2vIxL2vzOG6pv4Sth8zcOjPbN9jnhylHqKMS6cIqKT4nbF6uXa/pS+ZpOyMyNFutkXOmyEqb4LRSlTP6XD+cmlJecUZzYuX/Qt9llkHkU5OPOum+p6Qti2mpR17/d0cG04/zDC7s5csfLwro8nG6rXzg2ozXxi2vifQBwvczZE8zMx4RTcKp123S092FcWno34vTRevkzuoA5/0tbO4q8bMiucJOmb8Yy96Dfo01+2dAMRvdhe0bPzKtNZdVKcF4zh78ftigPmfalXBdNd0veXx7ft1O79BG1XfsueNJ6yw8ida56vqrErIv5ymv2Tiu36+Vc/WP3r7zef/AI/5/BtDMxm+V+KrF+lTYl/K1/IDvIAAAAAAAAAAAAAAAAAAAADnfS9U6ls7aME3LFydGl3p6WR18tatP2jbq7IzjGcXrGSUovxi1qn8ijfDZXt2z8rGS1nKtyr/AFsHxw/iil8TXOjjaftOzqYt6zx28eXb2RSdf8DitfJgbQaF0u2r2fDr1953zml5Rraf+dG6bSyXRj33xg7HVVZYq09HNxi3wp+ehw/b227toXdfe1yXDCEdVCuHhFfzb7fkBjNCSRoBBs+4GVP26jEk+PGvlZ1tE4xnVNqmck+GSej1iua58jWTYuj5f/a4Xrd/29gHZsbGrpjwU111R7eGuEYR19EXiCQAa15PsfJ+gAHzZvJi9XG+v/g2uP7s3A9fRFkOrbuz9OSs9oql5xePZJL96Mfkevfqrhytpx/vrpfOTkYro45bZ2W/8QvthJfeB9RAAAAAAAAAAAAAAAAAAAAABzHHj/RG3rsd+7jbRSnX3RjY3JxX7/WQ0X14HTjUekrYLzcPraU/aMRu6px5ScV9OKfjolJecEBmzU9u7hYeVxTqTxbXq+KtJ1t/nV/+LRkd0NuLaGJXc2utj+DuS5aWpLVpeElpJeuncZsDie3N0M3C1lOvral/a06zil+cu2PxWnmYFH0RbFyjKKk4OUZJSXbFtaarzRxvPyanbZj7VxuC+uThLKxVGqxv606uUbE+T1XC9GBrZmtzMlU7SwrJPRdbwN/rIyrX+cu5G6l/UxysT8dxpcXDZVCSsXC2nxVPmmmmuWvYYL7Gn6NNAfRRJr+5m8C2hjJya9oqUYXx729OU0vCWjfrqu42AAASgODb9y1zNpv+8uXy5GN6M6uLbezI/wB9OX7tFk/9Jc3kyOtnmW9qtutkvSdr0+xmZ6FcDrNrK3Tlj49tmvhKWla+ycgO+gAAAAAAAAAAAAAAAAEANSlyDKGwK+McZZbLU5gc52tU939p+1VxfsGa9LYxWvVy1baSXfFtyivByS7NTfqrYzjGcJKUZJSjKL1Uotapp+Gh4du015VFmNkR4q7FpqvpQkvoyi/FPmaNuxt2eyb3s3Pl+Ltt03vlGvV8n5Vvnr9V692rQdKMbtfd/EzuF5NMZyitFNOUJpeHFFpteRkUyQLeJjQprhVVFQrglGMY9kUY3be7OHnau+pKx/21fuWr4/lftJmXAGn7s7lz2dmPIjkqdPVzhwcDjOSlpopc9NE0nr5dhuRBIAxm8+f7LhZV+uko1SUP1kvdh/E0ZM5t0p7ZUpVYFb14GrbtPrNe5F/BuXxiBzXaH0YwXe/sS/30Os9COyeqxcnMktHkWKuD8aqtea/blNfsnMsDZtmbk10UrWc5KuPgu+Un5Lm3+ifReysCGJj041S0hTCMI+L0XNvzb1b9QPYCCQAAAAAAAAAAAAAAAAKGUSLjLcgLUzy2yZ65IszgBispNpo0/efZHtEOF83HVwlp70H5eK8jfLajwZGKn3Ac73W3wt2bJYecpzx48oSXOdC8vrQ8u1d3gdSw8uu+uNtM4WVyWsZweqf/AL8jTNu7uV5EWpR590lyaNLVW0Nj2SsxpzUG9ZaLihNL/iQf8/tQHbgc62R0oVySjm0ShLvso9+D83CT1ivRyNkxt9tmWrVZdcfKyNlLX78UBsRJr2RvrsytavLrl5Vxsuf8CZrO2ukvVOGBS0+zrr0uXnGtPn6ya9GBtO9u8tezqu6eRNPqav8AXLwivt7Djc5WX2SlJysttk5Sk+blKT5v5vsPXg4WXtO+XArMi2bTssk+UfOcuyK8F8Eu46pulufTgaWzauyPrte7W/zF97+wCno+3TWBD2i+P4xZHRRf9jW+en6T5a/Lx13NFqLK0wK0SUoqAkEEgAAAAAAAAAAAIJIAhlDK2UsChoocS60UtAWJQLE6j2NFLiBi7cfUx2XgKSeqNhlWWJ0gc12zufVY3KC6uXjHkn6o1TL3duqfPmvHQ7Vdia9xjsjZyfdqByvZu77ukoyujVr3uty+9G57K6P8WOkrrbMjyX4KD9Um39pkZbATesVo/DuMrg1zq0jLX1AyGBiVUQVdNcK4LsjCKitfH18z3QZZpep6IxArTK0yhIrQFaKkUIrQEkkEgAAAAAAAAAAAAAEEEgCkpaKyAKGilouaEaAWmilxLzRS0BYlAtyqPU0UuIHk6klVHp4RwgW64F6KIUS5EAkVJBIqSAJEoaEgCQAAAAAAAAAAAAAAAQSAIIJAEEaFRAFOhGhXoRoBRoRoXNCNAKNBoV6DQCjQlIq0J0AIqIRIAkAAAAAAAAAAAAAAAAAAAABAAAAAQAAAAAgAASAAJJAAAAAAAAAAAAD/2Q==', () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const NotificationPage()));
            }),
            _buildFeatureCard(context, 'Order Status', Icons.check_circle,
                'https://www.shutterstock.com/image-vector/order-delivery-status-post-parcel-260nw-2303714819.jpg', () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const OrderStatusPage()));
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
            Image.network(imagePath, height: 50, width: 50, fit: BoxFit.contain),
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
                context, MaterialPageRoute(builder: (_) => const SalesReportPage()));
            break;
          case 2:
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const ProfilePage()));
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
      'image': '', // Add image path for each product
    },
    {
      'date': '2024-11-16',
      'product': 'Butter',
      'quantity': 10,
      'totalAmount': 150.0,
      'image': 'assets/images/butter.png',
    },
    {
      'date': '2024-11-17',
      'product': 'Cheese',
      'quantity': 15,
      'totalAmount': 225.0,
      'image': 'assets/images/cheese.png',
    },
  ];

  const SalesReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Calculate Total Sales and Total Items Sold
    double totalSales = salesData.fold(0.0, (sum, sale) {
      return sum + (sale['totalAmount'] as double);
    });

    int totalItemsSold = salesData.fold(0, (sum, sale) {
      return sum + (sale['quantity'] as int); // Ensure type safety
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3EA120),
        title: const Text('Sales Report'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Sales Summary Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  // Add an image for the summary section
                  Image.asset(
                    'assets/images/sales_summary.png', // Placeholder image for summary
                    width: 60,
                    height: 60,
                  ),
                  const SizedBox(width: 16),
                  // Display Total Sales and Items Sold
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sales Summary',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text('Total Sales: ₹${totalSales.toStringAsFixed(2)}'),
                      Text('Total Items Sold: $totalItemsSold'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Sales List Section
            Expanded(
              child: ListView.builder(
                itemCount: salesData.length,
                itemBuilder: (context, index) {
                  final sale = salesData[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      leading: Image.asset(
                        sale['image'], // Use the image path from the sales data
                        width: 50,
                        height: 50,
                      ),
                      title: Text(
                        'Date: ${sale['date']}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Product: ${sale['product']}'),
                          Text('Quantity: ${sale['quantity']}'),
                          Text(
                            'Total Amount: ₹${sale['totalAmount'].toStringAsFixed(2)}',
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
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

  const UserAccountPage({super.key});

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

  const OrderManagementPage({super.key});

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
          'assets/images/fresh_milk.png', // Replace with actual asset paths
    },
    {
      'name': 'Cheese',
      'price': 120.0,
      'image': 'assets/images/cheese.png',
    },
    {
      'name': 'Butter',
      'price': 90.0,
      'image': 'assets/images/butter.png',
    },
    {
      'name': 'Yogurt',
      'price': 60.0,
      'image': 'assets/images/yogurt.png',
    },
  ];

  const ProductCatalogPage({super.key});

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
              child: Image.asset(
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

  const OrderStatusPage({super.key});

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
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: OrderStatusPage(),
  ));
}

//import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3EA120),
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Picture Section
              Center(
                child: Stack(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        'https://via.placeholder.com/150', // Placeholder Image URL
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Colors.green, width: 2),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Color(0xFF3EA120),
                          ),
                          onPressed: () {
                            // Add image picker logic
                            print('Edit Profile Picture');
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // User Details Section
              const Text(
                'John Doe',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'johndoe@example.com',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),

              // Editable Profile Fields
              _buildEditableField(
                context: context,
                label: 'Full Name',
                initialValue: 'John Doe',
              ),
              _buildEditableField(
                context: context,
                label: 'Email',
                initialValue: 'johndoe@example.com',
              ),
              _buildEditableField(
                context: context,
                label: 'Phone Number',
                initialValue: '+1234567890',
              ),
              _buildEditableField(
                context: context,
                label: 'Address',
                initialValue: '1234 Elm Street',
              ),

              const SizedBox(height: 20),

              // Save and Logout Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3EA120),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // Save logic here
                      print('Profile Saved');
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // Logout logic here
                      print('User Logged Out');
                    },
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

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

  const NotificationPage({super.key});

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
