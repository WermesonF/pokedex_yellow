import 'package:flutter/material.dart';
import 'package:pokedex_yellow/models/pokemon.dart';

class InformationPokemon extends StatelessWidget {
  const InformationPokemon({Key? key, required this.pokemon}) : super(key: key);

  final Pokemon? pokemon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
      ),
      child: Padding(padding: const EdgeInsets.all(16), child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buldInformation("Nome:", pokemon!.name),
          _buldInformation("Altura:", pokemon!.height),
          _buldInformation("Peso:", pokemon!.weight),
          _buldInformation("Doce:", pokemon!.candy),
          _buldInformation("Ovo:", pokemon!.egg),
          _buldInformation("Fraquezas:", pokemon!.weaknesses!.join("/")),
        ],
      ),),
    );
  }

  _buldInformation(String label, dynamic value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
        Text(value, style: const TextStyle(fontSize: 16),),
      ],
    );
  }
}
