import 'package:flutter/material.dart';

class AnyToAny extends StatefulWidget {
  final rates;
  final Map currencies;
  const new({super.key, required this.rates, required this.currencies});

  @override
  State<AnyToAny> createState() => _AnyToAnyState();
}

class _AnyToAnyState extends State<AnyToAny> {
  final TextEditingController amountController = TextEditingController();
  String dropdownValue1 = 'AUD';
  String dropdownValue2 = 'AUD';
  String answer = 'Converted Currency will be shown here :)';
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.widthOf(context);
    return Card(
      child: Container(
        // width = w/3
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            Text(
              'Convert Any Currency',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // textfields for entering
            TextFormField(
              key: ValueKey('amount'),
              controller: amountController,
              decoration: InputDecoration(hintText: 'Enter Amount'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: DropdownButton(
                    value: dropdownValue1,
                    icon: Icon(Icons.arrow_drop_down_outlined),
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
                        dropdownValue1 = newValue!;
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text('To'),
                ),
                Expanded(
                  child: DropdownButton(
                    value: dropdownValue2,
                    icon: Icon(Icons.arrow_drop_down_outlined),
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
                        dropdownValue1 = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    answer =
                        '${amountController.text}' +
                        convertany(
                          widget.rates,
                          amountController.text,
                          dropdownValue1,
                          dropdownValue2,
                        ) +
                        '' +
                        dropdownValue2;
                  });
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    Theme.of(context).primaryColor,
                  ),
                ),
                child: Text('Convert'),
              ),
            ),
            SizedBox(child: Text('Answer')),
          ],
        ),
      ),
    );
  }
}
