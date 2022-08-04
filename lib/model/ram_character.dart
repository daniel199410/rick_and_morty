
import 'package:equatable/equatable.dart';

class RamCharacter extends Equatable{
  final int id;
  final String image;
  final String name;
  final String gender;

  const RamCharacter({
    required this.id,
    required this.image,
    required this.name,
    required this.gender,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [id];

  factory RamCharacter.fromJson(dynamic json)  => RamCharacter(
    gender: json['gender'],
    id: json['id'],
    image: json['image'],
    name: json['name'],
  );
}