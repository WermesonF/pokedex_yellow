import 'package:flutter/material.dart';

class Pokemon {
  int? id;
  String? num;
  String? name;
  String? img;
  List<String>? type;
  String? height;
  String? weight;
  String? candy;
  String? egg;
  List<String>? weaknesses;

  Pokemon({
    this.id,
    this.num,
    this.name,
    this.img,
    this.type,
    this.height,
    this.weight,
    this.candy,
    this.egg,
    this.weaknesses,
  });

  factory Pokemon.fromMap(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      num: json['num'],
      name: json['name'],
      img: json['img'],
      type: (json['type'] as List<dynamic>).map((e) => e as String).toList(),
      height: json['height'],
      weight: json['weight'],
      candy: json['candy'],
      egg: json['egg'],
      weaknesses: (json['weaknesses'] as List<dynamic>).map((e) => e as String).toList(),
    );
  }

  Color? get baseColor => _color(type: type![0]);

  static Color? _color({required String type}) {
    switch (type) {
      case 'Normal':
        return Colors.brown[400];
      case 'Fire':
        return Colors.red;
      case 'Water':
        return Colors.blue;
      case 'Grass':
        return Colors.green;
      case 'Electric':
        return Colors.amber;
      case 'Ice':
        return Colors.cyanAccent[400];
      case 'Fighting':
        return Colors.orange;
      case 'Poison':
        return Colors.purple;
      case 'Ground':
        return Colors.orange[300];
      case 'Flying':
        return Colors.indigo[200];
      case 'Psychic':
        return Colors.pink;
      case 'Bug':
        return Colors.lightGreen[500];
      case 'Rock':
        return Colors.grey;
      case 'Ghost':
        return Colors.indigo[400];
      case 'Dark':
        return Colors.brown;
      case 'Dragon':
        return Colors.indigo[800];
      case 'Steel':
        return Colors.blueGrey;
      case 'Fairy':
        return Colors.pinkAccent[100];
      default:
        return Colors.grey;
    }
  }
}
