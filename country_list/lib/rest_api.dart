import 'dart:convert';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<List<Country>> fetchCountry(http.Client client) async {
  final response = await client.get(Uri.parse('https://restcountries.com/v3.1/all'));

  // using the compute function to run parseCountry in a separate isolate
  return compute(parseCountry, response.body);
}

// This function converts a response body into a List<Country>
List<Country> parseCountry(String responseBody) {

  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  // if return json is Object of Country
  //return parsed.map<Country>((json) => Country.fromJson(json));
  // return json is List of Country
  return parsed.map<Country>((json) => Country.fromJson(json)).toList();
}

class Country {
  CountryName? name;
  List<String>? capital;
  int? population;
  CountryFlag? flag;
  Currency? currency;

  Country({
    this.name,
    this.capital,
    this.population,
    this.flag,
    this.currency
  });

  Country.fromJson(Map<String, dynamic> json) {

    name = CountryName.fromJson(json['name']);
    if(json['capital'] != null){
      capital =[];
      if(json['capital'].isNotEmpty) {
        json['capital'].forEach((v) => capital?.add(v));
      }
    }
    population = json['population'];
    flag = CountryFlag.fromJson(json['flags']);

    // currency is an Map<String, dynamic>
    if(json['currencies'] != null) {
      Map<String,dynamic> raw = json['currencies'];
      for (var element in raw.values) {
        currency = Currency.fromJson(element);
      }
    }
  }
}

class CountryName {
  String? common;
  String? official;

  CountryName({
    this.common,
    this.official
  });

  CountryName.fromJson(Map<String, dynamic> json) {
    common = json["common"];
    official = json["official"];
  }
}

class CountryFlag {
  String? png;
  String? svg;

  CountryFlag({
    this.png,
    this.svg
  });

  CountryFlag.fromJson(Map<String, dynamic> json) {
    png = json["png"];
    svg = json["svg"];
  }
}

class Currency {
  String? name;
  String? symbol;

  Currency({
    this.name,
    this.symbol
  });

  Currency.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    symbol = json["symbol"];
  }
}