import 'package:flutter/material.dart';

class UploadDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Upload Financial Statement', style: TextStyle(fontSize: 18),),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.picture_as_pdf, size: 30),
            label: Text('PDF', style: TextStyle(fontSize: 20, color: Colors.white)),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              backgroundColor: Colors.lightBlueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.insert_drive_file, size: 30),
            label: Text('CSV', style: TextStyle(fontSize: 20, color: Colors.white)),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              backgroundColor: Colors.lightBlueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text('Cancel', style: TextStyle(color: Colors.black)),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}