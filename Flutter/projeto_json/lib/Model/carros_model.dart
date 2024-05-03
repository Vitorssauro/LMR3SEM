//placa,
//modelo,
//marca,
//ano,
//cor,
//descricao,
//foto,
//valor

class Carro {
  //atributos
  final String placa;
  final String modelo;
  final String marca;
  final int ano;
  final String cor;
  final String descricao;
  final String foto;
  final double valor;
  //construtor
  Carro(
      {required this.placa,
      required this.modelo,
      required this.marca,
      required this.ano,
      required this.cor,
      required this.descricao,
      required this.foto,
      required this.valor});

  Map<String, dynamic> toJson() {
    return {
      'placa': placa,
      'modelo': modelo,
      'marca': marca,
      'ano': ano,
      'cor': cor,
      'descricao': descricao,
      'foto': foto,
      'valor': valor,
    };
  }
  factory Carro.fromJson(Map<String,dynamic> map) {
    return Carro(
      placa: map['placa'],
      modelo: map['modelo'],
      marca: map['marca'],
      ano: map['ano'],
      cor: map['cor'],
      descricao: map['descricao'],
      foto: map['foto'],
      valor: map['valor'],
    );
  }
}
