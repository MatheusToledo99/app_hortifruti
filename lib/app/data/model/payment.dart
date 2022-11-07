class PaymentModel {
  int id;
  String name;

  PaymentModel({
    required this.id,
    required this.name,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        id: json['id'],
        name: json['nome'],
      );
}
