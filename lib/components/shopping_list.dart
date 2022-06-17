import 'package:flutter/material.dart';
//
// import '../constants.dart';
//
// class ShoppingList extends StatefulWidget {
//   const ShoppingList({Key? key}) : super(key: key);
//
//   @override
//   State<ShoppingList> createState() => _ShoppingListState();
// }
//
// class _ShoppingListState extends State<ShoppingList> {
//   List<CheckBoxListTileModel> checkBoxListTileModel =
//       CheckBoxListTileModel.getList();
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: checkBoxListTileModel.length,
//       itemBuilder: (BuildContext context, int index) {
//         return Card(
//           child: Container(
//             padding: const EdgeInsets.all(3.0),
//             child: CheckboxListTile(
//               controlAffinity: ListTileControlAffinity.leading,
//               title: Text(
//                 checkBoxListTileModel[index].title,
//                 style: const TextStyle(fontSize: 16, color: kTextColor3),
//               ),
//               activeColor: kButtonColor1,
//               value: checkBoxListTileModel[index].isChecked,
//               // secondary: SizedBox(
//               //   height: 50,
//               //   width: 50,
//               //   child: Image.asset(
//               //     checkBoxListTileModel[index].img,
//               //     fit: BoxFit.cover,
//               //   ),
//               // ),
//               onChanged: (bool? value) {
//                 setState(() {
//                   checkBoxListTileModel[index].isChecked = value!;
//                 });
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
// class CheckBoxListTileModel {
//   int id;
//   String title;
//   bool isChecked;
//
//   CheckBoxListTileModel(
//       {required this.id, required this.title, required this.isChecked});
//
//   static List<CheckBoxListTileModel> getList() {
//     return <CheckBoxListTileModel>[
//       CheckBoxListTileModel(id: 1, title: "Apple", isChecked: false),
//       CheckBoxListTileModel(id: 2, title: "Banana", isChecked: false),
//       CheckBoxListTileModel(id: 3, title: "Corn", isChecked: false),
//       CheckBoxListTileModel(id: 4, title: "Donut", isChecked: false),
//       CheckBoxListTileModel(id: 5, title: "Egg", isChecked: false),
//     ];
//   }
// }

class ShoppingList extends StatefulWidget {
  const ShoppingList({Key? key}) : super(key: key);

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
