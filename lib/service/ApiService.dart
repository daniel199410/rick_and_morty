import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hello_world/model/failure.dart';
import 'package:hello_world/model/ram_character.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<Either<Failure, RamCharacter>> getRamCharacter(int id) async {
    try {
      final response = await _dio.get<String>('https://rickandmortyapi.com/api/character/$id');
      final body = response.data;
      if(body == null) {
        return const Left(Failure());
      }
      final character = RamCharacter.fromJson(body);
      return Right(character);
    } catch(e) {
      return const Left(Failure());
    }
  }
}