import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class Medalist {
  final String skill;
  final String portrait;
  final String name;

  Medalist({
    required this.skill,
    required this.portrait,
    required this.name,
  });

  factory Medalist.fromJson(Map<String, dynamic> json) {
    return Medalist(
      skill: json['skill'],
      portrait: json['portrait'],
      name: json['name'],
    );
  }
}

class CountryData {
  final String member;
  final int rank;
  final int gold;
  final int silver;
  final int bronze;
  final int excellence;
  final List<Medalist> goldMedals;
  final List<Medalist> silverMedals;
  final List<Medalist> bronzeMedals;

  CountryData({
    required this.member,
    required this.rank,
    required this.gold,
    required this.silver,
    required this.bronze,
    required this.excellence,
    required this.goldMedals,
    required this.silverMedals,
    required this.bronzeMedals,
  });

  factory CountryData.fromJson(Map<String, dynamic> json) {
    List<Medalist> parseMedalists(List<dynamic> medalists) {
      return medalists.map((data) => Medalist.fromJson(data)).toList();
    }

    return CountryData(
      member: json['member'],
      rank: json['rank'],
      gold: json['gold'],
      silver: json['silver'],
      bronze: json['bronze'],
      excellence: json['excellence'],
      goldMedals: parseMedalists(json['gold_medals']),
      silverMedals: parseMedalists(json['silver_medals']),
      bronzeMedals: parseMedalists(json['bronze_medals']),
    );
  }
}

class MyApp extends StatelessWidget {
  Future<String> _loadCountryDataAsset() async {
    return await rootBundle.loadString('data/result.json');
  }

  Future<CountryData> _parseCountryData(String jsonString) async {
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    return CountryData.fromJson(jsonData);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Medalists'),
        ),
        body: FutureBuilder(
          future: _loadCountryDataAsset(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error loading data'),
                );
              } else {
                final String jsonString = snapshot.data as String;
                return FutureBuilder(
                  future: _parseCountryData(jsonString),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text('Error parsing data'),
                        );
                      } else {
                        final CountryData countryData =
                            snapshot.data as CountryData;
                        return ListView.builder(
                          itemCount: countryData.goldMedals.length,
                          itemBuilder: (context, index) {
                            Medalist medalist = countryData.goldMedals[index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: AssetImage(medalist.portrait),
                              ),
                              title: Text(medalist.name),
                              subtitle: Text(medalist.skill),
                            );
                          },
                        );
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
