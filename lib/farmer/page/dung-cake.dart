import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DungForm(),
    );
  }
}

class DungForm extends StatefulWidget {
  @override
  _DungFormState createState() => _DungFormState();
}

class _DungFormState extends State<DungForm> {
  final _formKey = GlobalKey<FormState>();
  String _dungType = 'Cow Dung';
  double _quantity = 0;
  final _quantityController = TextEditingController();

  // Function to handle form submission
  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final quantity = _quantityController.text;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Dung Type: $_dungType, Quantity: $quantity'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dung Quantity Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Please provide details of the dung you need:',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _dungType,
                decoration: InputDecoration(labelText: 'Dung Type'),
                onChanged: (value) {
                  setState(() {
                    _dungType = value!;
                  });
                },
                items: ['Cow Dung', 'Chicken Dung', 'Goat Dung']
                    .map((dung) => DropdownMenuItem<String>(
                          value: dung,
                          child: Text(dung),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a dung type';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(
                  labelText: 'Quantity of Dung (in kilograms)',
                  hintText: 'e.g., 15 kg',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the quantity';
                  }
                  final quantity = double.tryParse(value);
                  if (quantity == null || quantity <= 0) {
                    return 'Please enter a valid quantity';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}