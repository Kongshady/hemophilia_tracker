import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../services/firestore.dart';

class CareProviderScreen extends StatefulWidget {
  const CareProviderScreen({super.key});

  @override
  State<CareProviderScreen> createState() => _CareProviderScreenState();
}

class _CareProviderScreenState extends State<CareProviderScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _emergencyContactController = TextEditingController();
  
  List<Map<String, dynamic>> _filteredProviders = [];
  bool _isSearching = false;

  void _onSearchChanged(String query) async {
    if (query.isEmpty) {
      setState(() {
        _filteredProviders = [];
        _isSearching = false;
      });
      return;
    }

    setState(() => _isSearching = true);
    try {
      final providers = await _firestoreService.searchHealthcareProviders(query);
      setState(() {
        _filteredProviders = providers;
        _isSearching = false;
      });
    } catch (e) {
      setState(() => _isSearching = false);
      _showError('Error searching providers: $e');
    }
  }

  void _addEmergencyContact() async {
    final contactPhone = _emergencyContactController.text.trim();
    if (contactPhone.isEmpty) {
      _showError('Please enter a phone number');
      return;
    }

    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        await _firestoreService.addEmergencyContact(uid, contactPhone);
        _emergencyContactController.clear();
        Navigator.of(context).pop();
        _showSuccess('Emergency contact added successfully');
      }
    } catch (e) {
      _showError('Error adding emergency contact: $e');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Healthcare Providers',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Healthcare Providers'),
                  content: Text('Find and connect with healthcare professionals who can help manage your hemophilia care.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search healthcare providers...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _onSearchChanged('');
                        },
                      )
                    : null,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_searchController.text.isNotEmpty) ...[
              Text(
                'Search Results',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: _isSearching
                    ? Center(child: CircularProgressIndicator())
                    : _filteredProviders.isEmpty
                        ? Center(
                            child: Text(
                              'No healthcare providers found',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          )
                        : ListView.builder(
                            itemCount: _filteredProviders.length,
                            itemBuilder: (context, index) {
                              final provider = _filteredProviders[index];
                              return ProviderListTile(provider: provider);
                            },
                          ),
              ),
            ] else ...[
              Text(
                'All Healthcare Providers',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firestoreService.getHealthcareProviders(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error loading providers: ${snapshot.error}'),
                      );
                    }

                    final providers = snapshot.data?.docs ?? [];
                    if (providers.isEmpty) {
                      return Center(
                        child: Text(
                          'No healthcare providers available',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: providers.length,
                      itemBuilder: (context, index) {
                        final provider = {
                          ...providers[index].data() as Map<String, dynamic>,
                          'id': providers[index].id,
                        };
                        return ProviderListTile(provider: provider);
                      },
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: SafeArea(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Add Emergency Contact',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        TextField(
                          controller: _emergencyContactController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: 'Enter phone number',
                            prefixIcon: Icon(Icons.phone, color: Colors.redAccent),
                            border: UnderlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 24),
                        FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: _addEmergencyContact,
                          child: Text(
                            'Save Contact',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        icon: Icon(FontAwesomeIcons.circlePlus),
        label: Text(
          'Emergency Contact',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
      ),
    );
  }
}

class ProviderListTile extends StatelessWidget {
  final Map<String, dynamic> provider;

  const ProviderListTile({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(
          provider['name'] ?? 'Unknown Provider',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          provider['email'] ?? 'No email provided',
          style: TextStyle(color: Colors.grey[600]),
        ),
        leading: CircleAvatar(
          backgroundColor: Colors.redAccent,
          child: Icon(
            Icons.local_hospital,
            color: Colors.white,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.redAccent),
        tileColor: Colors.grey.shade100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/care_user_information',
            arguments: provider,
          );
        },
      ),
    );
  }
}
