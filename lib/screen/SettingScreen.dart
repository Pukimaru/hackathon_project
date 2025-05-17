import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  Widget buildSettingItem({
    required IconData icon,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
    Color? iconColor,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4), // less padding
      dense: true, // compact height
      leading: Icon(icon, color: iconColor ?? Colors.blue),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
      subtitle: subtitle != null
          ? Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[600]))
          : null,
      onTap: onTap,
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(
        children: [
          buildSettingItem(
            icon: LucideIcons.link,
            title: 'Manage Linked Accounts',
            subtitle: 'Link or unlink your bank and e-wallet accounts',
            onTap: () {},
          ),
          buildSettingItem(
            icon: LucideIcons.shieldCheck,
            title: 'Security & Authentication',
            subtitle: 'Enable fingerprint or face ID access',
            onTap: () {},
          ),
          buildSettingItem(
            icon: LucideIcons.phone,
            title: 'Change Mobile Number',
            subtitle: 'Update your registered phone number',
            onTap: () {},
          ),
          buildSettingItem(
            icon: LucideIcons.languages,
            title: 'Language',
            subtitle: 'Select your preferred language',
            onTap: () {},
          ),
          buildSettingItem(
            icon: LucideIcons.userPlus,
            title: 'Invite a Friend',
            subtitle: 'Share the app and earn rewards',
            onTap: () {},
          ),
          buildSettingItem(
            icon: LucideIcons.fileText,
            title: 'Terms & Conditions',
            onTap: () {},
          ),
          buildSettingItem(
            icon: LucideIcons.helpCircle,
            title: 'Help Center',
            onTap: () {},
          ),
          Divider(height: 16),
          buildSettingItem(
            icon: LucideIcons.trash,
            title: 'Delete Account',
            subtitle: 'Permanently remove your account',
            onTap: () {},
            iconColor: Colors.red,
          ),
        ],
      ),
    );
  }
}

