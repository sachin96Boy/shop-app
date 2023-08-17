import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product_provider.dart';
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

  var initialValues = {
    "title": "",
    "price": "",
    "description": "",
    "imageUrl": ""
  };

  var _isInit = true;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)?.settings.arguments as String;
      if (productId != null.toString()) {
        final editProduct =
            Provider.of<ProductsProvider>(context, listen: false)
                .findById(productId);
        initialValues = {
          "title": editProduct.title,
          "price": editProduct.price.toString(),
          "description": editProduct.description,
          "imageUrl": ''
        };
        _imageUrlConroller.text = editProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlConroller.text.startsWith('http') &&
              !_imageUrlConroller.text.startsWith('https')) ||
          (!_imageUrlConroller.text.endsWith('.png') &&
              !_imageUrlConroller.text.endsWith('.jpg') &&
              !_imageUrlConroller.text.endsWith('.jpeg'))) {
        return;
      }
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
    final isValid = _formkey.currentState?.validate();

    if (!isValid!) {
      return;
    }

    _formkey.currentState?.save();
    final formData = _formkey.currentState?.value;

    final prodId = ModalRoute.of(context)!.settings.arguments as String;
    final edProduct =
        Provider.of<ProductsProvider>(context, listen: false).findById(prodId);
    if (prodId != null.toString()) {
      // not null means we have to edit the product
      // make sure to not chnge fav state and id when updateing
      final newProduct = Product(
          id: edProduct.id,
          title: formData?["title"],
          price: double.parse(formData?["price"]),
          description: formData?["description"],
          imageUrl: formData?["imageUrl"],
          isFavourite: edProduct.isFavourite);
      Provider.of<ProductsProvider>(context, listen: false)
          .updateProduct(prodId, newProduct);
    } else {
      // create a new product
      final newProduct = Product(
          id: DateTime.now().toString(),
          title: formData?["title"],
          price: double.parse(formData?["price"]),
          description: formData?["description"],
          imageUrl: formData?["imageUrl"]);
      Provider.of<ProductsProvider>(context, listen: false)
          .addproduct(newProduct);
    }
    // print(newProduct);
    Navigator.of(context).pop();
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
                initialValue: initialValues['title'],
                decoration: const InputDecoration(
                    labelText: "Title",
                    errorStyle: TextStyle(color: Colors.red)),
                textInputAction: TextInputAction.next,
                onSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (newValue) {
                  initialValues["title"] = newValue!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Pleasr provide a value';
                  }
                  return null;
                },
              ),
              FormBuilderTextField(
                name: "price",
                initialValue: initialValues['price'],
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter a valid price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'please enter a valid price';
                  }
                  if (double.parse(value) <= 0) {
                    return "please enter a valid value";
                  }
                  return null;
                },
              ),
              FormBuilderTextField(
                name: "description",
                initialValue: initialValues['description'],
                decoration: const InputDecoration(
                  labelText: "Description",
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                onSaved: (newValue) {
                  initialValues["description"] = newValue!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter a description';
                  }
                  if (value.length < 10) {
                    return 'should be at least 10 characters long';
                  }
                  return null;
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
                      // initialValue: initialValues['imageUrl'],
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter a valid URL';
                        }
                        if (!value.startsWith('http') &&
                            value.startsWith('https')) {
                          return 'please enter a valid URL';
                        }
                        return null;
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
