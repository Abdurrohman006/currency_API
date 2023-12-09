import 'package:country_flags/country_flags.dart';
import 'package:currency_api/data/model/currency_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

final dio = Dio();

Future<List> getDataFromApi() async {
  final response = await dio.get('https://nbu.uz/en/exchange-rates/json/');
  List currencies = response.data
      .map((current_currency) => Currency.fromJson(current_currency))
      .toList();
  print(currencies[0].title);
  return currencies;
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exchange rate currency UZS"),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: getDataFromApi(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // connectionState bu ma'umot kegungacha bo'gan voht
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              // hasData bu ma'umot keboganini bildiradi

              List data = snapshot.data!;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.white70,
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CountryFlag.fromCountryCode(
                        data[index].code.substring(0, 2),
                        width: 100,
                        height: 50,
                      ),
                      Text("1 ${data[index].title}"),
                      Text("${data[index].cb_price} UZS"),
                    ],
                  ),
                ),
              );
            }
            if (snapshot.hasError) {
              // hasError bu Error chiqsa ishlidi
              return const Center(
                child: Text("Error bor"),
              );
            }
            return const Text("Ma'umot keldi");
          },
        ),
      ),
    );
  }
}
