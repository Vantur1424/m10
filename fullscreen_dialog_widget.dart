import 'package:flutter/material.dart';

class RingtoneSelector extends StatefulWidget {
  const RingtoneSelector({super.key});

  @override
  State<RingtoneSelector> createState() => _RingtoneSelectorState();
}

class _RingtoneSelectorState extends State<RingtoneSelector> {
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
      appBar: AppBar(title: const Text("Ringtone Picker")),
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
          const SizedBox(height: 40),
          Center(
            child: ElevatedButton(
              onPressed: showRingtoneDialog,
              child: const Text("Pilih Ringtone"),
            ),
          ),
        ],
      ),
    );
  }
}
