class Phone {
  final String code;
  final String number;

  Phone({
    required this.code,
    required this.number,
  });

  factory Phone.fromJson(Map<String, dynamic> json) => Phone(
        code: json["code"],
        number: json["number"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "number": number,
      };
}
