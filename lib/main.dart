
import 'package:flutter/material.dart';
import 'package:poke_poke_dex/model/pokemon.dart';
import 'package:poke_poke_dex/pages/homePageBody.dart';
import 'package:poke_poke_dex/pages/pokemonDetailPage.dart';
import 'package:poke_poke_dex/scoped_model/moveState.dart';
import 'package:provider/provider.dart';

import 'pages/PokemonList/pokemonListPage.dart';
import 'pages/Types/pokemonMovesPage.dart';
import 'scoped_model/pokemonState.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  late Pokemon pokemonModel;
 late PokemonState _pokemonState = PokemonState();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<PokemonState>(
              create: (context) => _pokemonState),
          ChangeNotifierProvider<MoveState>(create: (context) => MoveState()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: TextTheme(
                  bodyText1: TextStyle(fontSize: 14),
                  bodyText2: TextStyle(fontSize: 16),
                  headline1: TextStyle(fontSize: 16),
                  subtitle1: TextStyle(fontSize: 12),
                  caption: TextStyle(fontSize: 14),
                  headline2: TextStyle(fontSize: 16),
                  headline3: TextStyle(fontSize: 16))),
          // home: MyHomePage(),
          routes: {
            '/': (BuildContext context) => MyHomePage(),
            '/pokemonList': (BuildContext context) => PokemonListPage(),
            '/detail': (BuildContext context) => PokemonDetailPage()
          },
          onGenerateRoute: (settings) {
            final List<String> pathElements = settings.name!.split('/');
            if (pathElements[0] != '') {
              return null;
            }
            if (pathElements[1].contains('detail')) {
              var name = pathElements[2];
              return MaterialPageRoute<bool>(
                  builder: (BuildContext context) => PokemonDetailPage(
                        name: name,
                      ));
            }
            if (pathElements[1].contains('moves')) {
              return MaterialPageRoute<bool>(
                  builder: (BuildContext context) => PokemonMovesPage());
            }
            return null;
          },
        ));
  }
}

class MyHomePage extends StatefulWidget {
  // final MainModel model;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isViewAll = false;
  double viewAllHeight = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xfff4f4f4), body: HomePageBody());
  }
}
