import 'package:aula_mobx/a2_formulario/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class BodyWidget extends StatelessWidget {
  const BodyWidget({Key? key}) : super(key: key);

  ///Classe para gerar TextFields padrão
  //o prefixo REQUIRED deve ser usado para garantir que essa informação não seja nula
  //o sufixo ? serve para indiccar que nenhum valor foi fornecido ainda
  _textField(
      {required String labelText,
      required onChanged,
      required String? Function() errorText}) {
    return TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
          errorText: errorText(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    //Chama um singleton do Controller
    final controller = Provider.of<Controller>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Observer(
            builder: (_) {
              return _textField(
                  labelText: "name",
                  onChanged: controller.client.changeName,
                  errorText: controller.validateName);
            },
          ),
          // ignore: prefer_const_constructors
          SizedBox(
            height: 20,
          ),
          Observer(
            builder: (_) {
              return _textField(
                  labelText: "email",
                  onChanged: controller.client.changeEmail,
                  errorText: controller.validateEmail);
            },
          ),
          // ignore: prefer_const_constructors
          SizedBox(
            height: 20,
          ),
          Observer(
            builder: (_) {
              return _textField(
                  labelText: "cpf",
                  onChanged: controller.client.changeCpf,
                  errorText: controller.validateCpf);
            },
          ),
          // ignore: prefer_const_constructors
          SizedBox(
            height: 40,
          ),
          Observer(
            builder: (_) {
              return ElevatedButton(
                  // Se estiver valido os campos do formulario,onPressed é ativado
                  // e executa uma ação, caso contrário o botão se mantém desativado
                  onPressed: controller.isValid ? () {} : null,
                  child: const Text('SALVAR'));
            },
          ),
        ],
      ),
    );
  }
}
