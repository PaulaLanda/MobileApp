import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';

class editclub_page extends StatefulWidget {
  static String id = 'editclubPage';

  @override
  editclubPageState createState() => editclubPageState();
}

Widget photo(BuildContext context) {
  return Stack(
    children: [
      SizedBox(
        width:
            MediaQuery.of(context).size.width, // Ancho igual al de la pantalla
        height: 250,
        child: Image.network(
          'https://via.placeholder.com/500x500', // URL de la imagen
          fit: BoxFit.cover, // Ajusta la imagen para cubrir el contenedor
        ),
      ),
      Positioned(
        top: 0,
        left: 0,
        child: IconButton(
          icon: Icon(Icons.close, size: 30, color: Colors.redAccent),
          onPressed: () {
            // Lógica para cerrar la pantalla o realizar alguna acción al presionar el botón de cierre
          },
        ),
      ),
    ],
  );
}

Widget mainText(BuildContext context) {
  return SingleChildScrollView(
    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: Text(
                'Qubeeeeeeeeeeeeeeeeeeeeeeeeeeeee',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 70,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            // Envolver el ícono con un GestureDetector
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // Controladores para los campos de texto
                    TextEditingController nameController =
                        TextEditingController();
                    TextEditingController addressController =
                        TextEditingController();

                    return AlertDialog(
                      title: Text('Club information'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          // Campo de texto para el nombre
                          TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(labelText: 'Nombre'),
                          ),
                          SizedBox(height: 10), // Espacio entre campos de texto
                          // Campo de texto para la dirección
                          TextFormField(
                            controller: addressController,
                            decoration: InputDecoration(labelText: 'Dirección'),
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            // Imprimir la información ingresada por el usuario
                            print('Name: ${nameController.text}');
                            print('Address: ${addressController.text}');

                            // Cerrar la ventana emergente
                            Navigator.of(context).pop();
                          },
                          child: Text('Guardar'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Cerrar la ventana emergente sin guardar
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancelar'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Icon(Icons.edit, size: 33, color: Colors.black),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Text(
              'Address: ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Text(
                'Calle santa maria ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  /*return SingleChildScrollView(
    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: Text(
                'Qubeeeeeeeeeeeeeeeeeeeeeeeeeeeee',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 70,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Icon(Icons.edit, size: 33, color: Colors.black),
              ],
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Text(
              'Address: ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Text(
                'Calle santa maria ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );*/
}

Widget map(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(
        horizontal: 20.0), // Padding horizontal de 20 en cada lado
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          height: 150,
          child: Image.network(
            'https://via.placeholder.com/500x500',
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 10), // Espacio entre la imagen y el texto
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Distance: ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '15 km',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget timetable(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20.0),
    child: Container(
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: AppColors.greenApp,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Timetable",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(width: 20),
          Column(
            children: [
              // Ejemplo con filas de "Monday - CLOSED" para demostración
              for (var i = 0; i < 7; i++)
                Row(
                  children: [
                    Text(
                      "Monday",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "CLOSED",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          SizedBox(width: 50),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return TimetableEditDialog();
                },
              );
            },
            child: Icon(Icons.edit, size: 33, color: Colors.black),
          ),
        ],
      ),
    ),
  );
}

class TimetableEditDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Timetable'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Generar campos de texto por día para la ventana emergente
            for (var day in [
              'Monday',
              'Tuesday',
              'Wednesday',
              'Thursday',
              'Friday',
              'Saturday',
              'Sunday'
            ])
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 100, // Ancho específico para el día
                      child: Text(
                        day,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter data for $day',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Save'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}

/*Widget timetable(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20.0),
    child: Container(
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: AppColors.greenApp,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Timetable",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(width: 20),
          Column(
            children: [
              Row(
                children: [
                  Text(
                    "Monday",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    "CLOSED",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Monday",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    "CLOSED",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Monday",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    "CLOSED",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Monday",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    "CLOSED",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Monday",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    "CLOSED",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Monday",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    "CLOSED",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Monday",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    "CLOSED",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(width: 50),
          Icon(Icons.edit, size: 33, color: Colors.black),

        ],
      ),
    ),
  );
}*/

Widget tickets(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20.0),
    child: Container(
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: AppColors.greenApp,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tickets",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(width: 20),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          'https://via.placeholder.com/50/CCCCCC/000000?text=Placeholder',
                          width: 25,
                          height: 25,
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 150,
                            child: Text(
                              "Before 1:00 am",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            width: 150,
                            child: Text(
                              "5€ - 1 cup",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 10), // Espacio entre los bloques
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              'https://via.placeholder.com/50/CCCCCC/000000?text=Placeholder',
                              width: 25,
                              height: 25,
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 150,
                                child: Text(
                                  "Before 1:00 am",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(
                                width: 150,
                                child: Text(
                                  "5€ - 1 cup",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10), // Espacio entre los bloques
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              'https://via.placeholder.com/50/CCCCCC/000000?text=Placeholder',
                              width: 25,
                              height: 25,
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 150,
                                child: Text(
                                  "Before 1:00 am",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(
                                width: 150,
                                child: Text(
                                  "5€ - 1 cup",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return TicketsEditDialog();
                    },
                  );
                },
                child: Icon(Icons.edit, size: 33, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class TicketsEditDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit tickets'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Generar campos de texto por día para la ventana emergente
            for (var time in [
              'Before 1 am',
              'After 1 am',
            ])
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 100, // Ancho específico para el tiempo
                      child: Text(
                        time,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DropdownButtonFormField<String>(
                            value: null, // Valor inicial establecido en null
                            items: List.generate(
                              10,
                                  (index) => DropdownMenuItem<String>(
                                value: '${index + 1} cup',
                                child: Text('${index + 1} cup'),
                              ),
                            ),
                            onChanged: (newValue) {
                              // Implementa la lógica aquí
                              print('Nuevo valor: $newValue');
                            },
                            decoration: InputDecoration(
                              hintText: 'Select quantity',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            initialValue: '',
                            onChanged: (newValue) {
                              // Lógica para el valor ingresado manualmente
                              // Implementa la lógica aquí según tus necesidades
                              print('Nuevo valor manual para $time: $newValue');
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter price manually',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return TicketInputDialog(); // Llama a la nueva ventana emergente
              },
            );
            print("Review pressed");
          },
          child: Text(
            'Add new ticket',
            style: TextStyle(color: AppColors.greenApp),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Save',
            style: TextStyle(color: AppColors.greenApp),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel',
            style: TextStyle(color: AppColors.greenApp),
          ),
        ),
      ],
    );
  }
}

class TicketInputDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String description = '';
    String cups = '';
    String price = '';

    return AlertDialog(
      title: Text('Add new ticket'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              onChanged: (value) {
                description = value;
              },
              decoration: InputDecoration(
                labelText: 'Description',
              ),
            ),
            SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: null, // Valor inicial establecido en null
              items: List.generate(
                10,
                    (index) => DropdownMenuItem<String>(
                  value: '${index + 1} cup',
                  child: Text('${index + 1} cup'),
                ),
              ),
              onChanged: (newValue) {
                // Implementa la lógica aquí
                print('Nuevo valor: $newValue');
              },
              decoration: InputDecoration(
                hintText: 'Select quantity',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextFormField(
              onChanged: (value) {
                price = value;
              },
              decoration: InputDecoration(
                labelText: 'Price',
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            print('Description: $description');
            print('Cups: $cups');
            print('Price: $price');
            Navigator.of(context).pop();
          },
          child: Text('Save',
            style: TextStyle(color: AppColors.greenApp),),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel',
            style: TextStyle(color: AppColors.greenApp),),
        ),
      ],
    );
  }
}

class editclubPageState extends State<editclub_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: ListView(
                children: [
                  photo(context),
                  SizedBox(height: 5),
                  mainText(context),
                  SizedBox(height: 5),
                  map(context),
                  SizedBox(height: 5),
                  timetable(context),
                  SizedBox(height: 8),
                  tickets(context),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
