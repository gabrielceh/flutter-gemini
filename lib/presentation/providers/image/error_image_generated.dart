import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'error_image_generated.g.dart';

@riverpod
class ErrorImageGenerated extends _$ErrorImageGenerated {
  @override
  String build() => '';

  void setErrorImageGenerated(String errorImage) {
    state = errorImage;
  }
}
