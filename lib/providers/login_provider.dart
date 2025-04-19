import 'package:riverpod/riverpod.dart';
import '../models/create_ad_model.dart';

class CreateAdNotifier extends StateNotifier<CreateAd> {
  CreateAdNotifier()
      : super(CreateAd(
    selectedCategory: '',
    post_type: '',
    title: '',
    description: '',
    location: [],
  ));

  void updateTitle(String newTitle) {
    state = CreateAd(
      selectedCategory: state.selectedCategory,
      post_type: state.post_type,
      title: newTitle,
      description: state.description,
      location: state.location,
    );
  }
  void updatePostTypr(String newPostType) {
    state = CreateAd(
      selectedCategory: state.selectedCategory,
      post_type: newPostType,
      title: state.title,
      description: state.description,
      location: state.location,
    );
  }
  void updateDescription(String newDescription) {
    state = CreateAd(
      selectedCategory: state.selectedCategory,
      post_type: state.post_type,
      title: state.title,
      description: newDescription,
      location: state.location,
    );
  }

  void updateCategory(newCategories) {
    state = CreateAd(
      selectedCategory: newCategories,
      post_type: state.post_type,

      title: state.title,
      description: state.description,
      location: state.location,
    );
  }

  void updateLocation(List<String> newLocation) {
    state = CreateAd(
      selectedCategory: state.selectedCategory,
      post_type: state.post_type,

      title: state.title,
      description: state.description,
      location: newLocation,
    );
  }

  void reset() {
    state = CreateAd(
      selectedCategory: '',
      post_type: '',
      title: '',
      description: '',
      location: [],
    );
  }
}
