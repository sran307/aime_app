import 'package:dailyme/constants/constants.dart';
import 'package:dailyme/constants/dates/purchasedDate.dart';
import 'package:dailyme/constants/dates/validity.dart';
import 'package:dailyme/services/TokenHandler.dart';
import 'package:dailyme/services/urls.dart';
import 'package:flutter/material.dart';

class AssetForm extends StatefulWidget {
  const AssetForm({super.key});

  @override
  State<AssetForm> createState() => _AssetFormState();
}

class _AssetFormState extends State<AssetForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _validityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Enter The Item',
                  style: formHeading,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: TextFormField(
                  controller: _itemController,
                  decoration: const InputDecoration(
                      labelText: 'Item Name', hintText: 'Enter the item..'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter an item';
                    }
                    return null;
                  }),
            ),
            Padding(
                padding: const EdgeInsets.all(3.0),
                child: TextFormField(
                    controller: _amountController,
                    decoration: const InputDecoration(
                        labelText: 'Item amount', hintText: 'Enter the amount'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter the amount';
                      }
                      return null;
                    })),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: purchasedField(_dateController),
            ),
            Padding(
                padding: const EdgeInsets.all(3.0),
                child: ValidityField(_validityController)
              ),
              Padding(padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: (){
                if(_formKey.currentState!.validate()){
                  String? purchasedDate = _dateController.text;
                  String? validity = _validityController.text;
                  Map<String, dynamic> data ={
                    "name": _itemController.text,
                    "purchased": purchasedDate,
                    "validity": validity,
                    "amount": _amountController.text
                  };
                  TokenHandler tokenHandler = TokenHandler(context);
                  tokenHandler.submitCommonForm(data, assetSave);
                  _itemController.clear();
                  _amountController.clear();

                }

              }, child: const Text('Add')),)
          ],
        ),
      ),
    );
  }
}
