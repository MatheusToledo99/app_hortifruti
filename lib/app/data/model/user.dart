class UserModel {
  String name;
  String email;
  String phone;
  String? password;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json['nome'],
        email: json['email'],
        phone: json['telefone'],
      );

  Map<String, dynamic> toJson() => {
        'nome': name,
        'email': email,
        'telefone': phone,
        if (password != null && password!.isNotEmpty) 'password': password,
      };
}
