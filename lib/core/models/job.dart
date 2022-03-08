import 'package:job/core/models/recurring.dart';

class Job {
  int id;
  String status;
  String startAt;
  String endAt;
  String postName;
  int postId;
  bool startSoon;
  Recurring recurring;
  String company;
  String buyPrice;
  int bonus;
  double latitude;
  double longitude;

  Job(
      {this.id,
      this.status,
      this.startAt,
      this.endAt,
      this.postName,
      this.postId,
      this.startSoon,
      this.recurring,
      this.company,
      this.buyPrice,
      this.bonus,
      this.latitude,
      this.longitude});

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json['id'],
        status: json['status'],
        startAt: json['start_at'],
        endAt: json['end_at'],
        postName: json['post_name'],
        postId: json['post_id'],
        startSoon: json['start_soon'],
        recurring: json['recurring'] != null
            ? Recurring.fromJson(json['recurring'])
            : null,
        company: json['company'],
        buyPrice: json['buy_price'],
        bonus: json['bonus'],
        latitude: json['latitude'],
        longitude: json['longitude'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
        'start_at': startAt,
        'end_at': endAt,
        'post_name': postName,
        'post_id': postId,
        'start_soon': startSoon,
        'recurring': recurring != null ? recurring.toJson() : null,
        'company': company,
        'buy_price': buyPrice,
        'bonus': bonus,
        'latitude': latitude,
        'longitude': longitude,
      };
}
