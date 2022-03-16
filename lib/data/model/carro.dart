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

  bool isSelected;
}
