import 'dart:convert';

import 'package:news_api/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {

  List<ArticleModel> news = [];

  Future<void> getNews() async{
    String url = "http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=81cab51ad76f460487a11ac14e557509";

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if(jsonData["status"] == "ok"){
      jsonData["articles"].forEach((element){
        if(element["urlToImage"] != null && element['description'] != null){
          ArticleModel articleModel = ArticleModel(
            title: element["title"],
            author: element["author"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["context"],
          );
          news.add(articleModel);
        }
      });
    }
  }
}