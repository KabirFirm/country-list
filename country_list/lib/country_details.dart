import 'dart:convert';

import 'package:country_list/rest_api.dart';
import 'package:flutter/material.dart';

class CountryDetails extends StatelessWidget {
  const CountryDetails({Key? key, required this.country}) : super(key: key);

  final Country country;

  @override
  Widget build(BuildContext context) {
    String capital = country.capital?[0] ?? "";
    return Scaffold(
      appBar: AppBar(
        title: Text('${country.name?.common}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Population: ${country.population}'),
            Text('Capital: $capital'),
            Text('Currency: ${country.currency?.name}, ${country.currency?.symbol}'),
          ],
        ),
      ),
    );
  }
}
