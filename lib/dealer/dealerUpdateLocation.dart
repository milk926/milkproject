// ignore: file_names
import 'package:flutter/material.dart';
import 'dart:ui';

class UpdateLocationPage extends StatefulWidget {
  const UpdateLocationPage({super.key});

  @override
  State<UpdateLocationPage> createState() => _UpdateLocationPageState();
}

class _UpdateLocationPageState extends State<UpdateLocationPage> {
  final List<String> districts = [
    'Thiruvananthapuram',
    'Kollam',
    'Pathanamthitta',
    'Alappuzha',
    'Kottayam',
    'Idukki',
    'Ernakulam',
    'Thrissur',
    'Palakkad',
    'Malappuram',
    'Kozhikode',
    'Wayanad',
    'Kannur',
    'Kasaragod',
  ];

  final Map<String, List<String>> localities = {
    'Kannur': [
      'Anjarakkandy',
      'Chavassery',
      'Thalassery',
      'Payyannur',
      'Mattannur',
      'Iritty'
    ],
    'Thiruvananthapuram': [
      'Kazhakoottam',
      'Neyyattinkara',
      'Attingal',
      'Varkala',
      'Pothencode'
    ],
    'Kollam': ['Chathannoor', 'Karunagappally', 'Paravur', 'Punalur', 'Anchal'],
    'Pathanamthitta': [
      'Adoor',
      'Thiruvalla',
      'Pandalam',
      'Ranni',
      'Mallappally'
    ],
    'Alappuzha': [
      'Cherthala',
      'Haripad',
      'Kayamkulam',
      'Mavelikkara',
      'Ambalapuzha'
    ],
    'Kottayam': [
      'Changanassery',
      'Pala',
      'Ettumanoor',
      'Vaikom',
      'Kaduthuruthy'
    ],
    'Idukki': ['Thodupuzha', 'Nedumkandam', 'Peermade', 'Munnar', 'Adimali'],
    'Ernakulam': [
      'Kochi',
      'Perumbavoor',
      'Aluva',
      'Muvattupuzha',
      'North Paravur'
    ],
    'Thrissur': [
      'Guruvayur',
      'Kodungallur',
      'Chalakudy',
      'Irinjalakuda',
      'Kunnamkulam'
    ],
    'Palakkad': ['Ottapalam', 'Chittur', 'Mannarkkad', 'Alathur', 'Nenmara'],
    'Malappuram': [
      'Manjeri',
      'Perinthalmanna',
      'Tirur',
      'Nilambur',
      'Kondotty'
    ],
    'Kozhikode': [
      'Vadakara',
      'Koyilandy',
      'Balussery',
      'Feroke',
      'Ramanattukara'
    ],
    'Wayanad': [
      'Kalpetta',
      'Sulthan Bathery',
      'Mananthavady',
      'Meenangadi',
      'Vythiri'
    ],
    'Kasaragod': [
      'Kanhangad',
      'Nileshwaram',
      'Kasaragod Town',
      'Bekal',
      'Manjeshwar'
    ]
  };

  String? selectedDistrict;
  String? selectedLocality;
  String? pincode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Location'),
        backgroundColor: Colors.green.shade800,
      ),
      body: Stack(
        children: [
          // Background Blur Effect
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/green_background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ),
          // Main Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'State: Kerala',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(73, 255, 41, 0.705),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedDistrict,
                  decoration: InputDecoration(
                    labelText: 'Select District',
                    labelStyle:
                        const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  items: districts
                      .map((district) => DropdownMenuItem(
                            value: district,
                            child: Text(district),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedDistrict = value;
                      selectedLocality = null;
                    });
                  },
                ),
                const SizedBox(height: 16),
                if (selectedDistrict != null)
                  DropdownButtonFormField<String>(
                    value: selectedLocality,
                    decoration: InputDecoration(
                      labelText: 'Select Locality',
                      labelStyle:
                          const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    items: localities[selectedDistrict!]
                        ?.map((locality) => DropdownMenuItem(
                              value: locality,
                              child: Text(locality),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedLocality = value;
                      });
                    },
                  ),
                const SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Enter Pincode',
                    labelStyle:
                        const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    pincode = value;
                  },
                ),
                const SizedBox(height: 32),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 3, 241, 15),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      if (selectedDistrict != null &&
                          selectedLocality != null &&
                          pincode != null &&
                          pincode!.length == 6) {
                        _showConfirmationDialog(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill all fields correctly'),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Save Changes',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Changes'),
        content: const Text('Are you sure you want to save the changes?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Location updated successfully!'),
                ),
              );
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
