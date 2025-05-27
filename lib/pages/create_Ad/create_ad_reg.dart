import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_and_found/generated/app_localizations.dart';
import 'package:lost_and_found/widgets/text_field.dart';
import '../../models/create_ad_model.dart';
import '../../stateManagment/provider/category_provider.dart';
import '../../stateManagment/provider/village_provider.dart';
import '../services/create.dart';
import '../services/create_ad.dart';

class CreateAdReg extends ConsumerStatefulWidget {
  const CreateAdReg({super.key});

  @override
  ConsumerState<CreateAdReg> createState() => _CreateAdRegState();
}

class _CreateAdRegState extends ConsumerState<CreateAdReg> {
  File? image1;
  File? image2;
  String? selectedLocation;
  String? selectedPostType;
  bool isLoading = false;

  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.read(categoryProvider.notifier).fetchCategories();
    ref.read(villageProvider.notifier).fetchVillages();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final villages = ref.watch(villageProvider);
    final isLoading = ref.watch(createAdNotifierProvider);

    final imageState = ref.watch(imagePickerProvider);
    final imageNotifier = ref.read(imagePickerProvider.notifier);

    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)!.create_ad,
                  style: GoogleFonts.brawler(
                    textStyle: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color:
                      Theme
                          .of(context)
                          .brightness == Brightness.dark
                          ? Colors.orangeAccent
                          : Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                DropdownButtonFormField<String>(
                  hint: Text(
                    AppLocalizations.of(context)!.category,
                    style: TextStyle(
                      color:
                      Theme
                          .of(context)
                          .brightness == Brightness.dark
                          ? Colors.black
                          : Colors.blueGrey,
                    ),
                  ),
                  value: selectedCategory,
                  items:
                  categories.map((cat) {
                    return DropdownMenuItem<String>(
                      value: cat['id'],
                      child: Text(
                        cat['name'],
                        style: TextStyle(fontSize: 20),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    ref
                        .read(selectedCategoryProvider.notifier)
                        .state = value;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  hint: Text(
                    AppLocalizations.of(context)!.post_type,
                    style: TextStyle(
                      color:
                      Theme
                          .of(context)
                          .brightness == Brightness.dark
                          ? Colors.black
                          : Colors.blueGrey,
                    ),
                  ),
                  value: selectedPostType,
                  items:
                  ['Lost', 'Found'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(fontSize: 20)),
                    );
                  }).toList(),
                  onChanged:
                      (value) => setState(() => selectedPostType = value),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                Textfield(controller: title,
                    hintText: AppLocalizations.of(context)!.title),
                SizedBox(height: 20),
                Textfield(controller: description,
                    hintText: AppLocalizations.of(context)!.description),
                SizedBox(height: 20),

                Align(
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    child: DropdownButtonFormField<String>(
                      hint: Text(AppLocalizations.of(context)!.selectVillage),
                      value: selectedLocation,
                      items:
                      villages.map((village) {
                        return DropdownMenuItem<String>(
                          value: village['id'],
                          child: Text(
                            village['name'],
                            style: const TextStyle(fontSize: 20),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedLocation = value;
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.upload_image,
                      style: GoogleFonts.brawler(
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => imageNotifier.pickImage(),
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.orange.shade700,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.purpleAccent,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.add_a_photo,
                            size: 30,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      height: 150,
                      width: 180,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.orange.shade700),
                      ),
                      child:
                      imageState.image1 != null
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(
                          imageState.image1!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      )
                          : Center(
                        child: Text(
                          AppLocalizations.of(context)!.no_image_selected,
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    // Image 2 Container
                    Container(
                      height: 150,
                      width: 180,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.orange.shade700),
                      ),
                      child:
                      imageState.image2 != null
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(
                          imageState.image2!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ) :
                      Center(
                        child: Text(
                          AppLocalizations.of(context)!.press_icon,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(height: 40),
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade600,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                    ),
                    onPressed:
                    isLoading
                        ? null
                        : () async {
                      image1 = imageState.image1;
                      image2 = imageState.image2;

                      final createAdData = CreateAd(
                        title: title.text,
                        description: description.text,
                        post_type: selectedPostType,
                        location:
                        selectedLocation != null
                            ? [selectedLocation!]
                            : [],
                        villageId: selectedLocation,
                        image1: image1,
                        image2: image2,
                      );

                      final error = await ref
                          .read(createAdNotifierProvider.notifier)
                          .save(createAdData);

                      if (error != null) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(error)));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                AppLocalizations.of(context)!.ad_success),
                          ),
                        );

                        title.clear();
                        description.clear();
                        image1 = null;
                        image2 = null;
                        selectedPostType = null;
                        selectedLocation = null;
                        ref
                            .read(selectedCategoryProvider.notifier)
                            .state = null;
                      }
                    },

                    child:
                    isLoading
                        ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ):
                    Text(
                      AppLocalizations.of(context)!.submit,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w800
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black45,
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
