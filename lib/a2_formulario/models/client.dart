import 'package:mobx/mobx.dart';
part 'client.g.dart';

class Client = _ClientBase with _$Client;

// Colocar o sufixo ? no tipo, tornar a variavel anulavél
abstract class _ClientBase with Store {
  @observable
  String? name;
  @action
  changeName(String value) => name = value;

  @observable
  String? email;
  @action
  changeEmail(String value) => email = value;

  @observable
  String? cpf;
  @action
  changeCpf(String value) => cpf = value;
}
