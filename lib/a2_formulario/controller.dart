import 'package:mobx/mobx.dart';

import 'models/client.dart';
part 'controller.g.dart';

class Controller = _ControllerBase with _$Controller;

abstract class _ControllerBase with Store {
  var client = Client();

  @computed
  bool get isValid {
    return validateName() == null && validateEmail() == null;
  }

  ///Função para validação do nome:
  // o sufixo ? em "STRING?" marca a função como non-null
  String? validateName() {
    if (client.name == null) {
      return "este campo é obrigatório";
    } else {
      if (client.name!.isEmpty) {
        return "este campo é obrigatório";
      } else if (client.name!.length < 3) {
        return "Nome precisa ser maior que 3 caracteres";
      }
    }
    return null;
  }

  ///Validar o email inserido pelo usuario
  String? validateEmail() {
    if (client.email == null) {
      return "este campo é obrigatório";
    } else {
      if (client.email!.isEmpty) {
        return "este campo é obrigatório";
      } else if (!client.email!.contains("@")) {
        return "use um email valido";
      }
    }
    return null;
  }

  //valida o cpf inserido pelo usuario
  String? validateCpf() {
    if (client.cpf == null) {
      return "este campo é obrigatório";
    } else {
      if (client.cpf!.length != 11) {
        return "cpf inválido";
      }
    }
    return null;
  }

  /// Lógica para quando a tela for descartada
  dispose() {}
}
