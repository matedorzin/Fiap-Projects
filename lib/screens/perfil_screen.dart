import 'package:flutter/material.dart';
import '../models/banda_model.dart';
import '../main.dart'; // Importar variáveis globais

class PerfilScreen extends StatefulWidget {
  final Set<Banda> favoritas;

  PerfilScreen({required this.favoritas});

  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  @override
  void initState() {
    super.initState();
    _nomeController.text = globalNome;
    _fotoUrlController.text = globalFotoUrl;
  }

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _fotoUrlController = TextEditingController();

  void _editName() async {
    String? newName = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Editar Nome'),
        content: TextField(
          controller: _nomeController,
          decoration: InputDecoration(labelText: 'Nome'),
        ),
        actions: [
          TextButton(
            child: Text('Cancelar'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text('Salvar'),
            onPressed: () => Navigator.pop(context, _nomeController.text),
          ),
        ],
      ),
    );

    if (newName != null) {
      setState(() {
        globalNome = newName;
      });
    }
  }

  void _editPhoto() async {
    String? newPhotoUrl = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Editar URL da Foto'),
        content: TextField(
          controller: _fotoUrlController,
          decoration: InputDecoration(labelText: 'URL da Foto'),
        ),
        actions: [
          TextButton(
            child: Text('Cancelar'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text('Salvar'),
            onPressed: () => Navigator.pop(context, _fotoUrlController.text),
          ),
        ],
      ),
    );

    if (newPhotoUrl != null) {
      setState(() {
        globalFotoUrl = newPhotoUrl;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        title: Text('Meu Perfil'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: _editPhoto,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(globalFotoUrl),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Center(
              child: GestureDetector(
                onTap: _editName,
                child: Text(
                  globalNome,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 24.0),
            Text(
              'Bandas Favoritas',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: widget.favoritas.length,
                itemBuilder: (context, index) {
                  final banda = widget.favoritas.elementAt(index);
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
                      icon: Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          widget.favoritas.remove(banda);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Total Favoritadas: ${widget.favoritas.length}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}