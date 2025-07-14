import 'package:flutter/material.dart';

class UserInfoSettings extends StatefulWidget {
  const UserInfoSettings({super.key});

  @override
  State<UserInfoSettings> createState() => _UserInfoSettingsState();
}

class _UserInfoSettingsState extends State<UserInfoSettings> {
  String gender = 'Male';
  DateTime? dob;
  String hemophiliaType = 'Hemophilia A';
  String weight = '';

  final List<String> genderOptions = ['Male', 'Female', 'Other'];
  final List<String> hemoTypes = ['Hemophilia A', 'Hemophilia B', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Profile'), centerTitle: true),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 22, vertical: 18),
        children: [
          ListTile(
            title: Text('Gender'),
            trailing: Text(
              gender,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            onTap: () async {
              final selected = await showDialog<String>(
                context: context,
                builder: (context) => SimpleDialog(
                  title: Text(
                    'Select Gender',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  children: genderOptions
                      .map(
                        (g) => SimpleDialogOption(
                          child: Text(g),
                          onPressed: () => Navigator.pop(context, g),
                        ),
                      )
                      .toList(),
                ),
              );
              if (selected != null) setState(() => gender = selected);
            },
          ),
          Divider(),
          ListTile(
            title: Text('Date of Birth'),
            trailing: Text(
              dob == null ? 'Select' : '${dob!.month}/${dob!.day}/${dob!.year}',
              style: TextStyle(color: Colors.black87),
            ),
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: dob ?? DateTime(2000, 1, 1),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (picked != null) setState(() => dob = picked);
            },
          ),
          Divider(),
          ListTile(
            title: Text('Hemophilia Type'),
            trailing: Text(
              hemophiliaType,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            onTap: () async {
              final selected = await showDialog<String>(
                context: context,
                builder: (context) => SimpleDialog(
                  title: Text(
                    'Select Hemophilia Type',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  children: hemoTypes
                      .map(
                        (h) => SimpleDialogOption(
                          child: Text(h),
                          onPressed: () => Navigator.pop(context, h),
                        ),
                      )
                      .toList(),
                ),
              );
              if (selected != null) setState(() => hemophiliaType = selected);
            },
          ),
          Divider(),
          ListTile(
            title: Text('Weight (kg)'),
            trailing: SizedBox(
              width: 80,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'e.g. 60',
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                textAlign: TextAlign.end,
                onChanged: (val) => setState(() => weight = val),
              ),
            ),
          ),
          Divider(),
          SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                // Save logic here
              },
              style: FilledButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Save Changes',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
