import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_api/CountryStats.dart';

class CovidStatsPage extends StatefulWidget {
  @override
  _CovidStatsPageState createState() => _CovidStatsPageState();
}

class _CovidStatsPageState extends State<CovidStatsPage> {
  late Future<List<CountryStats>> statsFuture;

  @override
  void initState() {
    super.initState();
    statsFuture = fetchCovidStats();
  }

  Future<List<CountryStats>> fetchCovidStats() async {
    final response = await http.get(Uri.parse('https://disease.sh/v3/covid-19/countries'));

    if (response.statusCode == 200) {
      List jsonData = json.decode(response.body);
      return jsonData.map((e) => CountryStats.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('API Integration')),
      body: FutureBuilder<List<CountryStats>>(
        future: statsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          else if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else if (snapshot.hasData) {
            final countries = snapshot.data!;
            return ListView.builder(
              itemCount: countries.length,
              itemBuilder: (context, index) {
                final country = countries[index];
                return ListTile(
                  leading: Image.network(country.flagUrl, width: 40),
                  title: Text(country.name),
                  subtitle: Text('Cases: ${country.cases}'),
                );
              },
            );
          } else {
            return Center(child: Text('No data found.'));
          }
        },
      ),
    );
  }
}


