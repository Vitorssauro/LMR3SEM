import 'package:exemplo_jason2/View/info_livro_page.dart';
import 'package:flutter/material.dart';

import '../Controller/livro_controller.dart';

class LivrosPage extends StatefulWidget {
  const LivrosPage({super.key});

  @override
  State<LivrosPage> createState() => _LivrosPageState();
}

class _LivrosPageState extends State<LivrosPage> {
  LivroController controller = new LivroController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Livros"),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Expanded(
          child: FutureBuilder(
              future: controller.loadLivros(),
              builder: (context, snapshot) {
                if (controller.livros.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: controller.livros.length,
                    itemBuilder: (context, index) {
                      // return ListTile(
                      //   title: Text(controller.livros[index].titulo),
                      //   subtitle: Text(controller.livros[index].autor),
                      // );

                      return Card(
                          child: ListTile(
                        title: Text(controller.livros[index].titulo),
                        subtitle: Text(controller.livros[index].autor),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LivroInfoPage(
                              info: controller.livros[index],
                            ),
                          ),
                        ),
                      ));
                    },
                  );
                }
              }),
        ),
      ),
    );
  }
}
