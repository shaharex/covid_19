import 'package:covid_19/others/gold_medals.dart';

class Result {
  final String member;
  final int rank;
  final int gold;
  final int silver;
  final int bronze;
  final int excellence;
  final List<GoldMedals> goldMedals;

  Result({
    required this.member,
    required this.rank,
    required this.gold,
    required this.silver,
    required this.bronze,
    required this.excellence,
    required this.goldMedals,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      member: json["member"] as String,
      rank: json["rank"] as int,
      gold: json["gold"] as int,
      silver: json["silver"] as int,
      bronze: json["bronze"] as int,
      excellence: json["excellence"] as int,
      goldMedals: (json["goldMedals"] as List<dynamic>)
          .map((dynamic e) => GoldMedals.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
