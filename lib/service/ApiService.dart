import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../model/characters_filter_response.dart';
import '../model/failure.dart';
import '../model/ram_character.dart';

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
      final character = RamCharacter.fromJson(jsonDecode(body));
      return Right(character);
    } catch(e) {
      return const Left(Failure());
    }
  }

  Future<Either<Failure, CharactersFilterResponse>> getRamCharactersByName(String name) async {
    try {
      final response = await _dio.get<String>('https://rickandmortyapi.com/api/character/?name=$name');
      final body = response.data;
      if(body == null) {
        return const Left(Failure());
      }
      final characters = CharactersFilterResponse.fromJson(jsonDecode(body));
      return Right(characters);
    } catch(e) {
      return const Left(Failure());
    }
  }
}