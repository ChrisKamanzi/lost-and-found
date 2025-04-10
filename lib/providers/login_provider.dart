import 'package:riverpod/riverpod.dart';
import '../models/create_ad_model.dart';

class CreateAdNotifier extends StateNotifier<CreateAd> {
  CreateAdNotifier()
      : super(CreateAd(
    selectedCategory: [],
    title: '',
    description: '',
    location: [],
  ));

  void updateTitle(String newTitle) {
    state = CreateAd(
      selectedCategory: state.selectedCategory,
      title: newTitle,
      description: state.description,
      location: state.location,
    );
  }

  void updateDescription(String newDescription) {
    state = CreateAd(
      selectedCategory: state.selectedCategory,
      title: state.title,
      description: newDescription,
      location: state.location,
    );
  }

  void updateCategory(List<String> newCategories) {
    state = CreateAd(
      selectedCategory: newCategories,
      title: state.title,
      description: state.description,
      location: state.location,
    );
  }

  void updateLocation(List<String> newLocation) {
    state = CreateAd(
      selectedCategory: state.selectedCategory,
      title: state.title,
      description: state.description,
      location: newLocation,
    );
  }

  void reset() {
    state = CreateAd(
      selectedCategory: [],
      title: '',
      description: '',
      location: [],
    );
  }
}
