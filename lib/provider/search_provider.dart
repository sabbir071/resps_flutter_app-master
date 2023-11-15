import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pollingstation/api/api_service.dart';

import '../api/api.dart';
import '../model/center_model.dart';

class SearchProvider extends ApiService with ChangeNotifier{

  SearchProvider(){
    _pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
  }

  final PagingController<int, Datum> _pagingController =
  PagingController(firstPageKey: 1);

  PagingController<int, Datum> get pagingController => _pagingController;

  int lastPage = 2;
  final TextEditingController searchTextController= TextEditingController();

  Future<void> fetchPage(int pageKey) async {
    try {
      var query = {
        "page": pageKey.toString(),
        "search":searchTextController.text
      };
      var response = await get(API.center, queryParams: query);

      var data = centerModelFromMap(response.body);
      lastPage = data.lastPage!;

      var newItems = data.data;

      final isLastPage = pageKey == lastPage;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems!);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems!, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  void disposeController() {
    searchTextController.clear();
  }

}