// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:arta_app/core/utils/global_methods/global_methods.dart';
// import 'package:arta_app/feature/presentations/pages/user/widgets/profile_scafoold.dart';

// class EditProfileFieldScreen extends StatefulWidget {
//   final String title;
//   final String fieldLabel;
//   final String initialValue;
//   final Function(String) onSave;

//   const EditProfileFieldScreen({
//     required this.title,
//     required this.fieldLabel,
//     required this.initialValue,
//     required this.onSave,
//   });

//   @override
//   _EditProfileFieldScreenState createState() => _EditProfileFieldScreenState();
// }

// class _EditProfileFieldScreenState extends State<EditProfileFieldScreen> {
//   final _formKey = GlobalKey<FormState>();
//   late TextEditingController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = TextEditingController(text: widget.initialValue);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ProfileScaffold(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _controller,
//                 decoration: InputDecoration(
//                   labelText: widget.fieldLabel,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(16.0),
//                   ),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "يرجى إدخال ${widget.fieldLabel}";
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               BlocConsumer<UserCubit, UserState>(
//                 listener: (context, state) {
//                   if (state is EditProfileSuccess) {
//                     Fluttertoast.showToast(
//                       msg: "تم التحديث بنجاح",
//                       backgroundColor: Colors.green,
//                     );
//                     Navigator.pop(context);
//                   } else if (state is EditProfileFailure) {
//                     toast(
//                       state.message,
//                       bgColor: Colors.red,
//                       print: true,
//                       gravity: ToastGravity.BOTTOM,
//                       textColor: Colors.white,
//                     );
//                   }
//                 },
//                 builder: (context, state) {
//                   return SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         if (_formKey.currentState!.validate()) {
//                           widget.onSave(_controller.text);
//                         }
//                       },
//                       child: Text("حفظ التغيير"),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



//كنت بسويها كوستم ودجت لحقول الادخال للبروفايل 