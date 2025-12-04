import 'package:hive/hive.dart';
part 'service_hive_model.g.dart';

@HiveType(typeId: 0) 
class Service extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String descricao;

  @HiveField(2)
  late DateTime data;

  @HiveField(3)
  late String nome_cliente;

  @HiveField(4)
  late String endereco;

  @HiveField(5)
  late double valor;

  Service(
    this.name,
    this.descricao,
    this.data,
    this.nome_cliente,
    this.endereco,
    this.valor
  );
}