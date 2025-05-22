import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/lost_found_model.dart';

class LostFoundState {
  final List<Map<String, String>> categories;
  final List<AsyncValue<List<LostFound>>> itemsPerTab;
  final String searchQuery;

  LostFoundState({
    this.categories = const [],
    this.itemsPerTab = const [],
    this.searchQuery = '',
  });

  LostFoundState copyWith({
    List<Map<String, String>>? categories,
    List<AsyncValue<List<LostFound>>>? itemsPerTab,
    String? searchQuery,
  }) {

    return LostFoundState(
      categories: categories ?? this.categories,
      itemsPerTab: itemsPerTab ?? this.itemsPerTab,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
