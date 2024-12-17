import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: UpdateLocationPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class UpdateLocationPage extends StatefulWidget {
  @override
  _UpdateLocationPageState createState() => _UpdateLocationPageState();
}

class _UpdateLocationPageState extends State<UpdateLocationPage> {
  // Mocked list of delivery statuses
  final List<Map<String, String>> _deliveryUpdates = [
    {
      'time': '08:30 AM',
      'status': 'Order Placed',
      'location': 'Warehouse, City A',
    },
    {
      'time': '10:00 AM',
      'status': 'Out for Delivery',
      'location': 'Delivery Hub, City B',
    },
    {
      'time': '12:45 PM',
      'status': 'Near Destination',
      'location': 'Local Facility, City C',
    },
    {
      'time': '02:00 PM',
      'status': 'Delivered',
      'location': 'Customer Location, City D',
    },
  ];

  Future<List<Map<String, String>>> _fetchDeliveryUpdates() async {
    // Simulate a network call delay
    await Future.delayed(Duration(seconds: 2));
    return _deliveryUpdates;
  }

  // Method to update the delivery details
  void _updateDeliveryDetails(int index, String status, String location) {
    setState(() {
      _deliveryUpdates[index]['status'] = status;
      _deliveryUpdates[index]['location'] = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery Status'),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<List<Map<String, String>>>(
        future: _fetchDeliveryUpdates(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching data'));
          } else {
            final updates = snapshot.data ?? [];
            return ListView.builder(
              itemCount: updates.length,
              itemBuilder: (context, index) {
                final update = updates[index];
                return DeliveryStatusCard(
                  time: update['time']!,
                  status: update['status']!,
                  location: update['location']!,
                  isLast: index == updates.length - 1,
                  onUpdate: (status, location) {
                    _updateDeliveryDetails(index, status, location);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class DeliveryStatusCard extends StatefulWidget {
  final String time;
  final String status;
  final String location;
  final bool isLast;
  final Function(String, String) onUpdate;

  const DeliveryStatusCard({
    required this.time,
    required this.status,
    required this.location,
    required this.onUpdate,
    this.isLast = false,
  });

  @override
  _DeliveryStatusCardState createState() => _DeliveryStatusCardState();
}

class _DeliveryStatusCardState extends State<DeliveryStatusCard> {
  late TextEditingController _statusController;
  late TextEditingController _locationController;

  @override
  void initState() {
    super.initState();
    _statusController = TextEditingController(text: widget.status);
    _locationController = TextEditingController(text: widget.location);
  }

  @override
  void dispose() {
    _statusController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              height: 12,
              width: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueAccent,
              ),
            ),
            if (!widget.isLast)
              Container(
                width: 2,
                height: 60,
                color: Colors.blueAccent,
              ),
          ],
        ),
        Expanded(
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.time,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  TextField(
                    controller: _statusController,
                    decoration: InputDecoration(
                      labelText: 'Status',
                      labelStyle: TextStyle(color: Colors.green[700]),
                    ),
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 4),
                  TextField(
                    controller: _locationController,
                    decoration: InputDecoration(
                      labelText: 'Location',
                      labelStyle: TextStyle(color: Colors.black54),
                    ),
                    style: TextStyle(fontSize: 13),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      widget.onUpdate(
                          _statusController.text, _locationController.text);
                    },
                    child: Text('Update Details'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
