import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/favorite_model.dart';
import '../Notifier/favorite_notifier.dart';

final favoritesProvider =
AsyncNotifierProvider<FavoritesNotifier, List<FavoriteItem>>(
  FavoritesNotifier.new,
);