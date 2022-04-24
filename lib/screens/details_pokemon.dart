import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_yellow/models/pokemon.dart';
import 'package:pokedex_yellow/widgets/custon_infor_pokemon.dart';

class DetailsPokemon extends StatelessWidget {
  const DetailsPokemon({Key? key, required this.pokemon}) : super(key: key);

  final Pokemon? pokemon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pokemon!.baseColor,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                semanticLabel: "voltar",
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                pokemon!.name!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color:
                                        Colors.amber.shade300.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Text(
                                    pokemon!.type!.join('/'),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text("#" + pokemon!.num!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                          Positioned(
                              right: 0,
                              height: 100,
                              width: 100,
                              child: Image.asset("assets/images/pokeball.png")),
                              Image(
                              image: CachedNetworkImageProvider(pokemon!.img!)),
                        ]),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: InformationPokemon(pokemon: pokemon),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
