
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:catalogo/screens/movieSearch.dart';
import 'package:catalogo/bloc/favoriteBloc.dart';
import 'package:catalogo/bloc/moviesBloc.dart';
import 'package:catalogo/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


void main() {


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: MoviesBloc(),
      child: BlocProvider(
        bloc: FavoriteBloc(),
        child: MaterialApp(
            title: 'Catalogo',
            debugShowCheckedModeBanner: false,
            home:  MovieSearch()
        ),
      )
    );
  }
}

