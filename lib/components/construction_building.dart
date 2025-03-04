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
  String? selectedBuildingType;
  TextEditingController nameController =
      TextEditingController(text: "Default Type Name");
  TextEditingController latController = TextEditingController();
  TextEditingController lanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final buildingsProvider = Provider.of<BuildingsProvider>(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      title: Text("Construct New Building"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<String>(
            value: selectedBuildingType,
            decoration: InputDecoration(labelText: "Building Type"),
            items: buildingsProvider.buildings //TODo: add list from provider
                .map((building) => DropdownMenuItem(
                    value: building.id, child: Text(building.name)))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedBuildingType = value;
              });
            },
          ),
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: "Name"),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Place"),
                  Row(
                    children: [
                      Flexible(
                        child: TextField(
                          controller: lanController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: "Lan"),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: TextField(
                          controller: latController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: "Lat"),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Text("Cost\n1000\$",
                  textAlign: TextAlign
                      .center), //ToDo add cost from selected construction
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed:
                () {}, // TODO: Add logic to call start construction endpoint
            icon: Icon(Icons.add),
            label: Text("Construct"),
          )
        ],
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
