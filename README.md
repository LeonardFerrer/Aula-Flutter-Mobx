# aula_mobx

Projeto dedicado ao aprendizado de gerenciamento de estado com o MobX no Flutter.

## Formulários Reativos

Para o gerenciamento do codigo do Mobx, há duas opções:
- Usar o comando **flutter pub run build_runner watch** para monitora as alterações;
- **flutter pub run build_runner build** para realizar uma unica montagem do projeto; 
- Usar a extensão **mobxcodegen** para automatizar a compilação e geração dos arquivos **.g.dart**.

Independente do meio escolhido há necessidade de estar instalado nas dependecias do projeto o [build_runner](https://pub.dev/packages/build_runner) e o [mobx_codegen](https://pub.dev/packages/mobx_codegen).

Para usar snippets personalizados para facilitar o desenvolvimento, há duas opções:
- Criar seus próprios snippets;
- Usar a extensão **flutter-mobx**.


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

