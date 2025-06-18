import 'package:flutter/material.dart';
import 'SignUpPage.dart';


class SettingPage extends StatefulWidget {
  final String username;
  final String email;
  final String sign;

  const SettingPage({super.key, required this.username, required this.email, required String settingall, required this.sign, required String account});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isPrivate = false;
  bool notificationsEnabled = true;

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController currentPass = TextEditingController();
        final TextEditingController newPass = TextEditingController();
        return AlertDialog(
          title: const Text('Change Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: currentPass,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Current Password'),
              ),
              TextField(
                controller: newPass,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'New Password'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Password changed (demo)!')),
                );
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void _confirmDeleteAccount() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text('Are you sure you want to delete your account?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => SignUpPage()),
                (route) => false,
              );
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showClearCacheDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cache'),
        content: const Text('Do you want to clear app cache?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cache cleared!')),
              );
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _showNotAvailable() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Feature not available yet.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    String today = DateTime.now().toString().split(' ')[0];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSection('Account Info'),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.teal),
            title: const Text('Username'),
            subtitle: Text(widget.username),
          ),
          ListTile(
            leading: const Icon(Icons.email, color: Colors.teal),
            title: const Text('Email'),
            subtitle: Text(widget.email),
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today, color: Colors.teal),
            title: const Text('Joined'),
            subtitle: Text(today),
          ),

          const SizedBox(height: 20),
          _buildSection('Privacy & Security'),
          SwitchListTile(
            title: const Text('Make Profile Private'),
            value: isPrivate,
            onChanged: (val) => setState(() => isPrivate = val),
            secondary: const Icon(Icons.lock, color: Colors.teal),
          ),
          ListTile(
            leading: const Icon(Icons.password, color: Colors.teal),
            title: const Text('Change Password'),
            onTap: _showChangePasswordDialog,
          ),
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: const Text('Delete Account'),
            onTap: _confirmDeleteAccount,
          ),

          const SizedBox(height: 20),
          _buildSection('Notifications'),
          SwitchListTile(
            title: const Text('Enable Notifications'),
            value: notificationsEnabled,
            onChanged: (val) => setState(() => notificationsEnabled = val),
            secondary: const Icon(Icons.notifications_active, color: Colors.teal),
          ),

          const SizedBox(height: 20),
          _buildSection('App Data'),
          ListTile(
            leading: const Icon(Icons.delete_sweep, color: Colors.teal),
            title: const Text('Clear Cache'),
            onTap: _showClearCacheDialog,
          ),

          const SizedBox(height: 30),
          Center(
            child: Text(
              'Habit Tracker v1.0.0',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.teal,
        ),
      ),
    );
  }
}
