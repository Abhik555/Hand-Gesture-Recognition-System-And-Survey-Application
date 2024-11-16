import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestureapp/providers/modelprovider/model_provider.dart';
import 'package:gestureapp/providers/thememode/thememode_provider.dart';
import 'package:gestureapp/widgets/about_widget.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  final TextEditingController modelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isDark = ref.watch(isDarkProvider);
    int model = ref.watch(modelProviderProvider);

    return Expanded(
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          ListTile(
            subtitle: const Text("Toggle Colour Mode"),
            title: const Text("Dark Mode"),
            trailing: Switch(
                value: isDark,
                onChanged: (v) {
                  ref.watch(isDarkProvider.notifier).toggle();
                }),
          ),
          const SizedBox(height: 20),
          const ListTile(
            title: Text("Model"),
            subtitle: Text("Select the model to use"),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RadioMenuButton(
                  value: 0,
                  groupValue: model,
                  onChanged: (v) {
                    ref.watch(modelProviderProvider.notifier).changeModel(v!);
                  },
                  child: const Text("Teachable Machine Model")),
              RadioMenuButton(
                  value: 1,
                  groupValue: model,
                  onChanged: (v) {
                    ref.watch(modelProviderProvider.notifier).changeModel(v!);
                  },
                  child: const Text("Simple Model")),
              RadioMenuButton(
                  value: 2,
                  groupValue: model,
                  onChanged: (v) {
                    ref.watch(modelProviderProvider.notifier).changeModel(v!);
                  },
                  child: const Text("Complex Model")),
              RadioMenuButton(
                  value: 3,
                  groupValue: model,
                  onChanged: (v) {
                    ref.watch(modelProviderProvider.notifier).changeModel(v!);
                  },
                  child: const Text("ResNET Model")),
              const SizedBox(height: 20),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 20),
          const Center(child: AboutMe()),
        ],
      ),
    );
  }
}
