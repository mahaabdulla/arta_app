import 'package:flutter/material.dart';
import 'package:arta_app/feature/categorys/data/categury_model.dart';
import 'package:arta_app/feature/categorys/presintion/view_model/catagury_vm.dart';

class CategoryDetailPage extends StatefulWidget {
  final int categoryId;

  CategoryDetailPage({required this.categoryId});

  @override
  _CategoryDetailPageState createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  late CateguryVM ctgVM;
  Category? category;
  List<Category> children = [];
  bool loading = true;
  bool loadingChildren = false;

  @override
  void initState() {
    super.initState();
    ctgVM = CateguryVM();
    fetchCategoryDetails();
    fetchChildren();
  }

  Future<void> fetchCategoryDetails() async {
    setState(() {
      loading = true;
    });
    category = await ctgVM.getSingleCatg(widget.categoryId);
    setState(() {
      loading = false;
    });
  }

  Future<void> fetchChildren() async {
    setState(() {
      loadingChildren = true;
    });
    children = await ctgVM.getChildren(widget.categoryId);
    setState(() {
      loadingChildren = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category?.name ?? 'تفاصيل الفئة'),
        backgroundColor: Colors.purple[300],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : category != null
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text('اسم الفئة: ${category!.name}',
                        //     style: TextStyle(fontSize: 20)),
                        // SizedBox(height: 10),
                        // Text('ID: ${category!.id}',
                        //     style: TextStyle(fontSize: 16)),
                        // Text('Parent ID: ${category!.parentId}'),
                        // SizedBox(height: 20),
                        // Text('الفئات الفرعية:', style: TextStyle(fontSize: 18)),
                        loadingChildren
                            ? Center(child: CircularProgressIndicator())
                            : children.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: children.length,
                                    itemBuilder: (context, index) {
                                      Category child = children[index];
                                      return ListTile(
                                        title: Text(child.name),
                                        subtitle: Text('ID: ${child.id}'),
                                      );
                                    },
                                  )
                                : Text('لا توجد فئات فرعية.')
                      ],
                    ),
                  ),
                )
              : Center(child: Text('لا توجد بيانات لهذه الفئة')),
    );
  }
}
