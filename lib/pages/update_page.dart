import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/product.dart';
import '../pages/home_page.dart';
import '../sqflite/database.dart';

class UpdatePage extends StatefulWidget {
  final Product product;

  const UpdatePage({Key? key, required this.product}) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final _formKey = GlobalKey<FormState>();

  String? selectedCategory;
  String? selectedUnit;

  final TextEditingController _productName = TextEditingController();
  final TextEditingController _quantity = TextEditingController();

  final categories = getCategories();
  final units = getUnits();

  @override
  void initState() {
    super.initState();
    _productName.text = widget.product.productName;
    _quantity.text = widget.product.quantity.toString();
    selectedCategory = widget.product.category;
    selectedUnit = widget.product.unit;
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
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            child: IconButton(
              icon: const Icon(Icons.delete),
              color: kButtonColor1,
              iconSize: 31,
              onPressed: () {
                FridgeyDb.instance.deleteProduct(widget.product.id);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HomePage()),
                );
              },
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Edit Product',
                  style: TextStyle(
                    color: kTextColor2,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                getProductTextFormField(
                  'Product',
                  _productName,
                  TextInputType.text,
                  'Enter Your Product.',
                ),
                getCategoryDropdownFormField(
                  'Category',
                  'Select Your Category',
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    getQuantityTextFormField(
                      'Quantity',
                      _quantity,
                      TextInputType.number,
                      'Quantity',
                    ),
                    const SizedBox(width: 30),
                    getUnitDropdownFormField(
                      'Unit',
                      'Unit',
                    ),
                  ],
                ),
                const SizedBox(height: 30),
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
                        editProduct();
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
          return 'Please enter some text';
        }
        return null;
      },
    );
  }

  Widget getProductTextFormField(text, controller, textInputType, hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        getText(text),
        const SizedBox(height: 3),
        getTextFormField(controller, textInputType, hintText),
      ],
    );
  }

  Widget getCategoryDropdownFormField(text, hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
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
          value: widget.product.category,
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
              return 'Please select category.';
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
      children: [
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
      children: [
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
            value: widget.product.unit,
            items: units
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
                return 'Please select unit.';
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

  Future editProduct() async {
    final product = Product(
      id: widget.product.id,
      productName: _productName.text,
      category: selectedCategory.toString(),
      quantity: int.parse(_quantity.text),
      unit: selectedUnit.toString(),
    );
    await FridgeyDb.instance.updateProduct(product);
  }
}
