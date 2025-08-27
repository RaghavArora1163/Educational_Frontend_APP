import 'dart:async';
import 'package:get/get.dart';
import 'package:online/data/api_controller/api_controller.dart';
import 'package:online/data/api_url/api_url.dart';
import 'package:online/models/search_model/search_model.dart';
import 'package:online/utils/app_mixin/global_mixin.dart';

class SearchController extends GetxController with GlobalMixin {
  RxList<SearchResult> searchResults = <SearchResult>[].obs;
  RxBool isLoading = false.obs;
  RxBool isError = false.obs;
  RxString errorMessage = ''.obs;
  Timer? _debounce;

  // Grouped results by type
  RxMap<String, List<SearchResult>> groupedResults = <String, List<SearchResult>>{
    'course': [],
    'book': [],
    'testSeries': [],
  }.obs;

  void performSearch(String query) async {
    _debounce?.cancel();

    isLoading.value = true;
    isError.value = false;
    errorMessage.value = '';

    // For empty query, fetch suggested or popular results
    final data = query.isEmpty ? {"keyword": "", "suggested": true} : {"keyword": query};

    // Debounce only for non-empty queries to avoid delay in initial load
    if (query.isEmpty) {
      await _executeSearch(data);
    } else {
      _debounce = Timer(const Duration(milliseconds: 500), () async {
        await _executeSearch(data);
      });
    }
  }

  Future<void> _executeSearch(Map<String, dynamic> data) async {
    final response = await ApiController().search(apiUrl: ApiUrl.search, data: data);

    isLoading.value = false;

    if (response != null && response.success == true) {
      searchResults.value = response.data?.results ?? [];
      groupedResults.value = {
        'course': searchResults.where((r) => r.type == 'course').toList(),
        'book': searchResults.where((r) => r.type == 'book').toList(),
        'testSeries': searchResults.where((r) => r.type == 'testSeries').toList(),
      };
    } else {
      isError.value = true;
      errorMessage.value = response?.message ?? 'Failed to fetch search results';
    }
  }

  @override
  void onClose() {
    _debounce?.cancel();
    super.onClose();
  }
}