import 'package:riverpod/riverpod.dart';
import 'package:lost_and_found/models/create_ad_model.dart';

class CreateAdNotifier extends StateNotifier<CreateAd> {
  CreateAdNotifier()
      : super(CreateAd(
    selectedCategory: '',
    post_type: '',
    title: '',
    description: '',
    location: [],
  )
  );
  void updatePostStpe(post_type) {
    state = CreateAd(
      selectedCategory: state.selectedCategory,
      post_type:post_type ,
      title: state.title,
      description: state.description,
      location: state.location,
    );
  }

  void updateCategory(categories) {
    state = CreateAd(
      selectedCategory: categories,
      post_type: state.post_type ,
      title: state.title,
      description: state.description,
      location: state.location,
    );
  }

  void updateTitle(String title) {
    state = CreateAd(
      selectedCategory: state.selectedCategory,
      post_type: state.post_type,
      title: title,
      description: state.description,
      location: state.location,
    );
  }

  void updateDescription(String description) {
    state = CreateAd(
      selectedCategory: state.selectedCategory,
      post_type: state.post_type,
      title: state.title,
      description: description,
      location: state.location,
    );
  }

  void updateLocation(List<String> location) {
    state = CreateAd(
      selectedCategory: state.selectedCategory,
      post_type: state.post_type,
      title: state.title,
      description: state.description,
      location: location,
    );
  }
}

final createAdProvider = StateNotifierProvider<CreateAdNotifier, CreateAd>(
      (ref) => CreateAdNotifier(),
);
