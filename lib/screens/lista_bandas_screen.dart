import 'package:flutter/material.dart';
import '../models/banda_model.dart';
import 'detalhes_banda_screen.dart';
import 'perfil_screen.dart';

class ListaBandasScreen extends StatefulWidget {
  final List<Banda> bandas;

  ListaBandasScreen({required this.bandas});

  @override
  _ListaBandasScreenState createState() => _ListaBandasScreenState();
}

class _ListaBandasScreenState extends State<ListaBandasScreen> {
  Set<Banda> favoritas = {};
  String ordem = 'A-Z';
  String _searchQuery = '';

  void toggleFavorita(Banda banda) {
    setState(() {
      if (favoritas.contains(banda)) {
        favoritas.remove(banda);
      } else {
        favoritas.add(banda);
      }
    });
  }

  void ordenarBandas() {
    setState(() {
      if (ordem == 'A-Z') {
        widget.bandas.sort((a, b) => a.nome.compareTo(b.nome));
      } else {
        widget.bandas.sort((a, b) => b.nome.compareTo(a.nome));
      }
    });
  }

  void _updateSearchQuery(String newQuery) {
    setState(() {
      _searchQuery = newQuery;
    });
  }

  List<Banda> _filteredBands() {
    return widget.bandas.where((banda) {
      return banda.nome.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    ordenarBandas();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        leading: IconButton(
          icon: Icon(Icons.person),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PerfilScreen(favoritas: favoritas),
              ),
            );
          },
        ),
        title: TextField(
          onChanged: _updateSearchQuery,
          decoration: InputDecoration(
            hintText: 'Search bands...',
            hintStyle: TextStyle(color: Colors.white),
          ),
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          SizedBox(width: 48), // Espaço para centralizar o título
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Ordenar: '),
                DropdownButton<String>(
                  value: ordem,
                  items: <String>['A-Z', 'Z-A']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      ordem = newValue!;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredBands().length,
              itemBuilder: (context, index) {
                final banda = _filteredBands()[index];
                final isFavorita = favoritas.contains(banda);
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text(
                      banda.nome.substring(0, 1).toUpperCase(),
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Text(banda.nome),
                  subtitle: Text(banda.genero),
                  trailing: IconButton(
                    icon: Icon(
                      isFavorita ? Icons.favorite : Icons.favorite_border,
                      color: isFavorita ? Colors.red : null,
                    ),
                    onPressed: () {
                      toggleFavorita(banda);
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalhesBandaScreen(banda: banda),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}