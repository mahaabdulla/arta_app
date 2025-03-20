import 'package:arta_app/feature/presentations/pages/categorys/presintion/categury_details.dart';
import 'package:flutter/material.dart';
import 'package:arta_app/feature/presentations/pages/categorys/data/categury_model.dart';
import 'package:arta_app/feature/presentations/pages/categorys/presintion/view_model/catagury_vm.dart';

class CategoryChildrenView extends StatefulWidget {
  final int parentId;
  final String parentName;

  const CategoryChildrenView(
      {required this.parentId, required this.parentName, Key? key})
      : super(key: key);

  @override
  _CategoryChildrenViewState createState() => _CategoryChildrenViewState();
}

class _CategoryChildrenViewState extends State<CategoryChildrenView> {
  late CateguryVM ctgVM;
  List<Category> children = [];
  bool loading = true;

  // @override
  // void initState() {
  //   super.initState();
  //   ctgVM = CateguryVM();
  //   fetchChildren();
  // }

  Future<void> fetchChildren() async {
    setState(() {
      loading = true;
    });
    children = await ctgVM.getChildren(widget.parentId);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.parentName}'),
        backgroundColor: Colors.green[300],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: children.length,
              itemBuilder: (context, index) {
                Category child = children[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.green[300],
                      child: Text('ID:${child.id}'),
                    ),
                    title: Text(child.name),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CategoryDetailPage(categoryId: child.id),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
