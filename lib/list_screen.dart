import 'package:flutter/material.dart';
import 'package:market_list/config/constants.dart';
import 'package:market_list/source/local/database_helper.dart';
import 'package:provider/provider.dart';
import 'model/coin_data.dart';
import 'model/coin_data.dart';
import 'model/dados_model.dart';
import 'model/dados_model.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListaItensScreenState();
}

class _ListaItensScreenState extends State<ListScreen> {
  List<Dado> _itens = [];

  @override
  void initState() {
    super.initState();
    _carregarItens();
  }

  Future<void> _carregarItens() async {
    final itens = await DatabaseHelper().getAllDados();
    setState(() {
      _itens = itens;
    });
  }

  Future<void> _deletarItem(int id) async {
    await DatabaseHelper().deleteDado(id);
    _carregarItens();
  }

  Future<void> _editarItem(Dado dado) async {
    final descricaoController = TextEditingController(text: dado.descricao);
    final quantidadeController = TextEditingController(text: dado.quantidade.toString());
    final valorController = TextEditingController(text: dado.valor);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: descricaoController,
                decoration: const InputDecoration(labelText: 'Descrição'),
              ),
              TextField(
                controller: valorController,
                decoration: const InputDecoration(labelText: 'Valor'),
              ),
              TextField(
                controller: quantidadeController,
                decoration: const InputDecoration(labelText: 'Quantidade'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Salvar'),
              onPressed: () {
                final novaDescricao = descricaoController.text;
                final novoValor = quantidadeController.text;
                final novaQuantidade = int.tryParse(quantidadeController.text) ?? dado.quantidade;

                final itemAtualizado = Dado(
                  id: dado.id,
                  descricao: novaDescricao,
                  valor: novoValor,
                  quantidade: novaQuantidade.toString(),
                );
                DatabaseHelper().updateDado(itemAtualizado);
                Navigator.of(context).pop();
                _carregarItens();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: azulFraco,
        title: const Text('Lista de Itens'),
      ),
      body: ListView.builder(
        itemCount: _itens.length,
        itemBuilder: (context, index) {
          final dado = _itens[index];
          return ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 120,
                  child: Text(dado.descricao)
                ),
                SizedBox(
                  child: Text('R\$: ${dado.valor}')
                ),
                SizedBox(
                    child: Text(dado.quantidade)
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _editarItem(dado),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deletarItem(dado.id!),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}