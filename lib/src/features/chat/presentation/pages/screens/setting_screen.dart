import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // Import for File

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _darkModeEnabled = false;
  String _profileName = "Otoboy";
  File? _profileImage;

  // Define a common TextStyle
  final TextStyle _commonTextStyle = const TextStyle(
    fontSize: 18, // Set your desired font size here
    fontWeight: FontWeight.normal, // Change to bold where necessary
    color: Colors.black, // Set the text color
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: _profileImage != null
                      ? FileImage(_profileImage!)
                      : AssetImage('assets/icons/user.png') as ImageProvider,
                ),
                SizedBox(height: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _profileName,
                      style: _commonTextStyle.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {

                          },
                          child: Text('Edit Profile ', style: _commonTextStyle),
                        ),
                        Expanded(
                          child: IconButton(
                            icon: const Icon(Icons.edit, color: Colors.white),
                            onPressed: () {
                              _editProfileName();

                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {

                          },
                          child: Text('Change profile photo ', style: _commonTextStyle),
                        ),
                        Expanded(
                          child: IconButton(
                            icon: const Icon(Icons.camera_alt_rounded, color: Colors.white),
                            onPressed: () {

                              _changeProfilePicture();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(),
                SwitchListTile(
                  title: Text('Dark Mode', style: _commonTextStyle),
                  value: _darkModeEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      _darkModeEnabled = value;
                    });
                  },
                ),
                const Divider(),
                ListTile(
                  title: Text('Add Account', style: _commonTextStyle),
                  onTap: () {
                    _addAccount();
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _signOut();
                  },
                  child: const Text('Sign Out'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _editProfileName() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController controller = TextEditingController(text: _profileName);
        return AlertDialog(
          title: const Text('Edit Profile Name'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: 'Profile Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _profileName = controller.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _changeProfilePicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    } else {
      // Handle case where user cancels picking an image
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No image selected')),
      );
    }
  }

  void _addAccount() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Add account clicked')),
    );
  }

  void _signOut() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Signed out!')),
    );
  }
}
