import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fridgey/components/main_template.dart';

import '../constants.dart';
import '../database/models.dart';
import '../database/sqflite.dart';

class DataEntry extends StatefulWidget {
  final int isUpdatePage;
  final String title;
  final Product? product;

  const DataEntry({
    Key? key,
    required this.isUpdatePage,
    required this.title,
    this.product,
  }) : super(key: key);

  @override
  State<DataEntry> createState() => _DataEntryState();
}

class _DataEntryState extends State<DataEntry> {
  static const space1 = 30.0;
  static const space2 = 3.0;
  static const requiredText = "This is required.";

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
    if (widget.isUpdatePage == 1) {
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
              MaterialPageRoute(builder: (_) => const MainTemplate()),
            ),
          ),
        ),
        actions: widget.isUpdatePage == 1
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
                        MaterialPageRoute(builder: (_) => const MainTemplate()),
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
                const SizedBox(height: space1),
                getText('Product'),
                const SizedBox(height: space2),
                getTextFormField(
                  _productName,
                  TextInputType.text,
                  'Enter Your Product',
                ),
                getCategoryDropdownFormField(
                  'Category',
                  'Select Your Category',
                  categories,
                ),
                const SizedBox(height: space1),
                Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        getText('Quantity'),
                        const SizedBox(height: space2),
                        SizedBox(
                          width: 150,
                          child: getTextFormField(
                            _quantity,
                            TextInputType.number,
                            'Quantity',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: space1),
                    getUnitDropdownFormField(
                      'Unit',
                      'Unit',
                      units,
                    ),
                  ],
                ),
                const SizedBox(height: space1),
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
                        if (widget.isUpdatePage == 1) {
                          updateProduct();
                        } else {
                          addProduct();
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const MainTemplate()),
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
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return requiredText;
        }
        return null;
      },
    );
  }

  Widget getCategoryDropdownFormField(text, hintText, items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: space1),
        getText(text),
        const SizedBox(height: space2),
        DropdownButtonFormField2(
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.zero,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
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
          dropdownDecoration:
              BoxDecoration(borderRadius: BorderRadius.circular(15)),
          value: widget.isUpdatePage == 1 ? widget.product?.category : null,
          items: items
              .map<DropdownMenuItem<String>>((item) => DropdownMenuItem<String>(
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
              return requiredText;
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

  Widget getUnitDropdownFormField(text, hintText, items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        getText(text),
        const SizedBox(height: space2),
        SizedBox(
          width: 150,
          child: DropdownButtonFormField2(
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
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
            dropdownDecoration:
                BoxDecoration(borderRadius: BorderRadius.circular(15)),
            value: widget.isUpdatePage == 1 ? widget.product?.unit : null,
            items: items
                .map<DropdownMenuItem<String>>(
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
                return requiredText;
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
