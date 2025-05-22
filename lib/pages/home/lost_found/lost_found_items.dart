import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_and_found/widgets/card.dart';
import '../../../providers/lost_found_items_notifier.dart';

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

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();

    final categoriesLength =
        ref.read(lostFoundNotifierProvider).categories.length;
    tabController = TabController(length: categoriesLength + 1, vsync: this);

    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        final query = searchController.text;
        final notifier = ref.read(lostFoundNotifierProvider.notifier);
        notifier.search(query, tabController.index);
      }
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(lostFoundNotifierProvider);
    final notifier = ref.read(lostFoundNotifierProvider.notifier);

    if (tabController.length != state.categories.length + 1) {
      tabController.dispose();
      tabController = TabController(
        length: state.categories.length + 1,
        vsync: this,
      );

      tabController.addListener(() {
        if (!tabController.indexIsChanging) {
          notifier.search(searchController.text, tabController.index);
        }
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          onSubmitted: (query) => notifier.search(query, tabController.index),
          decoration: InputDecoration(
            hintText: 'Search...',
            suffixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed:
                  () => notifier.search(
                    searchController.text,
                    tabController.index,
                  ),
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
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Error: $e')),
              );
            }).toList(),
      ),
    );
  }
}
