import 'user.dart';

class AuthResponse {
  AuthResponse({
    this.message,
    this.user,
    this.token,
  });

  AuthResponse.fromJson(dynamic json) {
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'];
  }

  String? message;
  User? user;
  String? token;

  AuthResponse copyWith({
    String? message,
    User? user,
    String? token,
  }) =>
      AuthResponse(
        message: message ?? this.message,
        user: user ?? this.user,
        token: token ?? this.token,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['token'] = token;
    return map;
  }
}
