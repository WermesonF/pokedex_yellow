import 'package:flutter/material.dart';
import 'package:pokedex_yellow/models/pokemon.dart';
import 'package:pokedex_yellow/repositories/pokemon_repository.dart';
import 'package:pokedex_yellow/screens/details_pokemon.dart';
import 'package:pokedex_yellow/widgets/custon_pokemon_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Pokemon> _listPokemons = [];
  List<Pokemon> _listPokemonSearch = [];
  Icon _searchIcon = const Icon(Icons.search);
  Widget _appBarTitle = const Text("Pokedex Yellow");
  final TextEditingController _filter = TextEditingController();
  String _searchText = "";
  String _status = "Carregando pokedex...";

  _HomePageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        _searchText = "";
        _listPokemons = _listPokemonSearch;
      } else {
        setState(() {
          setListPokemon();
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchPokemonDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade200,
      appBar: AppBar(
        title: _appBarTitle,
        centerTitle: true,
        actions: <Widget>[
          IconButton(onPressed: searchPressed, icon: _searchIcon)
        ],
      ),
      body: _listPokemons.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(_status),
                ],
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: _listPokemons.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  child: PokemonCard(pokemon: _listPokemons[index]),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsPokemon(
                                  pokemon: _listPokemons[index],
                                )));
                  },
                );
              },
            ),
    );
  }

  void searchPressed() {
    setState(() {
      if (_searchIcon.icon == Icons.search) {
        _searchIcon = const Icon(Icons.close);
        _appBarTitle = TextField(
          controller: _filter,
          decoration: const InputDecoration(
            hintText: "Pesquisar pokemon",
          ),
        );
      } else {
        _searchIcon = const Icon(Icons.search);
        _appBarTitle = const Text("Pokedex Yellow");
        _listPokemons = _listPokemonSearch;
        _filter.clear();
      }
    });
  }

  void setListPokemon() {
    _searchText = _filter.text;
    List<Pokemon> tempList = [];

    for (int i = 0; i < _listPokemonSearch.length; i++) {
      if (_listPokemonSearch[i]
          .name!
          .toLowerCase()
          .contains(_searchText.toLowerCase())) {
        tempList.add(_listPokemonSearch[i]);
      }
    }

    if(tempList.isEmpty) {
      _status = "Pokemon não encontrato!";
    }

    _listPokemons = tempList;
  }

  void fetchPokemonDate() async {
    PokemonRepository pokemonRepository = PokemonRepository();
    _listPokemons = await pokemonRepository.getAllPokemons();
    _listPokemonSearch = _listPokemons;
    setState(() => {});
  }
}
