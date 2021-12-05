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

No **pubspec.yaml** em dependecies adicione:
```dart
dependencies:
    flutter:
        sdk: flutter
    mobx: ^2.0.5
    provider: ^6.0.1
```

Para iniciar com o gerenciamento de estado, comece adicionando na **main.dart** dentro do **widget build**:
```dart
Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        Provider<Controller>(
          create: (_) => Controller(),
          // estrutura para usar dispose com provider
          // dispose: (context, <variavel1>) => <variavel1>.dispose(),
          dispose: (_, controller) => controller.dispose(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
```



