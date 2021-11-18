import 'package:mobx/mobx.dart';

class Controller {
  /// 1° pilar do Mobx: OBSERVABLE, um objeto que contém um estado a ser observado
  final _counter = Observable(0);

  /// Define um Output para recuperar o valor do Counter que é privado
  int get counter => _counter.value;

  /// Define uma Input para adicionar manualmente um novo valor ao Counter
  set counter(int newValue) => _counter.value = newValue;

  /// 2° pilar do Mobx: ACTION, Uma ação para alterar o estado de um OBSERVABLE
  // o prefixo LATE indica que ele pode ser instanciado depois.
  late Action increment;

  Controller() {
    increment = Action(_increment);

    //Executar ações quando uma OBSERVABLE for alterada
    autorun((_) {
      //Irá imprimir no console toda alteração na OBSERVABLE counter
      print(counter);
    });
  }

  /// Função para alterar o estado do objeto counter
  // o underline antes do nome da função a define como privada, tornando a acessivel apenas
  // no arquivo orginal.
  _increment() {
    _counter.value++;
  }
}
