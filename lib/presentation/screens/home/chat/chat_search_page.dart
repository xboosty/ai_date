import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Mensaje {
  final String usuario;
  final String mensaje;

  Mensaje(this.usuario, this.mensaje);
}

class ChatSearchPage extends StatefulWidget {
  @override
  _ChatSearchPageState createState() => _ChatSearchPageState();
}

class _ChatSearchPageState extends State<ChatSearchPage> {
  TextEditingController _searchController = TextEditingController();
  int _selectedFilter = 0; // 0 para Mensajes, 1 para Usuario

  List<Mensaje> mensajes = [
    Mensaje("Usuario1", "Hola, este es el mensaje 1."),
    Mensaje("Usuario2", "Mensaje de usuario 2."),
    Mensaje("Usuario3", "Tercer mensaje."),
    Mensaje("Usuario1", "Otro mensaje de Usuario1."),
    Mensaje("Usuario4", "Cuarto mensaje."),
  ];

  List<Mensaje> _filteredMensajes = [];

  @override
  void initState() {
    super.initState();
    _filteredMensajes = List.from(mensajes);
  }

  void _filterResults(String searchText) {
    setState(() {
      if (searchText.isEmpty) {
        _filteredMensajes = List.from(mensajes);
      } else {
        _filteredMensajes = mensajes.where((mensaje) {
          if (_selectedFilter == 0) {
            return mensaje.mensaje
                .toLowerCase()
                .contains(searchText.toLowerCase());
          } else {
            return mensaje.usuario
                .toLowerCase()
                .contains(searchText.toLowerCase());
          }
        }).toList();
      }
    });
  }

  void _showSearchSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (text) {
                        setState(() {
                          _filterResults(text);
                        });
                      },
                      decoration: InputDecoration(labelText: 'Buscar'),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: ToggleSwitch(
                initialLabelIndex: _selectedFilter,
                labels: ['Mensajes', 'Usuario'],
                onToggle: (index) {
                  setState(() {
                    _selectedFilter = index ?? 0;
                    _filterResults(_searchController.text);
                  });
                },
              ),
            ),
            // Lista de resultados filtrados en tiempo real
            Expanded(
              child: ListView.builder(
                itemCount: _filteredMensajes.length,
                itemBuilder: (context, index) {
                  final mensaje = _filteredMensajes[index];

                  return ListTile(
                    title: Text(
                        'Usuario: ${mensaje.usuario}\nMensaje: ${mensaje.mensaje}'),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        _showSearchSheet(context);
      },
      icon: const Icon(Icons.search),
    );
  }
}
