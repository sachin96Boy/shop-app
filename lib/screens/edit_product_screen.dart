import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../models/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formkey = GlobalKey<FormBuilderState>();

  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();

  final _imageUrlConroller = TextEditingController();

  final initialValues = {
    "title": "",
    "price": "",
    "description": "",
    "imageUrl": ""
  };

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();

    _imageUrlConroller.dispose();
    super.dispose();
  }

  void _saveForm() {
    _formkey.currentState?.save();
    final formData = _formkey.currentState?.value;
    final newProduct = Product(
        id: DateTime.now().toString(),
        title: formData?["title"],
        price: double.parse(formData?["price"]),
        description: formData?["description"],
        imageUrl: formData?["imageUrl"]);

    print(newProduct);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        actions: [
          IconButton(onPressed: _saveForm, icon: const Icon(Icons.save))
        ],
      ),
      // to-do
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FormBuilder(
          key: _formkey,
          initialValue: initialValues,
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FormBuilderTextField(
                name: "title",
                decoration: const InputDecoration(
                  labelText: "Title",
                ),
                textInputAction: TextInputAction.next,
                onSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (newValue) {
                  initialValues["title"] = newValue!;
                },
              ),
              FormBuilderTextField(
                name: "price",
                decoration: const InputDecoration(labelText: "price"),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (newValue) {
                  initialValues["price"] = newValue!;
                },
              ),
              FormBuilderTextField(
                name: "description",
                decoration: const InputDecoration(
                  labelText: "Description",
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                onSaved: (newValue) {
                  initialValues["description"] = newValue!;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(top: 8, right: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.green),
                    ),
                    child: _imageUrlConroller.text.isEmpty
                        ? const Text(
                            'Enter a URL',
                            textAlign: TextAlign.center,
                          )
                        : SizedBox.expand(
                            child: FittedBox(
                                child: Image.network(
                              _imageUrlConroller.text,
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            )),
                          ),
                  ),
                  Expanded(
                    child: FormBuilderTextField(
                      name: "imageUrl",
                      decoration: const InputDecoration(
                        labelText: "Image URL",
                      ),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlConroller,
                      focusNode: _imageUrlFocusNode,
                      onSaved: (newValue) {
                        initialValues["imageUrl"] = newValue!;
                      },
                      onSubmitted: (_) {
                        _saveForm();
                      },
                    ),
                  ),
                ],
              )
            ],
          )),
        ),
      ),
    );
  }
}
