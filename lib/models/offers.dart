// ignore_for_file: prefer_null_aware_operators

import 'job.dart';
import 'links.dart';
import 'meta.dart';

class JobOffers {
  List<Job> jobs;
  Links links;
  Meta meta;

  JobOffers({this.jobs, this.links, this.meta});

  factory JobOffers.fromJson(Map<String, dynamic> json) => JobOffers(
      jobs: json['data'] != null
          ? (json['data'] as List).map((v) => Job.fromJson(v)).toList()
          : null,
      links: json['links'] != null ? Links.fromJson(json['links']) : null,
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null);

  Map<String, dynamic> toJson() => {
        'job': jobs != null ? jobs.map((v) => v.toJson()).toList() : null,
        'links': links != null ? links.toJson() : null,
        'meta': meta != null ? meta.toJson() : null,
      };
}
