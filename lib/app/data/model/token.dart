class TokenModel {
  String token;
  String expiresAt;

  TokenModel({
    required this.token,
    required this.expiresAt,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
        token: json['token'],
        expiresAt: json['expires_at'],
      );
}
