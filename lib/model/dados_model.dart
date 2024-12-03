class Dado {
  final int? id;
  final String descricao;
  final String valor;
  final String quantidade;

  const Dado({
    required this.descricao,
    required this.valor,
    required this.quantidade,
    this.id,
  });

  // Convert a Dado into a Map. The keys must correspond to the names of the columns in the database.
  Map<String, Object?> toMap() {
    // O id deve ser null quando estamos inserindo um novo dado, já que é auto-incrementado
    return {
      'descricao': descricao,
      'valor': valor,
      'quantidade': quantidade,
    };
  }

  @override
  String toString() {
    return 'Dado{id: $id, descricao: $descricao, valor: $valor, quantidade: $quantidade}';
  }

  // Factory para criar um objeto Dado a partir de um Map<String, dynamic>
  factory Dado.fromJson(Map<String, dynamic> json) => Dado(
    id: json['id'] != null ? json['id'] as int : null,
    descricao: json['descricao'] as String,
    valor: json['valor'] as String,
    quantidade: json['quantidade'] as String,
  );

  // Método para converter um objeto Dado para Map<String, dynamic>
  Map<String, dynamic> toJson() => {
    'id': id,
    'descricao': descricao,
    'valor': valor,
    'quantidade': quantidade,
  };
}