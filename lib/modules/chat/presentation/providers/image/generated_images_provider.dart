import 'package:gemini_app/config/gemini/gemini_impl.dart';
import 'package:gemini_app/modules/chat/presentation/providers/image/error_image_generated.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:gemini_app/modules/chat/presentation/providers/image/generated_history_provider.dart';
import 'package:gemini_app/modules/chat/presentation/providers/image/is_generating_provider.dart';

part 'generated_images_provider.g.dart';

@Riverpod(keepAlive: true)
class GeneratedImages extends _$GeneratedImages {
  final GeminiImpl geminiImpl = GeminiImpl();

  late final IsGenerating isGeneratingNotifier;
  late final GeneratedImageHistory generatedImageHistory;
  late final ErrorImageGenerated errorImageGenerated;

  String previousPrompt = "";
  List<XFile> previousFiles = [];

  @override
  List<String> build() {
    isGeneratingNotifier = ref.read(isGeneratingProvider.notifier);
    generatedImageHistory = ref.read(generatedImageHistoryProvider.notifier);
    errorImageGenerated = ref.read(errorImageGeneratedProvider.notifier);
    return [];
  }

  void addImage(String imageUrl) {
    if (imageUrl == "") return;
    generatedImageHistory.addImage(imageUrl);
    state = [...state, imageUrl];
  }

  void clearImages() {
    state = [];
  }

  Future<void> generateImage(
    String prompt, {
    List<XFile> files = const [],
  }) async {
    isGeneratingNotifier.setIsGenerating();
    errorImageGenerated.setErrorImageGenerated("");

    final response = await geminiImpl.imageGeneration(prompt, files: files);

    final imageUrl = response['imageUrl'] ?? '';
    final text = response['text'] ?? '';

    if (imageUrl.isEmpty) {
      errorImageGenerated.setErrorImageGenerated(text);
      isGeneratingNotifier.setIsNotGenerating();
      return;
    }

    previousPrompt = prompt;
    previousFiles = files;
    addImage(imageUrl);
    isGeneratingNotifier.setIsNotGenerating();

    // generamos una segunda imagen a partir del mismo prompt
    if (state.length == 1) {
      await generateImageWithPreviousPrompt();
    }
    errorImageGenerated.setErrorImageGenerated("");
  }

  Future<void> generateImageWithPreviousPrompt() async {
    if (previousPrompt.isEmpty) return;

    await generateImage(previousPrompt, files: previousFiles);
  }
}
