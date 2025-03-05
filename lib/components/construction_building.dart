import 'package:ecoland_application/components/notification.dart';
import 'package:ecoland_application/models/building.dart';
import 'package:ecoland_application/providers/buildings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ConstructBuildingDialog extends StatefulWidget {
  @override
  _ConstructBuildingDialogState createState() =>
      _ConstructBuildingDialogState();
}

class _ConstructBuildingDialogState extends State<ConstructBuildingDialog> {
  String? selectedBuildingId;
  TextEditingController nameController = TextEditingController();
  TextEditingController latController = TextEditingController();
  TextEditingController lanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final buildingsProvider = Provider.of<BuildingsProvider>(context);
    final List<DropdownMenuItem<String>> constructionList =
        buildingsProvider.constructions.map((construction) => DropdownMenuItem(
              value: construction.id,
              child: Text(construction.name),
            ));
    return Dialog(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Construct New Building",
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedBuildingId,
              decoration: const InputDecoration(labelText: "Building Type"),
              items: constructionList,
              // items: const [
              //   DropdownMenuItem(
              //     value: '1',
              //     child: Text('Farm'),
              //   ),
              //   DropdownMenuItem(
              //     value: '2',
              //     child: Text('WoodCutter'),
              //   ),
              // ],
              onChanged: (value) {
                setState(() {
                  selectedBuildingId = value;
                });
              },
            ),
            const SizedBox(height: 8),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  labelText: "Name", hintText: "Enter building name"),
            ),
            const SizedBox(height: 16),
            const Text("Place"),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: lanController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: "Lan"),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: latController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: "Lat"),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              selectedBuildingId == null
                  ? "Select a building type"
                  : "Cost: ${buildingsProvider.constructions.firstWhere(
                        (construction) =>
                            construction.id.toString() == selectedBuildingId,
                      ).cost}",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    try {
                      if (selectedBuildingId == null) {
                        showCustomNotification(context,
                            message: 'Please select a building type',
                            type: NotificationType.error);
                        return;
                      }

                      final int? lan = int.tryParse(lanController.text);
                      final int? lat = int.tryParse(latController.text);

                      if (lan == null || lat == null) {
                        showCustomNotification(context,
                            message: 'Please enter valid coordinates',
                            type: NotificationType.error);
                        return;
                      }

                      await buildingsProvider.startConstruction(
                        id: int.parse(selectedBuildingId!),
                        name: nameController.text,
                        lan: lan,
                        lat: lat,
                      );
                      Navigator.of(context).pop();
                      showCustomNotification(context,
                          message: 'Construction started successfully',
                          type: NotificationType.success);
                    } catch (e) {
                      showCustomNotification(context,
                          message: 'Start Construction failed',
                          type: NotificationType.error);
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Construct"),
                  iconAlignment: IconAlignment.end,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void showConstructBuildingDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => ConstructBuildingDialog(),
  );
}
