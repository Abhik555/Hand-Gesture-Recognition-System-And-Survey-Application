import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'thememode_provider.g.dart';

@Riverpod(keepAlive: true)
class isDark extends _$isDark {
  @override
  bool build() {
    return true;
  }

  void toggle() {
    state = !state;
  }
}
