import 'package:flutter/material.dart';
import 'package:lingoassignment/models/articles.dart';
import 'package:lingoassignment/remote_config.dart';
import 'package:lingoassignment/repositories/news.dart';

class NewsProvider extends ChangeNotifier {
  static final newsAPIs = NewsAPIs.instance;

  List<Article> articlesList = [];
  String _countryCode = "";
  String get countryCode => _countryCode;

  bool isArticlesLoading = false;

  Future<void> getArticlesListData() async {
    articlesList = [];
    isArticlesLoading = true;
    await Future.delayed(const Duration(milliseconds: 500));
    notifyListeners();
    _countryCode = await RemoteConfigService().fetchCountryCode();
    articlesList = await getArticlesAPI();
    isArticlesLoading = false;
    notifyListeners();
  }

  Future<List<Article>> getArticlesAPI() async {
    List<Article> articlesList = [];

    final response = await newsAPIs.getAllArticles();
    try {
      if (response.statusCode == 200) {
        final jsonResponse = response.data["articles"];
        if (jsonResponse != null) {
          final articleResponses = jsonResponse;
          for (final articleResponse in articleResponses) {
            articlesList.add(Article.fromJson(articleResponse));
          }
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return articlesList;
  }
}
