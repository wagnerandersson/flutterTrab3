class Cliente {
  final int id;
  final String name;
  final String token;

  Cliente({
    required this.id,
    required this.name,
    required this.token,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
        id: json['id'],
        name: json['name'],
        token: json['token']);
  }
}
