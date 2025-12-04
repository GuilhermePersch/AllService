import 'dart:developer';
import 'dart:math';
import 'package:hive/hive.dart';
import 'package:testando_conhecimentos/src/models/service_hive_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:testando_conhecimentos/src/utils/parsedate_utils.dart';

class AdditionServiceView extends StatefulWidget {
  final Service? serviceToEdit;

  AdditionServiceView({super.key, this.serviceToEdit});

  @override
  State<AdditionServiceView> createState() => _AdditionServiceViewState();
}

class _AdditionServiceViewState extends State<AdditionServiceView> {
  final nameController = TextEditingController();
  final descricaoController = TextEditingController();
  final dataController = TextEditingController();
  final nameClientController = TextEditingController();
  final enderecoClientController = TextEditingController();
  final valorClientController = TextEditingController();

  @override
  void initState() {
    if (widget.serviceToEdit != null) {
      final s = widget.serviceToEdit!;
      nameController.text = s.name;
      descricaoController.text = s.descricao;
      dataController.text =
          "${s.data.day}/${s.data.month}/${s.data.year}";
      nameClientController.text = s.nome_cliente;
      enderecoClientController.text = s.endereco;
      valorClientController.text = s.valor.toString();
    }
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    descricaoController.dispose();
    dataController.dispose();
    nameClientController.dispose();
    enderecoClientController.dispose();
    valorClientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    TextLabel(label: 'Insira o nome do seu serviço!'),
                    SizedBox(height: 15),
                    _TextField(
                      label: 'Nome do serviço',
                      controller: nameController,
                    ),
                    SizedBox(height: 15),
                    TextLabel(label: 'Insira a descrição do serviço!'),
                    SizedBox(height: 15),
                    _TextField(
                      label: 'Insira a descrição do que foi feito!',
                      controller: descricaoController,
                    ),
                    SizedBox(height: 15),    
                    TextLabel(label: 'Insira a data de realização!'),
                    SizedBox(height: 15),
                    DataPickerState(
                      controller: dataController,
                      ),
                    SizedBox(height: 10),
                    CheckBoxInfo(
                      nameClientController: nameClientController, enderecoClientController: enderecoClientController, valorClientController: valorClientController
                    ),
                    SizedBox(height: 50),
                    SaveButton(
                      serviceToEdit: widget.serviceToEdit,
                      nameController: nameController, descricaoController: descricaoController, dataController: dataController, nameClientController: nameClientController, enderecoClientController: enderecoClientController, valorClientController: valorClientController,
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}


// APP BAR CASO EU QUEIRA MELHORAR ALGO NO FUTURO!
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: const Text(
        'Adicione o serviço aqui!',
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}


// AQUI É SÓ O TEXTO: eu faço separado pra tirar um pouco da estrutura principal
class TextLabel extends StatelessWidget {
  final String label;

  const TextLabel({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      // alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}

// AQUI EU FAÇO O TEXTFIELD: ainda falta os controllers e afins, fazer depois.
class _TextField extends StatelessWidget {
  
  final String label;
  final TextEditingController controller;

  _TextField({super.key, required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Align(
      // alignment: Alignment.topLeft,
      child: SizedBox(
        width: 370,
        height: 50,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: label,
          ),
        ),
      ),
    );
  }
}

class DataPickerState extends StatefulWidget {
  final TextEditingController controller;

  const DataPickerState({
    super.key, 
    required this.controller
    });

  @override
  State<DataPickerState> createState() => _DataPickerStateState();
}

class _DataPickerStateState extends State<DataPickerState> {

  Future<void> _SelectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(),
      firstDate: DateTime(2000), 
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        widget.controller.text = 
          '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 370,
      height: 50,
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: 'Insira a data de realização',
          suffixIcon: IconButton(
            onPressed: _SelectDate,
            icon: Icon(Icons.calendar_today)),
        ),
        readOnly: true,
        onTap: _SelectDate,
      ),
    );
  }
}

class CheckBoxInfo extends StatefulWidget {
  final TextEditingController nameClientController;
  final TextEditingController enderecoClientController;
  final TextEditingController valorClientController;

  
  
   CheckBoxInfo({
    super.key, 
    required this.nameClientController, 
    required this.enderecoClientController, 
    required this.valorClientController
    });

  @override
  State<CheckBoxInfo> createState() => _CheckBoxInfoState();
}

class _CheckBoxInfoState extends State<CheckBoxInfo> {
  bool _isChecked = false;



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Checkbox(
              value: _isChecked, 
              onChanged: (bool? value) {
                setState(() {
                  _isChecked = value!;
                });
              }      
            ),
            Expanded(
              child: Text('Clique aqui para adicionar informações do ciente!')
            ),
          ],
        ),
        if (_isChecked) ...[
          SizedBox(height: 15),
          _TextField(
            label: 'Insira o nome do cliente',
            controller: widget.nameClientController,
          ),
          SizedBox(height: 15),
          _TextField(
            label: 'Insira a rua do cliente!',
            controller: widget.enderecoClientController,  
          ),
          SizedBox(height: 15),
          _TextField(
            label: 'Insira o valor do serviço!',
            controller: widget.valorClientController,  
          ),
        ],
      ],
    );
  }
}

class SaveButton extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController descricaoController;
  final TextEditingController dataController;
  final TextEditingController nameClientController;
  final TextEditingController enderecoClientController;
  final TextEditingController valorClientController;
  final Service? serviceToEdit;


  const SaveButton({
    super.key, 
    required this.nameController, 
    required this.descricaoController, 
    required this.dataController, 
    required this.nameClientController, 
    required this.enderecoClientController, 
    required this.valorClientController, 
    this.serviceToEdit
    });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 65, 201, 19)
        ),
        onPressed: () {
          final box = Hive.box<Service>('services');

          
          if (serviceToEdit == null) {
              final service = Service(
              nameController.text,
              descricaoController.text,
              parseDate(dataController.text),
              nameClientController.text,
              enderecoClientController.text,
              double.tryParse(valorClientController.text) ?? 0.0,
            );

            nameController.clear();
            descricaoController.clear();
            dataController.clear();
            nameClientController.clear();
            enderecoClientController.clear();
            valorClientController.clear();

            box.add(service);
          } else {
              final s = serviceToEdit!;
              s.name = nameController.text;
              s.descricao = descricaoController.text;
              s.data = parseDate(dataController.text);
              s.nome_cliente = nameClientController.text;
              s.endereco = enderecoClientController.text;
              s.valor = double.tryParse(valorClientController.text) ?? 0.0;

              s.save();
          }

            Navigator.pop(context);
        }, 
        child: Text('Salvar Serviço!', style: TextStyle(color: Colors.black),)
      ),
    );
  }
}

