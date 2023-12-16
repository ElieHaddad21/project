import 'package:flutter/material.dart';

class WeightConversionScreen extends StatefulWidget {
  @override
  _WeightConversionScreenState createState() => _WeightConversionScreenState();
}

class _WeightConversionScreenState extends State<WeightConversionScreen> {
  TextEditingController _inputController = TextEditingController();
  String _selectedFromUnit = 'g';
  String _selectedToUnit = 'kg';
  String _result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weight Conversion'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/scale.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Enter weight:',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _inputController,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  convert();
                },
              ),
              SizedBox(height: 16),
              Row(
                children: <Widget>[
                  Expanded(
                    child: DropdownButton<String>(
                      value: _selectedFromUnit,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedFromUnit = newValue!;
                          convert();
                        });
                      },
                      items: <String>['g', 'kg', 'lbs'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        String temp = _selectedFromUnit;
                        _selectedFromUnit = _selectedToUnit;
                        _selectedToUnit = temp;
                        convert();
                      });
                    },
                    icon: Icon(Icons.swap_horiz),
                  ),
                  Expanded(
                    child: DropdownButton<String>(
                      value: _selectedToUnit,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedToUnit = newValue!;
                          convert();
                        });
                      },
                      items: <String>['g', 'kg', 'lbs'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                _result,
                style: TextStyle(fontSize: 19, color: Colors.black),
              ),

            ],
          ),
        ),
      ),
    );
  }

  void convert() {
    double inputValue = double.tryParse(_inputController.text) ?? 0;
    double convertedValue;

    // Conversion logic based on selected units
    if (_selectedFromUnit == 'g' && _selectedToUnit == 'kg') {
      convertedValue = inputValue / 1000;
    } else if (_selectedFromUnit == 'kg' && _selectedToUnit == 'g') {
      convertedValue = inputValue * 1000;
    } else if (_selectedFromUnit == 'g' && _selectedToUnit == 'lbs') {
      convertedValue = inputValue / 453.592;
    } else if (_selectedFromUnit == 'lbs' && _selectedToUnit == 'g') {
      convertedValue = inputValue * 453.592;
    } else if (_selectedFromUnit == 'kg' && _selectedToUnit == 'lbs') {
      convertedValue = inputValue * 2.20462;
    } else if (_selectedFromUnit == 'lbs' && _selectedToUnit == 'kg') {
      convertedValue = inputValue / 2.20462;
    } else {
      convertedValue = inputValue;
    }

    setState(() {
      _result = '${inputValue.toString()} $_selectedFromUnit is equal to ${convertedValue.toStringAsFixed(4)} $_selectedToUnit.';
    });
  }
}
