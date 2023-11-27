class Auditory {
  final int id;
  final String number;

  Auditory({
    required this.id,
    required this.number,
  });

  factory Auditory.fromJson(Map<String, dynamic> json) {
    return Auditory(
      id: json['uid'],
      number: json['number'],
    );
  }
}
