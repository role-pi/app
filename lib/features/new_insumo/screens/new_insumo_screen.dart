import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/evento_detail/providers/evento_detail_provider.dart';
import 'package:role/features/evento_list/providers/evento_list_provider.dart';
import 'package:role/features/new_insumo/providers/new_insumo_provider.dart';
import 'package:role/models/evento.dart';
import 'package:role/shared/widgets/custom_navigation_bar.dart';
import 'package:role/shared/widgets/elastic_button.dart';
import 'package:role/shared/widgets/form/form_item_text_field.dart';

class NewInsumoScreen extends StatelessWidget {
  NewInsumoScreen(EventoDetailProvider eventoDetailProvider) {
    this.newInsumoProvider = NewInsumoProvider(eventoDetailProvider);
  }
  late NewInsumoProvider newInsumoProvider;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: newInsumoProvider,
      child: CupertinoPageScaffold(
        child: Column(
          children: [
            Consumer<NewInsumoProvider>(builder: (context, provider, child) {
              return CustomNavigationBar(
                trailingText: "adicionar",
                onPressedLeading: () {
                  Navigator.of(context).pop();
                },
                onPressedTrailing: provider.changed
                    ? () {
                        provider.addInsumo(context);
                      }
                    : null,
                accentColor: provider.evento.color1,
              );
            }),
            Form(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: FormItemTextField(
                            controller: newInsumoProvider.nameController,
                            title: "nome",
                          ),
                        ),
                        SizedBox(width: 12),
                        ElasticButton(
                          onTap: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: 200, // Ajuste a altura conforme necessário
                                  child: CupertinoPicker(
                                    itemExtent: 32,
                                    onSelectedItemChanged: (int index) {
                                      // Faça algo com o valor selecionado
                                    },
                                    children: <Widget>[
                                      // Adicione os itens do picker aqui
                                      Text('🎟️'),
                                      Text('🍺'),
                                      Text('🎁'),
                                      Text('🛒'),
                                      Text('🛍️'),
                                      Text('🚕'),
                                      Text('🥩'),
                                      // ...
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 221, 221, 224)
                                  .withOpacity(0.8),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(
                              CupertinoIcons.smiley,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    FormItemTextField(
                      controller: newInsumoProvider.descricaoController,
                      title: "descrição",
                    ),
                    SizedBox(height: 12),
                    FormItemTextField(
                      controller: newInsumoProvider.valorController,
                      title: "valor",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
