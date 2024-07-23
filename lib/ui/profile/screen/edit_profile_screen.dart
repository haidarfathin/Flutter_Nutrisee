// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class EditProfileScreen extends StatefulWidget {
//   const EditProfileScreen({super.key});

//   @override
//   State<EditProfileScreen> createState() => _EditProfileScreenState();
// }

// class _EditProfileScreenState extends State<EditProfileScreen> {
//   File? selectedImage;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Edit Profile"),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//       ),
//       body: SingleChildScrollView(
//           child: Column(
//         children: [
//           Align(
//             alignment: Alignment.center,
//             child: Column(
//               children: [
//                 Stack(
//                   children: [
//                     selectedImage!=null ? 
//                   ],
//                 )
//               ],
//             ),
//           )
//         ],
//       )),
//     );
//   }

//   Future pickImageFromGallery() async {
//     final returnedImage =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//   }
// }
