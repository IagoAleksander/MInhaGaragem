class Carro {
  Carro({
    this.id = -1,
    this.placa,
    this.cor,
    this.isSelected = false,
  });

  final int? id;
  final String? placa;
  final String? cor;

  bool isSelected = false;

  Map<String, dynamic> toJson() => {
        'placa': placa,
        'cor': cor,
      };

  Carro.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        placa = json['placa'],
        cor = json['cor'];
}
