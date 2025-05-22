import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_and_found/models/lost_found_model.dart';
import '../models/heloll.dart';
import '../pages/services/lost_found_state.dart';

final lostFoundRepositoryProvider = Provider((ref) => LostFoundRepository());

class LostFoundNotifier extends StateNotifier<LostFoundState> {
  final LostFoundRepository repository;

  LostFoundNotifier(this.repository) : super(LostFoundState());

  Future<void> init() async {
    final categories = await repository.fetchCategories();
    final futures = await _loadItemsForTabs(categories);
    state = state.copyWith(categories: categories, itemsPerTab: futures);
  }

  Future<void> search(String query, int selectedTabIndex) async {
    final categories = state.categories;
    final isAllTab = selectedTabIndex == 0;

    final futures = <AsyncValue<List<LostFound>>>[];

    try {
      final allItems = await repository.fetchItems(query: query);
      futures.add(AsyncValue.data(allItems));
    } catch (e) {
      futures.add(AsyncValue.error(e, StackTrace.current));
    }

    for (var i = 0; i < categories.length; i++) {
      try {
        if (!isAllTab && (selectedTabIndex - 1) == i) {
          final filteredItems = await repository.fetchItemsByCategory(
            categories[i]['id']!,
            query: query,
          );
          futures.add(AsyncValue.data(filteredItems));
        } else {
          final items = await repository.fetchItemsByCategory(
            categories[i]['id']!,
          );
          futures.add(AsyncValue.data(items));
        }
      } catch (e) {
        futures.add(AsyncValue.error(e, StackTrace.current));
      }
    }
    state = state.copyWith(searchQuery: query, itemsPerTab: futures);
  }

  Future<List<AsyncValue<List<LostFound>>>> _loadItemsForTabs(
    List<Map<String, String>> categories, {
    String query = '',
  }) async {
    final futures = <AsyncValue<List<LostFound>>>[];
    try {
      final allItems = await repository.fetchItems(query: query);
      futures.add(AsyncValue.data(allItems));
    } catch (e) {
      futures.add(AsyncValue.error(e, StackTrace.current));
    }

    for (var category in categories) {
      try {
        final items = await repository.fetchItemsByCategory(
          category['id']!,
          query: query,
        );
        futures.add(AsyncValue.data(items));
      } catch (e) {
        futures.add(AsyncValue.error(e, StackTrace.current));
      }
    }

    return futures;
  }
}

final lostFoundNotifierProvider =
    StateNotifierProvider<LostFoundNotifier, LostFoundState>((ref) {
      final repo = ref.watch(lostFoundRepositoryProvider);
      return LostFoundNotifier(repo)..init();
    });
