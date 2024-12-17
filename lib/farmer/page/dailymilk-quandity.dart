import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MilkForm(),
    );
  }
}

class MilkForm extends StatefulWidget {
  @override
  _MilkFormState createState() => _MilkFormState();
}

class _MilkFormState extends State<MilkForm> {
  final _formKey = GlobalKey<FormState>();
  String _milkType = 'Cow milk';
  double _quantity = 0;
  final _quantityController = TextEditingController();

  // Function to handle form submission
  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final quantity = _quantityController.text;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Milk Type: $_milkType, Quantity: $quantity'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Milk Quantity Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Please provide details of the milk you need:',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _milkType,
                decoration: InputDecoration(labelText: 'Milk Type'),
                onChanged: (value) {
                  setState(() {
                    _milkType = value!;
                  });
                },
                items: ['Cow milk', 'Goat milk', ]
                    .map((milk) => DropdownMenuItem<String>(
                          value: milk,
                          child: Text(milk),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a milk type';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(
                  labelText: 'Quantity of Milk (in liters)',
                  hintText: 'e.g., 2.5 liters',
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