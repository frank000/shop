import 'package:flutter/material.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _urlFocus = FocusNode();
  final _descriptionFocus = FocusNode();

  final _imgUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _urlFocus.addListener(updateUrl);
  }

  @override
  void dispose() {
    _priceFocus.dispose();
    _urlFocus.dispose();
    _urlFocus.removeListener(updateUrl);
    _descriptionFocus.dispose();
  }

  void updateUrl() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulário de produto"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Nome"),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) =>
                    FocusScope.of(context).requestFocus(_priceFocus),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Numero"),
                textInputAction: TextInputAction.next,
                focusNode: _priceFocus,
                onFieldSubmitted: (value) =>
                    FocusScope.of(context).requestFocus(_descriptionFocus),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Descrição"),
                textInputAction: TextInputAction.next,
                focusNode: _descriptionFocus,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Url da Imagem"),
                      focusNode: _urlFocus,
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imgUrlController,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                      left: 10,
                    ),
                    height: 100,
                    width: 100,
                    child: _imgUrlController.text.isEmpty
                        ? Text("Informe a Url")
                        : FittedBox(
                            child: Image.network(_imgUrlController.text),
                            fit: BoxFit.cover,
                          ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1)),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
