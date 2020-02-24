import 'dart:async';

import 'package:catalogo/api.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:catalogo/models/movie.dart';
import 'dart:async';
import 'package:catalogo/models/movie.dart';

class MoviesBloc implements BlocBase{

  Api api;

  List<Movie> movies;

  final StreamController<List<Movie>> _moviesController = StreamController<List<Movie>>();
  Stream get outMovies => _moviesController.stream;

  final StreamController<String> _searchController = StreamController<String>();
  Sink get inSearch => _searchController.sink;

  MoviesBloc(){
    api = Api();

    _searchController.stream.listen(_search);
  }

  void _search(String search) async{

    movies = await api.search(search);
    _moviesController.sink.add(movies);
  }

  @override
  void addListener(listener) {
    // TODO: implement addListener
  }

  @override
  void dispose() {
    _searchController.close();
    _moviesController.close();
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => null;

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void removeListener(listener) {
    // TODO: implement removeListener
  }



}