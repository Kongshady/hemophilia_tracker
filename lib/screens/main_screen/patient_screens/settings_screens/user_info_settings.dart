import 'package:flutter/material.dart';
import 'package:hemophilia_manager/auth/auth.dart';
import 'package:hemophilia_manager/services/firestore.dart';

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
  String name = '';
  String email = '';
  String photoUrl = '';
  bool _isLoading = false;

  final List<String> genderOptions = ['Male', 'Female', 'Other'];
  final List<String> hemoTypes = ['Hemophilia A', 'Hemophilia B', 'Other'];

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    setState(() => _isLoading = true);
    final user = AuthService().currentUser;
    if (user != null) {
      email = user.email ?? '';
      photoUrl = user.photoURL ?? '';
      final userData = await FirestoreService().getUser(user.uid);
      if (userData != null) {
        setState(() {
          name = userData['name'] ?? '';
          gender = userData['gender'] ?? gender;
          hemophiliaType = userData['hemophiliaType'] ?? hemophiliaType;
          weight = userData['weight'] ?? weight;
          dob = userData['dob'] != null
              ? DateTime.tryParse(userData['dob'])
              : dob;
        });
      }
    }
    setState(() => _isLoading = false);
  }

  Future<void> _saveProfile() async {
    setState(() => _isLoading = true);
    final user = AuthService().currentUser;
    if (user != null) {
      await FirestoreService().updateUser(
        user.uid,
        name,
        email,
        null,
        extra: {
          'gender': gender,
          'hemophiliaType': hemophiliaType,
          'weight': weight,
          'dob': dob?.toIso8601String(),
        },
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile updated!'),
          backgroundColor: Colors.green,
        ),
      );
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              padding: EdgeInsets.symmetric(horizontal: 22, vertical: 18),
              children: [
                // User Image Centered
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: photoUrl.isNotEmpty
                            ? NetworkImage(photoUrl)
                            : AssetImage('assets/avatar_placeholder.png')
                                  as ImageProvider,
                        child: photoUrl.isEmpty
                            ? Icon(
                                Icons.person,
                                size: 40,
                                color: Colors.white70,
                              )
                            : null,
                      ),
                      SizedBox(height: 12),
                      Text(
                        name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        email,
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Divider(),
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
                    dob == null
                        ? 'Select'
                        : '${dob!.month}/${dob!.day}/${dob!.year}',
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
                    if (selected != null) {
                      setState(() => hemophiliaType = selected);
                    }
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
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      textAlign: TextAlign.end,
                      onChanged: (val) => setState(() => weight = val),
                      controller: TextEditingController(text: weight),
                    ),
                  ),
                ),
                Divider(),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _isLoading ? null : _saveProfile,
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Save Info',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
