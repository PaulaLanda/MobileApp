
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  _CameraScreenState() {
    // Constructor
    // Obtén la lista de cámaras disponibles
    availableCameras().then((cameras) {
      // Selecciona la cámara trasera por defecto
      _controller = CameraController(cameras[0], ResolutionPreset.medium);
      // Inicializa el controlador de la cámara
      _initializeControllerFuture = _controller.initialize();
    });
  }
  @override
  void initState() {
    super.initState();
    // Obtén la lista de cámaras disponibles
    availableCameras().then((cameras) {
      // Selecciona la cámara trasera por defecto
      _controller = CameraController(cameras[0], ResolutionPreset.medium);
      // Inicializa el controlador de la cámara
      _initializeControllerFuture = _controller.initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cámara Example'),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Si la inicialización está completa, muestra la vista de la cámara
            return CameraPreview(_controller);
          } else {
            // Muestra un indicador de carga mientras se inicializa la cámara
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () async {
          try {
            // Captura una foto y guarda el archivo en la galería
            final XFile file = await _controller.takePicture();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(imagePath: file.path),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    // Asegúrate de liberar los recursos del controlador de la cámara al salir de la pantalla
    _controller.dispose();
    super.dispose();
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;  // Usa XFile en lugar de String

  const DisplayPictureScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vista previa de la imagen')),
      body: Image.file(File(imagePath)),
    );
  }
}
