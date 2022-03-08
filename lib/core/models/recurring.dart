class Recurring {
  int id;
  String startAt;
  String endAt;
  bool isAvailable;

  Recurring({this.id, this.startAt, this.endAt, this.isAvailable});

  factory Recurring.fromJson(Map<String, dynamic> json) => Recurring(
        id: json['id'],
        startAt: json['start_at'],
        endAt: json['end_at'],
        isAvailable: json['is_available'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'start_at': startAt,
        'end_at': endAt,
        'is_available': isAvailable,
      };
}
