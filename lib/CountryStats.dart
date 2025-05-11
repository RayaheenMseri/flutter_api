class CountryStats {
  final String name;
  final int cases;
  final String flagUrl;

  CountryStats({required this.name, required this.cases, required this.flagUrl});

  factory CountryStats.fromJson(Map<String, dynamic> json) {
    return CountryStats(
      name: json['country'],
      cases: json['cases'],
      flagUrl: json['countryInfo']['flag'],
    );
  }
}