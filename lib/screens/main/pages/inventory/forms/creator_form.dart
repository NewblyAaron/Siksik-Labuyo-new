import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:siksik_labuyo/models/creator.dart';
import 'package:siksik_labuyo/utils/validators.dart';
import 'package:siksik_labuyo/widgets/form_text_field.dart';

class CreatorForm extends StatefulWidget {
  const CreatorForm({super.key, this.creator});

  final Creator? creator;

  @override
  State<CreatorForm> createState() => _CreatorFormState();
}

class _CreatorFormState extends State<CreatorForm> {
  late final Isar _db;
  late final TextEditingController _nameCon;

  final formKey = GlobalKey<FormState>();

  void submitForm() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final creator = Creator(name: _nameCon.text);

    await _db.writeTxn(() async {
      await _db.creators.put(creator);
    });

    if (mounted) Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();

    _db = Isar.getInstance()!;
    _nameCon = TextEditingController(text: widget.creator?.name);
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
