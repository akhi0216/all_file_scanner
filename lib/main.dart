// ===========================================================

// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'File Search by Extension',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: FileSearchPage(),
//     );
//   }
// }

// class FileSearchPage extends StatefulWidget {
//   @override
//   _FileSearchPageState createState() => _FileSearchPageState();
// }

// class _FileSearchPageState extends State<FileSearchPage> {
//   List<String> _selectedFiles = [];
//   String _extension = '';

//   void _pickFiles() async {
//     if (_extension.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please enter a file extension')),
//       );
//       return;
//     }

//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: [_extension],
//       allowMultiple: true,
//     );

//     if (result != null) {
//       setState(() {
//         _selectedFiles =
//             result.paths.where((path) => path != null).cast<String>().toList();
//       });
//     } else {
//       setState(() {
//         _selectedFiles = [];
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('File Search by Extension'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'File Extension (e.g. txt, pdf, jpg)',
//                 border: OutlineInputBorder(),
//               ),
//               onChanged: (value) {
//                 _extension = value;
//               },
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _pickFiles,
//               child: Text('Pick Files'),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: _selectedFiles.isEmpty
//                   ? Center(child: Text('No files selected'))
//                   : ListView.builder(
//                       itemCount: _selectedFiles.length,
//                       itemBuilder: (context, index) {
//                         return ListTile(
//                           title: Text(_selectedFiles[index]),
//                         );
//                       },
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File Search by Extension',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FileSearchPage(),
    );
  }
}

class FileSearchPage extends StatefulWidget {
  @override
  _FileSearchPageState createState() => _FileSearchPageState();
}

class _FileSearchPageState extends State<FileSearchPage> {
  List<String> _selectedFiles = [];
  String _extension = '';
                        
  void _pickDirectory() async {
    String? directoryPath = await FilePicker.platform.getDirectoryPath();

    if (directoryPath != null) {
      Directory directory = Directory(directoryPath);
      List<FileSystemEntity> files = directory.listSync(recursive: true);
      List<String> filteredFiles = files
          .where((file) => file is File && file.path.endsWith('.$_extension'))
          .map((file) => file.path)
          .toList();

      setState(() {
        _selectedFiles = filteredFiles;
      });
    } else {
      setState(() {
        _selectedFiles = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Search by Extension'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'File Extension (e.g. txt, pdf, jpg)',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                _extension = value;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickDirectory,
              child: Text('Pick Directory'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: _selectedFiles.isEmpty
                  ? Center(child: Text('No files found'))
                  : ListView.builder(
                      itemCount: _selectedFiles.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_selectedFiles[index]),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
