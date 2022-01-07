# aula_mobx

Projeto dedicado ao aprendizado de gerenciamento de estado com o MobX no Flutter.

## Formulários Reativos

### Configurações iniciais
Para o gerenciamento do codigo do Mobx, há duas opções:
- Usar o comando `flutter pub run build_runner watch` para monitora as alterações;
- `flutter pub run build_runner build` para realizar uma unica montagem do projeto; 
- Usar a extensão **mobxcodegen** para automatizar a compilação e geração dos arquivos **.g.dart**.

Independente do meio escolhido há necessidade de estar instalado nas dependecias do projeto o [build_runner](https://pub.dev/packages/build_runner) e o [mobx_codegen](https://pub.dev/packages/mobx_codegen).
```dart
dependencies:
    flutter:
        sdk: flutter
    mobx: ^2.0.5
    flutter_mobx: ^2.0.3+2
 
 dev_dependencies:
  flutter_test:
    sdk: flutter
  mobx_codegen: ^2.0.5+2
  build_runner: ^2.1.7
```

Para usar snippets personalizados para facilitar o desenvolvimento, há duas opções:
- Criar seus próprios snippets;
- Usar a extensão **flutter-mobx**.

### Primeiro Model
Para iniciar os primeiros passos com o MobX iremos criar um Model, classe que representa as caracteristicas de um objeto. Em nosso projeto iremos criar um model de **client**, contituido de três caractéricas: nome, cpf, email:
``` dart
Client{
    String nome;
    String cpf;
    String email;
}
```

Para criar uma classe reativa utilizaremos o Mobx e utilizaremos nosso model. Primeiro crie um novo arquivo denominado **client.dart** e adicione:
```dart
import 'package:mobx/mobx.dart';
part '<classe>.g.dart';

class <classe> = _<classe>Base with _$<classe>;

abstract class _<classe>Base with Store {

}
```

substitua os **"classe"** pelo nome da classe que irá criar, no nosso caso será **client**:
```dart
import 'package:mobx/mobx.dart';
part 'client.g.dart';

class Client = _ClientBase with _$Client;

abstract class _ClientBase with Store {

}
```

Ao adicinar o trecho acima, notará que o editor irá apontar um erro em `part 'client.g.dart'`, esse arquivo é gerado automaticamente pelo mobx mas antes você deverá executar o seguinte comando para a geração do **.g.dart**:
```dart
flutter pub run build_runner build
```


### Observable, Action e Reaction
O [Mobx](https://pub.dev/packages/mobx) se apoia em três pilar: **Observable**, **Action**, **Reaction**.

**Observable** ​​representam o estado reativo de seu aplicativo. Eles podem ser escalares simples para árvores de objetos complexos. Ao definir o estado do aplicativo como uma árvore de observáveis, você pode expor uma árvore de estado reativo que a IU (ou outros observadores no aplicativo) consomem.

**Action** são como você altera os observáveis. Em vez de alterá-los diretamente, as ações adicionam um significado semântico às mutações. Por exemplo, em vez de apenas fazer value++, disparar uma increment() ação tem mais significado. Além disso, as ações também agrupam todas as notificações e garantem que as alterações sejam notificadas somente depois de concluídas. Assim, os observadores são notificados apenas após a conclusão atômica da ação.

**Reaction** completam a tríade MobX de observáveis , ações e reações . Eles são os observadores do sistema reativo e são notificados sempre que um observável que eles rastreiam é alterado. As reações vêm em alguns sabores, conforme listado abaixo. Todos eles retornam a ReactionDisposer, uma função que pode ser chamada para descartar a reação. Uma característica marcante das reações é que elas rastreiam automaticamente todos os observáveis ​​sem qualquer conexão explícita. O ato de ler um observável dentro de uma reação é o suficiente para rastreá-lo.

Após uma breve explicação sobre a triade Mobx podemos criar nossos próprios estados reativos. Primeiro iremos criar nossos estados do cliente: cpf, nome, email. e para isso usamos a anotação `@Observable`:
```dart
import 'package:mobx/mobx.dart';
part 'client.g.dart';

class Client = _ClientBase with _$Client;

abstract class _ClientBase with Store {
    @Observable
    String? nome

    @Observable
    String? cpf

    @Observable
    String? email
}
```

**N.T.1:** Ao comparar nossa classe Client com o model inicialmente mostrado, notaram que há um sufixo **?** pós tipo da váriavel, ` String? nome`, isso se deve as novas features do [Dart: null-safety](https://blog.flutterando.com.br/dart-e-nnbd-9810aae37de7) na qual uma váriavel não pode ser implicitamente null. ao adicionar o **?** indicamos que essa váriavel pode ser null, mas que iremos tratalá adequadamente.

**N.T.2:** Não esqueça de rodar o `flutter pub run build_runner build` caso não esteja rodando o modo `watch` do build_runner.

Primeiro pilar do Mobx, conquistado, agora iremos implementar o segundo pilar, **Action** para modificar o estado dessas observable, logo, utilizaremos a notação `@action` para criar a função `changeName()` que irá atualizar o valor da observable nome:
```dart
@action
changeName(String value) => name = value;
```

```dart
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
```

Nesse ponto falta apenas os **Reactions**, que seram as reações geradas pela mudança de estado de uma observable. para isso iremos envolver as dependencias da observable com o `Observer()`:
```dart
// Estrutura do Observer()
Observer(
    builder: (_) {
        return ;
    }
)
```

```dart
// Aplicando sobre o campo text o nome do cliente
Observer(
    builder: (_) {
        return Text(client.nome) ;
    }
)
```



## Provendo código com o Provider
Provider é um gerenciador de estado do próprio flutter sendo responsavél por aplicar o [Design Pattern Singleton](https://refactoring.guru/pt-br/design-patterns/singleton) que garante que seja criado apenas uma única instancia de um objeto. No nosso caso queremos haja apenas um objeto controller afim de tornar mais facil o seu acesso além de garantir que as mudanças nele seja propagadas por suas dependecias.

No **pubspec.yaml** adicione o Provider:
```dart
dependencies:
    flutter:
        sdk: flutter
    mobx: ^2.0.5
    provider: ^6.0.1
```

Para iniciar com o gerenciamento de estado, comece adicionando na **main.dart** dentro do **widget build** o **MultiProvider()**, com ele vc pode utilizar vários providers:
```dart
@override
Widget build(BuildContext context) {
    return MultiProvider(
        providers: <SingleChildWidget>[

        ] //SingleChildWidget
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
                primarySwatch: Colors.blue,
            ), //ThemeData
            home: const HomePage(),
        ), //MaterialApp
    );
}
```

A estrutura inicial estar pronta, agora, imagine que você possua uma classe denominada **Controller.dart** e a mesma armazena e controlar o seu model que é acessada por multiplos widgets. Afim de tornar seu projeto escalavel e fácil manutenção uma boa maneira, seria instaciar a classe **Controller** uma única vez e sempre que precise acessa-la use uma única instacia dela.
```dart
providers: <SingleChildWidget>[
    Provider<Controller>(
          create: (_) => Controller(),
    ),
] 
```

versão completa do ***widget build**:
```dart
@override
Widget build(BuildContext context) {
    return MultiProvider(
        providers: <SingleChildWidget>[
            Provider<Controller>(
                create: (_) => Controller(),
            ),
        ] //SingleChildWidget
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
                primarySwatch: Colors.blue,
            ), //ThemeData
            home: const HomePage(),
        ), //MaterialApp
    );
}
```

Para fazer uma chamada a uma instância dentro do Provider você dispoe do `Provider.of<T>(context)`.
Dentro do **widget build** do widget faça a chamada:
```dart
@override
  Widget build(BuildContext context) {
    final controller = Provider.of<Controller>(context);
  }
```

Apartir desse ponto a variável **controller** possui acesso a classe **Controller**.

**NOTA: MÉTODO DISPOSE**
Esse é um método quando um widget será destruído e não será mais utilizado pela árvore de widgets.
Para usar um método dispose com Provider, primeiro na sua classe **Controller** criei o método `dipose()`:
```dart
dispose() {

}
```

Em seguida dentro da **main.dart**, adicione no **MultiProvider** o `dipose: `:
```dart
MultiProvider(
      providers: <SingleChildWidget>[
        Provider<Controller>(
          create: (_) => Controller(),
          // estrutura para usar dispose com provider
          // dispose: (context, <variavel1>) => <variavel1>.dispose(),
          dispose: (_, controller) => controller.dispose(),
        ),
      ],
      child: MaterialApp()
);
```

