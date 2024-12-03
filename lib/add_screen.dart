import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:market_list/provider/counter_controller.dart';
import 'package:market_list/source/local/database_helper.dart';
import 'package:market_list/vibrator/vibrator.dart';
import 'dart:convert';

import 'package:market_list/widgets/conn_state.dart';
import 'package:provider/provider.dart';

import 'config/constants.dart';
import 'config/routes.dart';
import 'model/dados_model.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  ConnectivityStatus _connectivityStatus = ConnectivityStatus.checking;

  // Controllers para os campos de entrada
  final _dateController = TextEditingController();
  final TextEditingController tipoController = TextEditingController();
  final TextEditingController subtipoController = TextEditingController();
  final TextEditingController valorController = TextEditingController();
  final TextEditingController quantController = TextEditingController();
  late int? quantidade;
  late String? valorFinal;
  late double? ValorDolar;
  late double? high;
  late double? low;

  final dropValue = ValueNotifier("");
  // Lista do Spinner do tipo, entrada ou saída
  // Crédito se a operação for de entrada de dinheiro na conta
  // Débito se for saída de dinheiro da conta
  final List<String> _tipo = [
    'Limpeza', 'Higiêne', 'Alimentos', 'Bebidas'
  ];

  List<String> _currentSecondOptions = []; // Lista atual do segundo spinner

  String? _selectedFirstSpinner; // Valor selecionado no primeiro spinner
  String? _selectedSecondSpinner; // Valor selecionado no segundo spinner
  String? _selectedTipo;
  String? _selectedSubtipo;
  DatabaseHelper dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    Map<String, double?> args = ModalRoute.of(context)!.settings.arguments as Map<String, double?>;

    high = args['high'];
    low = args['low'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: azulFraco,
        title: const Text("Market List"),
        actions: [
          TextButton(
              onPressed: () {},
              child: ConnStatus(
                callback: (status) {
                  setState(() {
                    _connectivityStatus = status;
                  });
                },
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 15),
            SizedBox(
              width: 250,
              child: DropdownButtonFormField2<String>(
                isExpanded: true,
                decoration: InputDecoration(
                  // Add Horizontal padding using menuItemStyleData.padding so it matches
                  // the menu padding when button's width is not specified.
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  // Add more decoration..
                ),
                hint: const Text(
                  'Selecione o tipo do produto',
                  style: TextStyle(fontSize: 14),
                ),
                items: _tipo
                    .map((item) =>
                    DropdownMenuItem<String>(
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
                    return 'Por favor, selecione o tipo';
                  }
                  return null;
                },
                onChanged: (value) {
                  tipoController.text = value.toString();
                  setState(() {
                    _selectedFirstSpinner = value;
                    _currentSecondOptions = secondSpinnerOptions[value!]!;
                    _selectedSecondSpinner =
                    null; // Reseta o segundo spinner
                  });
                },
                onSaved: (value) {
                  _selectedTipo = value.toString();
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.only(right: 8),
                ),
                iconStyleData: const IconStyleData(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.green,
                  ),
                  iconSize: 26,
                ),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: 250,
              child: DropdownButtonFormField2<String>(
                isExpanded: true,
                decoration: InputDecoration(
                  // Add Horizontal padding using menuItemStyleData.padding so it matches
                  // the menu padding when button's width is not specified.
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  // Add more decoration..
                ),
                value: _currentSecondOptions.contains(
                    _selectedSecondSpinner)
                    ? _selectedSecondSpinner
                    : null,
                hint: const Text(
                  'Selecione a despesa ou receita',
                  style: TextStyle(fontSize: 14),
                ),
                items: _currentSecondOptions
                    .map((item) =>
                    DropdownMenuItem<String>(
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
                    return 'Por favor, selecione algum item';
                  }
                  return null;
                },
                onChanged: (value) {
                  // Adicionar posterioridades do app
                  subtipoController.text = value.toString();
                  setState(() {
                    _selectedSecondSpinner = value;
                  });
                },
                onSaved: (value) {
                  _selectedSubtipo = value.toString();
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.only(right: 8),
                ),
                iconStyleData: const IconStyleData(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.green,
                  ),
                  iconSize: 26,
                ),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Visibility(
                visible: _selectedSecondSpinner == null,
                child: kits[2]
            ),
            //const SizedBox(height: 15),
            Visibility(
                visible: _selectedSecondSpinner != null,
                child: Center(
                  child: Column(
                    children: [
                      Row(
                          children: [
                            const SizedBox(width: 15),
                            IconButton(
                              onPressed: (){
                                Provider
                                    .of<CounterProviderController>(context, listen: false)
                                    .decrement();
                              },
                              icon: const Icon(Icons.remove),
                              color: Colors.red,
                            ),
                            const SizedBox(width: 15),
                            Text(
                              '$_selectedSecondSpinner: ',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            Consumer<CounterProviderController>(
                              builder: (context, value, child) {
                                quantidade = value.counter;
                                return Text(
                                  '${quantidade}',
                                  style: Theme.of(context).textTheme.headlineMedium,
                                );
                              },
                            ),
                            const SizedBox(width: 15),
                            IconButton(
                              onPressed: (){
                                Provider
                                    .of<CounterProviderController>(context, listen: false)
                                    .increment();
                              },
                              icon: const Icon(Icons.add),
                              color: Colors.green,
                            ),
                          ]
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: 200,
                        child: TextFormField(
                          controller: valorController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green)
                            ),
                            prefixIcon: const Icon(Icons.money),
                            prefixIconColor: Colors.green,
                            hintText: "Insira o valor aqui!",
                            labelText: "Valor Unitário",
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [CurrencyTextInputFormatter.currency(
                            locale: 'pt_Br',
                            symbol: 'R\$',
                          )
                          ],
                        ),
                      ),
                    ]
                  ),
                )
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: azulFraco,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(
                Icons.add,
                size: iconeMedio,
              ),
              onPressed: () {
                //Vibrator.vibrate();
                //_mostrarDialogo(context);
                _inserirItem();
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.cleaning_services,
                size: iconeMedio,
              ),
              onPressed: _excluirLista,
            ),
            IconButton(
              icon: const Icon(
                Icons.calculate,
                size: iconeMedio,
              ),
              onPressed: _calcular,
            ),
            IconButton(
              icon: const Icon(
                Icons.list,
                size: iconeMedio,
              ),
              onPressed: () {
                Navigator.pushNamed(context, listRoute);
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> _excluirLista() async {
    await DatabaseHelper().deleteAllDados();
    Provider
        .of<CounterProviderController>(context, listen: false)
        .zerar();
    _limparCampos();
  }

  Future<void> _inserirItem() async {

    if ((_selectedFirstSpinner == null) ||
        (_selectedSecondSpinner == null) ||
        valorController.text.isEmpty ||
        (quantidade! <= 0 )
    ) {
      Vibrator.vibrate();
      print("SecondSpinner: $_selectedSecondSpinner");
      print("FirstSpinner: $_selectedFirstSpinner");
      print("Valor: ${valorController.text}");
      print("Quantidade: $quantidade");
      _mostrarDialogo(
          context,
          "Erro ao inserir item na lista",
          "Por favor, preencher os campos corretamente!"
      );
    } else {
      String valorSemSimbolo = valorController.text.replaceAll('R\$', '').trim();

      final item = Dado(
        descricao: _selectedSecondSpinner!,
        valor: valorSemSimbolo,
        quantidade: quantidade.toString(),
      );

      try {
        // Inserir o item no banco de dados
        final id = await DatabaseHelper().insertDado(item);
        print('Item inserido com sucesso. ID: $id');
      } catch (e) {
        print('Erro ao inserir item: $e');
      }

      _limparCampos();
    }
  }
  // Função que será chamada ao pressionar o botão de Calcular
  Future<void> _calcular() async {
    // Recupera os dados do banco
    List<Dado> dados = await dbHelper.getAllDados();

    // Variáveis para armazenar as somas
    double somaValores = 0.0;

    // Itera sobre os dados e faz a soma dos valores e das quantidades
    for (var dado in dados) {
      somaValores +=
          (double.tryParse(dado.valor.replaceAll(',', '.')) ?? 0.0)
              * (int.tryParse(dado.quantidade) ?? 0);
    }
    // Realiza a multiplicação da soma dos valores pela soma das quantidades

    // Exibe o resultado (pode ser um alerta ou outra lógica que você deseja)
    _mostrarDialogo(
        context,
        "Valor total da lista",
        "Resultado: R\$ ${somaValores.toStringAsFixed(2)}\nResultado: \$ ${(somaValores/high!).toStringAsFixed(2)}"
    );
  }

  // Função para limpar campos
  void _limparCampos() {
    setState(() {
      tipoController.clear();
      subtipoController.clear();
      valorController.clear();
      _selectedFirstSpinner = null;
      _selectedSecondSpinner = null; // Reseta o segundo spinner
      _selectedTipo = null;
      _selectedSubtipo = null;
    });
    quantidade = 0;
    Provider.of<CounterProviderController>(context, listen: false).zerar();
  }
}
void _mostrarDialogo(BuildContext context, String titulo, String mensagem) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(titulo),
        content: Text(mensagem),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // Fecha o diálogo
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}