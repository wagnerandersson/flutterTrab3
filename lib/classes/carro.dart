class Carro {
  final int id;
  final String product_name;
  final String tag;
  final int amount;
  final String image;

  Carro({
    required this.id,
    required this.product_name,
    required this.tag,
    required this.amount,
    required this.image,
  });

  factory Carro.fromJson(Map<String, dynamic> json) {
    return Carro(
        id: json['id'],
        product_name: json['product_name'],
        tag: json['tag'],
        amount: json['amount'],
        image: json['image']);
  }
}
