import 'package:flutter/material.dart';
import 'package:flutter_currency_convert_app/components/any_to_any.dart';
import 'package:flutter_currency_convert_app/components/usd_to_any.dart';
import 'package:flutter_currency_convert_app/functions/fetchrates.dart';
import 'package:flutter_currency_convert_app/models/ratesmodel.dart';

class HomePage extends StatefulWidget {
  const new({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // initial variables
  late Future<RatesModel> result;
  late Future<Map> allCurrencies;
  final formkey = GlobalKey<FormState>();

  // getting ratesmodel and all currencies
  @override
  void initState() {
    super.initState();
    setState(() {
      result = fetchrates();
      allCurrencies = fetchcurrencies();
    });
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.widthOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Open Exchange'),
        backgroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: FutureBuilder<RatesModel>(
            future: result,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return Center(
                child: FutureBuilder<Map>(
                  future: allCurrencies,
                  builder: (context, currencysnapshot) {
                    if (currencysnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return Column(
                      mainAxisAlignment: .center,
                      children: [
                        UsdToAny(
                          rates: snapshot.data!.rates,
                          currencies: currencysnapshot.data!,
                        ),
                        AnyToAny(
                          rates: snapshot.data!.rates,
                          currencies: currencysnapshot.data!,
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
