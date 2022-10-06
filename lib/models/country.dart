class Country {
  final String name;
  final Idd callingCodes;
  final String flag;

  Country({required this.name, required this.callingCodes, required this.flag});

  static Country? fromJson(Map<String, dynamic> json) {
    final idd = json['idd'] as Map<String, dynamic>;
    if(idd.isNotEmpty) {
      return Country(
          name: json['name']['official'],
          callingCodes: Idd.fromJson(idd),
          flag: json['flags']['svg']);
    } else {
      return null;
    }
  }
}

class Idd {
  final String root;
  final List<String> suffixes;

  Idd({required this.root, required this.suffixes});

  static fromJson(Map<String, dynamic> json) {
    return Idd(
        root: json['root'],
        suffixes: List.from(json['suffixes'])
    );
  }
}