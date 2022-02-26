import 'package:dictionary_app_flutter/models/Dictionary.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final dictionaryProvider = StateNotifierProvider<DictionaryProvider,List<Dictionary>>((ref) => DictionaryProvider([]));

class DictionaryProvider extends StateNotifier<List<Dictionary>>{
  DictionaryProvider(List<Dictionary> state) : super(state);

  
  Future<void> searchWord(String word) async{
    final dio = Dio();
    try{
      final response = await dio.get('https://owlbot.info/api/v4/dictionary/$word',options: Options(
          headers: {
            "Authorization": "Token a8a8e514379b8277557f4b0b36d0019d7e8da92e"
          }
      ));
      final data = (response.data['definitions'] as List).map((e) => Dictionary.fromJson(e)).toList();
      state =  data;
    }on DioError catch(error){
      print(error.response);
    }
  }
}