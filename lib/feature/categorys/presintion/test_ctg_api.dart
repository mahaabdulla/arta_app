// import 'package:arta_app/feature/categorys/presintion/ctagurey_children_view.dart';
// import 'package:flutter/material.dart';
// import 'package:arta_app/feature/categorys/presintion/view_model/catagury_vm.dart';
// import 'package:arta_app/feature/categorys/data/categury_model.dart';

// class TestCtgApi extends StatefulWidget {
//   const TestCtgApi({super.key});

//   @override
//   State<TestCtgApi> createState() => _TestCtgApiState();
// }

// class _TestCtgApiState extends State<TestCtgApi> {
//   late CateguryVM ctgVM;
//   List<Category> categories = [];
//   bool loading = true;

//   @override
//   void initState() {
//     super.initState();
//     ctgVM = CateguryVM();
//     fetchCategories();
//   }

//   Future<void> fetchCategories() async {
//     setState(() {
//       loading = true;
//     });
//     categories = await ctgVM.getCtgParent();
//     setState(() {
//       loading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('عرض الفئات'),
//         backgroundColor: Colors.blue[300],
//       ),
//       body: loading
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: categories.length,
//               itemBuilder: (context, index) {
//                 Category category = categories[index];
//                 return Card(
//                   child: ListTile(
//                     title: Text(category.name),
//                     subtitle: Text('ID: ${category.id}'),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => CategoryChildrenView(
//                             parentId: category.id,
//                             parentName: category.name,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
