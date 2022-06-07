import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/product.dart';
import '../pages/home_page.dart';
import '../sqflite/database.dart';

class DataEntry extends StatefulWidget {
  final int kind;
  final String title;
  final Product? product;

  const DataEntry({
    Key? key,
    required this.kind,
    required this.title,
    this.product,
  }) : super(key: key);

  @override
  State<DataEntry> createState() => _DataEntryState();
}

class _DataEntryState extends State<DataEntry> {
  final _formKey = GlobalKey<FormState>();

  final categories = getCategories();
  final units = getUnits();

  final TextEditingController _productName = TextEditingController();
  final TextEditingController _quantity = TextEditingController();

  String? selectedCategory;
  String? selectedUnit;

  @override
  void initState() {
    super.initState();
    if (widget.kind == 1) {
      _productName.text = widget.product!.productName;
      _quantity.text = widget.product!.quantity.toString();
      selectedCategory = widget.product!.category;
      selectedUnit = widget.product!.unit;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 75,
        leading: Container(
          margin: const EdgeInsets.only(left: 25),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: kButtonColor1,
            iconSize: 28,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
            ),
          ),
        ),
        actions: widget.kind == 1
            ? <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 15),
                  child: IconButton(
                    icon: const Icon(Icons.delete),
                    color: kButtonColor1,
                    iconSize: 31,
                    onPressed: () {
                      FridgeyDb.instance.deleteProduct(widget.product?.id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const HomePage()),
                      );
                    },
                  ),
                ),
              ]
            : [],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: kTextColor2,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                getProductTextFormField(
                  'Product',
                  _productName,
                  TextInputType.text,
                  'Enter Your Product',
                ),
                getCategoryDropdownFormField(
                  'Category',
                  'Select Your Category',
                ),
                const SizedBox(height: kWidthHeight),
                Row(
                  children: <Widget>[
                    getQuantityTextFormField(
                      'Quantity',
                      _quantity,
                      TextInputType.number,
                      'Quantity',
                    ),
                    const SizedBox(width: kWidthHeight),
                    getUnitDropdownFormField(
                      'Unit',
                      'Unit',
                    ),
                  ],
                ),
                const SizedBox(height: kWidthHeight),
                Center(
                  child: ElevatedButton(
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: kButtonColor1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                      minimumSize: const Size(100, 40),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (widget.kind == 1) {
                          updateProduct();
                        } else {
                          addProduct();
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const HomePage()),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w900,
        color: kTextColor1,
      ),
    );
  }

  Widget getTextFormField(controller, textInputType, hintText) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return kRequiredText;
        }
        return null;
      },
    );
  }

  Widget getProductTextFormField(text, controller, textInputType, hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: kWidthHeight),
        getText(text),
        const SizedBox(height: 3),
        getTextFormField(controller, textInputType, hintText),
      ],
    );
  }

  Widget getCategoryDropdownFormField(text, hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: kWidthHeight),
        getText(text),
        const SizedBox(height: 3),
        DropdownButtonFormField2(
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.zero,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          isExpanded: true,
          hint: Text(
            hintText,
            style: const TextStyle(fontSize: 14),
          ),
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.black45,
          ),
          iconSize: 30,
          buttonHeight: 60,
          buttonPadding: const EdgeInsets.only(left: 20, right: 10),
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          value: widget.kind == 1 ? widget.product?.category : null,
          items: categories
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
              .toList(),
          validator: (value) {
            if (value == null) {
              return kRequiredText;
            }
            return null;
          },
          onChanged: (value) {
            setState(() {
              selectedCategory = value.toString();
            });
          },
        ),
      ],
    );
  }

  Widget getQuantityTextFormField(text, controller, textInputType, hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        getText(text),
        const SizedBox(height: 3),
        SizedBox(
          width: 150,
          child: getTextFormField(controller, textInputType, hintText),
        ),
      ],
    );
  }

  Widget getUnitDropdownFormField(text, hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        getText(text),
        const SizedBox(height: 3),
        SizedBox(
          width: 150,
          child: DropdownButtonFormField2(
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            isExpanded: true,
            hint: Text(
              hintText,
              style: const TextStyle(fontSize: 14),
            ),
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Colors.black45,
            ),
            iconSize: 30,
            buttonHeight: 60,
            buttonPadding: const EdgeInsets.only(left: 20, right: 10),
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            value: widget.kind == 1 ? widget.product?.unit : null,
            items: units
                .map(
                  (item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                )
                .toList(),
            validator: (value) {
              if (value == null) {
                return kRequiredText;
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                selectedUnit = value.toString();
              });
            },
          ),
        ),
      ],
    );
  }

  Future addProduct() async {
    final product = Product(
      productName: _productName.text,
      category: selectedCategory.toString(),
      quantity: int.parse(_quantity.text),
      unit: selectedUnit.toString(),
    );
    await FridgeyDb.instance.createProduct(product);
  }

  Future updateProduct() async {
    final product = Product(
      id: widget.product?.id,
      productName: _productName.text,
      category: selectedCategory.toString(),
      quantity: int.parse(_quantity.text),
      unit: selectedUnit.toString(),
    );
    await FridgeyDb.instance.updateProduct(product);
  }
}
