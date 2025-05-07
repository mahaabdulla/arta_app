// import 'package:arta_app/feature/presentations/pages/ads/view_model/region_vm.dart';
import 'package:flutter/material.dart';


class RegionView extends StatefulWidget {
  const RegionView({Key? key}) : super(key: key);

  @override
  State<RegionView> createState() => _RegionViewState();
}

class _RegionViewState extends State<RegionView> {
  // final RegionVM _regionVM = RegionVM();
  List<dynamic> parentRegions = [];
  List<dynamic> childRegions = [];
  int? selectedParentId;

  @override
  void initState() {
    super.initState();
    _fetchParentRegions(); // Fetch parent regions when the view initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Region Management'),
        backgroundColor: const Color(0xff055479),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Parent Regions Dropdown
            const Text(
              'Select Parent Region:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            parentRegions.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : DropdownButton<int>(
                    value: selectedParentId,
                    hint: const Text('Select a parent region'),
                    isExpanded: true,
                    items: parentRegions.map((parent) {
                      return DropdownMenuItem<int>(
                        value: parent['id'],
                        child: Text(parent['name']),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedParentId = value;
                      });
                      _fetchChildRegions(value!);
                    },
                  ),
            const SizedBox(height: 16),

            // Child Regions Display
            const Text(
              'Child Regions:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            childRegions.isEmpty
                ? const Text('No child regions available.')
                : Expanded(
                    child: ListView.builder(
                      itemCount: childRegions.length,
                      itemBuilder: (context, index) {
                        final child = childRegions[index];
                        return ListTile(
                          title: Text(child['name'] ?? 'No Name'),
                          subtitle: Text('ID: ${child['id']}'),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  /// Fetches all parent regions and updates the dropdown.
  void _fetchParentRegions() async {
    // List<dynamic> fetchedParentRegions = await _regionVM.getParentRegions();
    setState(() {
      // parentRegions = fetchedParentRegions;
    });
  }

  /// Fetches child regions for the selected parent and updates the list.
  void _fetchChildRegions(int parentId) async {
    // List<dynamic> fetchedChildRegions =
        // await _regionVM.getChildRegions(parentId);
    setState(() {
      // childRegions = fetchedChildRegions;
    });
  }
}
