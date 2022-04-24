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
  List<Pokemon> listPokemons = [];
  List<Pokemon> listPokemonSearch = [];
  Icon searchIcon = const Icon(Icons.search);
  Widget appBarTitle = const Text("Pokedex Flutter");
  final TextEditingController filter = TextEditingController();
  String searchText = "";
  String status = "Carregando pokedex...";

  _HomePageState() {
    filter.addListener(() {
      if (filter.text.isEmpty) {
        searchText = "";
        listPokemons = listPokemonSearch;
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
        title: appBarTitle,
        centerTitle: true,
        actions: <Widget>[
          IconButton(onPressed: searchPressed, icon: searchIcon)
        ],
      ),
      body: listPokemons.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(status),
                ],
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: listPokemons.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  child: PokemonCard(pokemon: listPokemons[index]),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsPokemon(
                                  pokemon: listPokemons[index],
                                )));
                  },
                );
              },
            ),
    );
  }

  void searchPressed() {
    setState(() {
      if (searchIcon.icon == Icons.search) {
        searchIcon = const Icon(Icons.close);
        appBarTitle = TextField(
          controller: filter,
          decoration: const InputDecoration(
            hintText: "Pesquisar pokemon",
          ),
        );
      } else {
        searchIcon = const Icon(Icons.search);
        appBarTitle = const Text("Pokedex Flutter");
        listPokemons = listPokemonSearch;
        filter.clear();
      }
    });
  }

  void setListPokemon() {
    searchText = filter.text;
    List<Pokemon> tempList = [];

    for (int i = 0; i < listPokemonSearch.length; i++) {
      if (listPokemonSearch[i]
          .name!
          .toLowerCase()
          .contains(searchText.toLowerCase())) {
        tempList.add(listPokemonSearch[i]);
      }
    }

    if(tempList.isEmpty) {
      status = "Pokemon não encontrato!";
    }

    listPokemons = tempList;
  }

  void fetchPokemonDate() async {
    PokemonRepository pokemonRepository = PokemonRepository();
    listPokemons = await pokemonRepository.getAllPokemons();
    listPokemonSearch = listPokemons;
    setState(() => {});
  }
}
