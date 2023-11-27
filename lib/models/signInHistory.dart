import 'package:polytech_visits_web/models/auditory.dart';
import 'package:polytech_visits_web/models/user.dart';

class SignInHistory {
  final User user;
  final Auditory auditory;
  String? lastPick;
  int? status;

  SignInHistory({
    required this.user,
    required this.auditory,
    this.lastPick,
    this.status,
  });

  factory SignInHistory.fromJson(Map<String, dynamic> json) {
    return SignInHistory(
      user: User.fromJson(json['user']),
      auditory: Auditory.fromJson(json['auditory']),
      lastPick: json['last_pick'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
