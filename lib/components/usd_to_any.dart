import 'package:flutter/material.dart';
import 'package:flutter_currency_convert_app/functions/fetchrates.dart';

class UsdToAny extends StatefulWidget {
  final rates;
  final Map currencies;
  const new({super.key, required this.rates, required this.currencies});

  @override
  State<UsdToAny> createState() => _UsdToAnyState();
}

class _UsdToAnyState extends State<UsdToAny> {
  final TextEditingController usdController = TextEditingController();
  String dropdownValue = 'BDT';
  String answer = 'Converted Currency will be shown here:)';

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.sizeOf(context).width;
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            Text(
              'USD to Any Currency',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            SizedBox(height: 20),

            // textfield for enteriing usd
            TextFormField(
              key: ValueKey('usd'),
              controller: usdController,
              decoration: InputDecoration(hintText: 'Enter USD'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                // futre builder for currencies for dropdown list
                Expanded(
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: Icon(Icons.arrow_drop_down_rounded),
                    iconSize: 20,
                    elevation: 15,
                    isExpanded: true,
                    underline: Container(height: 2, color: Colors.grey),
                    items: widget.currencies.keys
                        .toSet()
                        .toList()
                        .map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        })
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                  ),
                ),
                SizedBox(width: 10),

                // convert button
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        answer =
                            usdController.text +
                            'USD = ' +
                            convertusd(
                              widget.rates,
                              usdController.text,
                              dropdownValue,
                            ) +
                            '' +
                            dropdownValue;
                      });
                    },
                    child: Text('Convert'),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
            // final output
            SizedBox(height: 10),
            SizedBox(child: Text(answer)),
          ],
        ),
      ),
    );
  }
}
