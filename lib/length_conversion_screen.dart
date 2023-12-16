import 'package:flutter/material.dart';

class LengthConversionScreen extends StatefulWidget {
  @override
  _LengthConversionScreenState createState() => _LengthConversionScreenState();
}

class _LengthConversionScreenState extends State<LengthConversionScreen> {
  TextEditingController _inputController = TextEditingController();
  String _selectedFromUnit = 'cm';
  String _selectedToUnit = 'meter';
  String _result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Length Conversion'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/ruler.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Enter length:',
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
                      items: <String>['cm', 'meter', 'km', 'mile'].map((String value) {
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
                      items: <String>['cm', 'meter', 'km', 'mile'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 26),
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
    if (_selectedFromUnit == 'cm' && _selectedToUnit == 'meter') {
      convertedValue = inputValue / 100;
    } else if (_selectedFromUnit == 'meter' && _selectedToUnit == 'cm') {
      convertedValue = inputValue * 100;
    } else if (_selectedFromUnit == 'cm' && _selectedToUnit == 'km') {
      convertedValue = inputValue / 100000;
    } else if (_selectedFromUnit == 'km' && _selectedToUnit == 'cm') {
      convertedValue = inputValue * 100000;
    } else if (_selectedFromUnit == 'cm' && _selectedToUnit == 'mile') {
      convertedValue = inputValue / 160934.4;
    } else if (_selectedFromUnit == 'mile' && _selectedToUnit == 'cm') {
      convertedValue = inputValue * 160934.4;
    } else if (_selectedFromUnit == 'meter' && _selectedToUnit == 'km') {
      convertedValue = inputValue / 1000;
    } else if (_selectedFromUnit == 'km' && _selectedToUnit == 'meter') {
      convertedValue = inputValue * 1000;
    } else if (_selectedFromUnit == 'meter' && _selectedToUnit == 'mile') {
      convertedValue = inputValue / 1609.344;
    } else if (_selectedFromUnit == 'mile' && _selectedToUnit == 'meter') {
      convertedValue = inputValue * 1609.344;
    } else if (_selectedFromUnit == 'km' && _selectedToUnit == 'mile') {
      convertedValue = inputValue / 1.609344;
    } else if (_selectedFromUnit == 'mile' && _selectedToUnit == 'km') {
      convertedValue = inputValue * 1.609344;
    } else {
      convertedValue = inputValue;
    }

    setState(() {
      _result = '${inputValue.toString()} $_selectedFromUnit is equal to ${convertedValue.toStringAsFixed(4)} $_selectedToUnit.';
    });
  }
}
