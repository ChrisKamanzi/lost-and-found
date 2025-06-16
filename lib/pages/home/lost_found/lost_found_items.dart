import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_and_found/generated/app_localizations.dart';
import 'package:lost_and_found/widgets/card.dart';
import '../../../stateManagment/provider/lost_found_provider.dart';

class LostFoundItemsScreen extends ConsumerStatefulWidget {
  const LostFoundItemsScreen({super.key});

  @override
  ConsumerState<LostFoundItemsScreen> createState() =>
      _LostFoundItemsScreenState();
}

class _LostFoundItemsScreenState extends ConsumerState<LostFoundItemsScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  late TextEditingController searchController;

  Timer? _debounce;
  bool _isTimeout = false;
  bool _initialDataFetched = false;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();

    final categoriesLength =
        ref.read(lostFoundNotifierProvider).categories.length;
    tabController = TabController(length: categoriesLength + 1, vsync: this);

    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        _onSearchChanged(searchController.text);
      }
    });

    Future.delayed(const Duration(seconds: 60), () {
      if (!_initialDataFetched && mounted) {
        setState(() {
          _isTimeout = true;
        });
      }
    });
  }

  void _onSearchChanged(String query) {
    final notifier = ref.read(lostFoundNotifierProvider.notifier);
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 50), () {
      if (query.trim().isEmpty) {
        notifier.search('', tabController.index);
      } else {
        notifier.search(query.trim(), tabController.index);
      }
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(lostFoundNotifierProvider);
    final notifier = ref.read(lostFoundNotifierProvider.notifier);

    final isInitialLoading =
        state.categories.isEmpty ||
        state.itemsPerTab.any((asyncItems) => asyncItems.isLoading);

    if (isInitialLoading) {
      if (_isTimeout) {
        return const Scaffold(
          body: Center(
            child: Text(
              'Taking too long...\nPlease check your internet or try again later.',
              style: TextStyle(color: Colors.redAccent, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(color: Colors.deepOrange),
          ),
        );
      }
    }

    _initialDataFetched = true;

    if (tabController.length != state.categories.length + 1) {
      tabController.dispose();
      tabController = TabController(
        length: state.categories.length + 1,
        vsync: this,
      );
      tabController.addListener(() {
        if (!tabController.indexIsChanging) {
          _onSearchChanged(searchController.text);
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          onChanged: _onSearchChanged,
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            hintText: AppLocalizations.of(context)!.search,
            hintStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            suffixIcon:
                searchController.text.isEmpty
                    ? const Icon(Icons.search, color: Colors.grey)
                    : IconButton(
                      icon: const Icon(Icons.clear, color: Colors.grey),
                      onPressed: () {
                        searchController.clear();
                        notifier.search('', tabController.index);
                        _onSearchChanged('');
                      },
                    ),
          ),
        ),
        bottom: TabBar(
          controller: tabController,
          isScrollable: true,
          tabs: [
            const Tab(text: 'All'),
            ...state.categories.map((c) => Tab(text: c['name']!)),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children:
            state.itemsPerTab.map((asyncItems) {
              return asyncItems.when(
                data: (items) {
                  if (items.isEmpty) {
                    return const Center(child: Text('No items found'));
                  }
                  return GridView.builder(
                    padding: const EdgeInsets.all(15),
                    itemCount: items.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.65,
                        ),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return LostFoundCard(
                        itemId: item.id,
                        title: item.title,
                        imagePath: item.imagePath,
                        location: item.location['district'],
                        lostStatus: item.postType,
                        daysAgo: item.postedAt,
                      );
                    },
                  );
                },
                loading:
                    () => const Center(
                      child: CircularProgressIndicator(
                        color: Colors.deepOrange,
                      ),
                    ),
                error:
                    (e, _) => Center(
                      child: Text(
                        'Error: $e',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
              );
            }).toList(),
      ),
    );
  }
}
