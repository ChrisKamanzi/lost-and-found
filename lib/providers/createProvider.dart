import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

// Image Files
final image1Provider = StateProvider<File?>((ref) => null);
final image2Provider = StateProvider<File?>((ref) => null);

// Dropdown selections
final postTypeProvider = StateProvider<String?>((ref) => null);
final locationProvider = StateProvider<String?>((ref) => null);

// Loading State
final isLoadingProvider = StateProvider<bool>((ref) => false);

// Controllers
final titleControllerProvider = Provider((ref) => TextEditingController());
final descriptionControllerProvider = Provider((ref) => TextEditingController());
