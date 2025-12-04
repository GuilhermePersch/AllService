import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:testando_conhecimentos/src/models/service_hive_model.dart';
import 'package:testando_conhecimentos/src/views/addition_service_view.dart';

class HomepageView extends StatelessWidget {
  HomepageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerInfo(),
      appBar: BarraInicial(),
      body: ListaDeServices(),
      floatingActionButton: AdicionarService(),
    );
  }
}

class DrawerInfo extends StatelessWidget {
  const DrawerInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 130,
            color: const Color.fromARGB(255, 133, 133, 133),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: const Color.fromARGB(255, 214, 214, 214),
                  child: Icon(
                    Icons.settings_applications,
                    size: 50,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Inicio'),
            subtitle: Text('Área Inicial!'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Adicionar Serviço'),
            subtitle: Text('Adicione um serviço!'),
            onTap: () {
              Navigator.pushNamed(context, 'addition/');
            },
          ),
        ],
      ),
    );
  }
}

class BarraInicial extends StatelessWidget implements PreferredSizeWidget {
  const BarraInicial({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<Service>('services');

    return ValueListenableBuilder(
      valueListenable: box.listenable(),
      builder: (context, _, __) {
        final services = box.values.toList();
        final valorTotal = services.fold(0.0, (sum, item) => sum + item.valor);

        return AppBar(
          backgroundColor: const Color.fromRGBO(255, 255, 255, 1),

          title: const Text(
            'Tela Inicial!',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Valor total: R\$ ${valorTotal.toStringAsFixed(2)}",
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class ListaDeServices extends StatelessWidget {
  ListaDeServices({super.key});

  final Box<Service> box = Hive.box<Service>('services');

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: box.listenable(),
      builder: (context, Box<Service> box, _) {
        final services = box.values.toList();
        if (services.isEmpty) {
          return const Center(
            child: Text(
              'Nenhum serviço registrado ainda!',
              style: TextStyle(fontSize: 18),
            ),
          );
        }
        return ListView.builder(
          itemCount: services.length,
          itemBuilder: (context, index) {
            final service = services[index];

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              elevation: 2,
              child: ListTile(
                title: Text(
                  service.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: Text(
                  "Descrição: ${service.descricao}\n"
                  "Data: ${service.data.day}/${service.data.month}/${service.data.year}\n"
                  "Cliente: ${service.nome_cliente}\n"
                  "Endereço: ${service.endereco}\n"
                  "Valor: R\$ ${service.valor.toStringAsFixed(2)}",
                ),
                isThreeLine: true,
                trailing: SizedBox(
                  width: 70,
                  child: Row(
                    children: [
                      Expanded(
                        child: TrailingButton(
                          icon: Icons.edit,
                          color: Colors.green,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    AdditionServiceView(serviceToEdit: service),
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: TrailingButton(
                          icon: Icons.delete,
                          color: Colors.red,
                          onPressed: () {
                            service.delete();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class AdicionarService extends StatelessWidget {
  const AdicionarService({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.green,
      child: const Icon(Icons.add),
      onPressed: () {
        Navigator.pushNamed(context, 'addition/');
      },
    );
  }
}

class TrailingButton extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final VoidCallback onPressed;

  const TrailingButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: color),
      onPressed: onPressed,
    );
  }
}
