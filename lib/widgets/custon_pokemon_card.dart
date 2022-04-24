import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_yellow/models/pokemon.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({Key? key, required this.pokemon}) : super(key: key);

  final Pokemon? pokemon;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: pokemon!.baseColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    pokemon!.name!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text("#" + pokemon!.num!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.amber.shade300.withOpacity(0.2), borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      pokemon!.type!.join('/'),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Positioned(right: 2, width: 90, height: 90, child: Image.asset("assets/images/pokeball.png")),
                Image(
                    width: 120,
                    height: 100,
                    image: CachedNetworkImageProvider(pokemon!.img!)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
