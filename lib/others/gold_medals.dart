class GoldMedals {
  final String skill;
  final String portrait;
  final String name;

  GoldMedals({
    required this.skill,
    required this.portrait,
    required this.name,
  });

  factory GoldMedals.fromJson(Map<String, dynamic> json) {
    return GoldMedals(
      skill: json["skill"] as String,
      portrait: json["portrait"] as String,
      name: json["name"] as String,
    );
  }
}
