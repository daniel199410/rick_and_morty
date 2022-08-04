
import 'package:equatable/equatable.dart';

class RamCharacter extends Equatable{
  final int id;
  final String image;

  const RamCharacter({required this.id, required this.image});
  @override
  // TODO: implement props
  List<Object?> get props => [id];

  factory RamCharacter.fromJson(dynamic json)  => RamCharacter(
    image: json['image'], id: json['id']
  );
}