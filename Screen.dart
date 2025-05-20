import 'package:flutter/material.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  String? selectedRingtone;
  bool showBannerFlag = false;

  final List<String> ringtones = [
    "Nokia Tune",
    "Beep Beep",
    "Classic Ring",
    "Digital Tone",
  ];

  void showRingtoneDialog() {
    String? tempSelection = selectedRingtone;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Pilih Ringtone"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: ringtones
                .map((tone) => RadioListTile<String>(
                      title: Text(tone),
                      value: tone,
                      groupValue: tempSelection,
                      onChanged: (value) {
                        setState(() {
                          tempSelection = value!;
                        });
                        Navigator.pop(context);
                        showSelectedBanner(value!);
                      },
                    ))
                .toList(),
          ),
        );
      },
    );
  }

  void showSelectedBanner(String ringtone) {
    setState(() {
      selectedRingtone = ringtone;
      showBannerFlag = true;
    });
  }

  void applyRingtone() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Ringtone "$selectedRingtone" berhasil diterapkan.'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
    setState(() {
      showBannerFlag = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Banner + Dialog + SnackBar")),
      body: Column(
        children: [
          if (showBannerFlag && selectedRingtone != null)
            MaterialBanner(
              content: Text('Ringtone "${selectedRingtone!}" dipilih'),
              leading: const Icon(Icons.music_note, color: Colors.blue),
              backgroundColor: Colors.blue.shade50,
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      showBannerFlag = false;
                    });
                  },
                  child: const Text("Dismiss"),
                ),
                TextButton(
                  onPressed: applyRingtone,
                  child: const Text("Update"),
                ),
              ],
            ),

          // Tombol-tombol dialog dan ringtone
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: showRingtoneDialog,
            child: const Text("Pilih Ringtone"),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => showDialog(
              context: context,
              builder: (context) => showAlertDialog(context),
            ),
            child: const Text("Alert Dialog"),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => showDialog(
              context: context,
              builder: (context) => showSimpleDialog(context),
            ),
            child: const Text("Simple Dialog"),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: ((context) => const FullScreenDialog()),
              ),
            ),
            child: const Text("Fullscreen Dialog"),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              showSnackBar(context),
            ),
            child: const Text("Show SnackBar"),
          ),
        ],
      ),
    );
  }
}

// SnackBar fungsi
SnackBar showSnackBar(BuildContext context) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 6),
    content: const Text('Welcome'),
    action: SnackBarAction(
      label: 'Dismiss',
      textColor: Colors.white,
      onPressed: () => ScaffoldMessenger.of(context).removeCurrentSnackBar(),
    ),
  );
}

// Alert Dialog
AlertDialog showAlertDialog(BuildContext context) {
  return AlertDialog(
    title: const Text('Reset setting?'),
    content: const Text(
      'This will reset your device to its default factory settings',
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('CANCEL'),
      ),
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('ACCEPT'),
      ),
    ],
  );
}

// Simple Dialog
SimpleDialog showSimpleDialog(BuildContext context) {
  return SimpleDialog(
    title: const Text('Set backup account'),
    children: List.generate(4, ((index) {
      return SimpleDialogOption(
        onPressed: () => Navigator.pop(context, 'mail$index@mail.com'),
        child: Row(
          children: [
            const Icon(Icons.abc, size: 36.0, color: Colors.amber),
            const SizedBox(width: 16),
            Text('Username$index'),
          ],
        ),
      );
    })),
  );
}

// Fullscreen Dialog
class FullScreenDialog extends StatelessWidget {
  const FullScreenDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Full-Screen Dialog")),
      body: const Center(child: Text("Ini adalah Full-Screen Dialog")),
    );
  }
}
