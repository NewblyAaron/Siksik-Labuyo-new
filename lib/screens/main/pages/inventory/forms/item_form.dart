import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import 'package:siksik_labuyo/models/category.dart';
import 'package:siksik_labuyo/models/creator.dart';
import 'package:siksik_labuyo/models/item.dart';
import 'package:siksik_labuyo/utils/validators.dart';
import 'package:siksik_labuyo/widgets/form_text_field.dart';

class ItemForm extends StatefulWidget {
  const ItemForm({super.key, this.item});

  final Item? item;

  @override
  State<ItemForm> createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  late final Isar _db;
  late final List<Category> _categories;
  late final List<Creator> _creators;

  late final TextEditingController _nameCon, _priceCon, _stockCon;
  Category? _selectedCategory;
  Creator? _selectedCreator;

  final formKey = GlobalKey<FormState>();

  void submitForm() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final item = Item(
        name: _nameCon.text,
        price: double.parse(_priceCon.text),
        stock: int.parse(_stockCon.text),
        categoryId: _selectedCategory!.id,
        creatorId: _selectedCreator!.id);

    await _db.writeTxn(() async {
      await _db.items.put(item);
    });

    if (mounted) Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();

    _db = Isar.getInstance()!;
    _nameCon = TextEditingController(text: widget.item?.name);
    _priceCon =
        TextEditingController(text: widget.item?.price.toStringAsFixed(2));
    _stockCon = TextEditingController(text: widget.item?.stock.toString());
    _categories = _db.categorys.where().findAllSync();
    _creators = _db.creators.where().findAllSync();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FormTextField(
            controller: _nameCon,
            validator: Validators.hasValue,
            label: "Name",
            icon: Icons.title,
            textInputAction: TextInputAction.next,
          ),
          DropdownSearch<Creator>(
            items: _creators,
            selectedItem: _selectedCreator,
            validator: (e) =>
                e == null ? "This value cannot be left blank!" : null,
            onChanged: (value) => setState(() => _selectedCreator = value),
            compareFn: (item1, item2) => item1.id == item2.id,
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                icon: Icon(Icons.person),
                labelText: "Creator",
              ),
            ),
            popupProps: const PopupProps.dialog(
                showSearchBox: true,
                searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(
                      icon: Icon(Icons.search), labelText: "Name"),
                )),
          ),
          DropdownSearch<Category>(
            items: _categories,
            selectedItem: _selectedCategory,
            validator: (e) =>
                e == null ? "This value cannot be left blank!" : null,
            onChanged: (value) => setState(() => _selectedCategory = value),
            compareFn: (item1, item2) => item1.id == item2.id,
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                icon: Icon(Icons.category),
                labelText: "Creator",
              ),
            ),
            popupProps: const PopupProps.dialog(
                showSearchBox: true,
                searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(
                      icon: Icon(Icons.search), labelText: "Name"),
                )),
          ),
          FormTextField(
            controller: _stockCon,
            validator: Validators.hasValue,
            label: "Stock",
            icon: Icons.numbers,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: const TextInputType.numberWithOptions(),
            textInputAction: TextInputAction.next,
          ),
          FormTextField(
            controller: _priceCon,
            validator: Validators.hasValue,
            label: "Price",
            icon: Icons.money,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*'))
            ],
            keyboardType: const TextInputType.numberWithOptions(),
            textInputAction: TextInputAction.done,
            onEditingComplete: () {
              _priceCon.text = num.parse(_priceCon.text).toStringAsFixed(2);

              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      onPressed: submitForm, child: const Text("Submit"))),
            ],
          )
        ],
      ),
    );
  }
}
