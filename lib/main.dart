import 'package:flutter/material.dart';
import 'package:pdm_alfa/repositories/isar/isar.repository.dart';
import 'package:pdm_alfa/stores/counter.store.dart';
import 'package:pdm_alfa/themes/dark.theme.dart';
import 'package:pdm_alfa/views/home/home.view.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IsarRepository.instance.init();
  runApp(const Root());
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <Provider<dynamic>>[
        Provider<CounterStore>.value(value: CounterStore()),
      ],
      child: MaterialApp(
        title: 'Clientes',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        darkTheme: darkTheme,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeView(),
      ),
    );
    // return MaterialApp(
    //   title: 'Clientes',
    //   debugShowCheckedModeBanner: false,
    //   themeMode: ThemeMode.dark,
    //   darkTheme: darkTheme,
    //   theme: ThemeData(
    //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    //     useMaterial3: true,
    //   ),
    //   home: const HomeView(),
    // );
  }
}
