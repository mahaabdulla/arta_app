// File: custom_dropdown_textfield.dart
import 'package:arta_app/core/widgets/custom_text_feild.dart';
import 'package:flutter/material.dart';


class CustomDropdownTextField extends StatefulWidget {
  final String label;
  final List<String> items;
  final void Function(String) onItemSelected;
  final String? initialValue;
  final bool? readOnly;
  final String? hintText;

  const CustomDropdownTextField(
      {Key? key,
      required this.label,
      required this.items,
      required this.onItemSelected,
      this.initialValue,
      this.readOnly,
      this.hintText})
      : super(key: key);

  @override
  State<CustomDropdownTextField> createState() =>
      _CustomDropdownTextFieldState();
}

class _CustomDropdownTextFieldState extends State<CustomDropdownTextField>
    with SingleTickerProviderStateMixin {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  late List<String> _filteredItems;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? '');
    _focusNode = FocusNode();
    _filteredItems = widget.items;

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _removeOverlay();
      } else {
        _showOverlay();
      }
    });
  }

  void _filterItems(String query) {
    setState(() {
      _filteredItems = widget.items
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
    _updateOverlay();
  }

  void _showOverlay() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _updateOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        left: offset.dx,
        top: offset.dy + size.height + 5,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 5),
          child: Material(
            borderRadius: BorderRadius.circular(12),
            elevation: 8,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              constraints: BoxConstraints(
                maxHeight: 200,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: _filteredItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_filteredItems[index]),
                    onTap: () {
                      widget.onItemSelected(_filteredItems[index]);
                      _controller.text = _filteredItems[index];
                      _removeOverlay();
                      _focusNode.unfocus();
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
        link: _layerLink,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Text(
          //   widget.label,
          //   style: TextStyles.medium18
          //       .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
          // ),
          // hSpace(20.h),
          // Container(
          //   decoration: BoxDecoration(
          //     gradient: const LinearGradient(
          //       colors: [Color(0xFF74ACC4), Color(0xFF70A49E)],
          //       begin: Alignment.topLeft,
          //       end: Alignment.bottomRight,
          //     ),
          //     borderRadius: BorderRadius.circular(20),
          //   ),
          // child:
          CustomTextFormField(
            label: widget.label,
            controller: _controller,
            focusNode: _focusNode,
            hintText: widget.hintText,
            suffixIcon: Icon(
              Icons.keyboard_arrow_down_sharp,
              color: Color(0xFF046998), // نفس لون الفوكس للتماشي
              size: 28,
            ),
            onChanged: _filterItems,
            readOnly: widget.readOnly ?? false,
            customValidator: (value) {
              if (value == null || value.isEmpty) {
                return "يرجى إدخال ${widget.label}";
              }
              return null;
            },
          ),
        ]));
  }
}
