import 'package:frontend/models/customer.dart';
import 'package:flutter/material.dart';

/// BO == Business Objects
/// Here we got functions, widgets or whatever we want to help

// getstatusCode() is a function that give us info about http response
// we give it the status code and returns its meaning
String getstatusCode(int statusCode) {
  String result;
  String ri = 'Respuesta informativa:';
  String rs = 'Respuesta satisfactoria:';
  String redireccion = 'Redirección:';
  String ec = 'Error de cliente:';
  String es = 'Error de servidor:';

  switch (statusCode) {
    case 100:
      {
        result =
            '$ri Todo ok. Debe continuar con la solicitud o ignorarla si está terminada';
      }
      break;
    case 101:
      {
        result = '$ri Solicitud de UPGRADE aceptada.';
      }
      break;
    case 102:
      {
        result = '$ri Procesando la solicitud.';
      }
      break;
    case 200:
      {
        result = '$rs La solicitud ha tenido éxito.';
      }
      break;
    case 201:
      {
        result =
            '$rs La solicitud ha tenido éxito y se ha creado un nuevo recurso como resultado de ello. Ésta es típicamente la respuesta enviada después de una petición PUT.';
      }
      break;
    case 202:
      {
        result =
            '$rs La solicitud se ha recibido, pero aún no se ha actuado. Es una petición "Sin compromiso", lo que significa que no hay manera en HTTP que permita enviar una respuesta asíncrona que indique el resultado del procesamiento de la solicitud. Está pensado para los casos en que otro proceso o servidor maneja la solicitud, o para el procesamiento por lotes.';
      }
      break;
    case 203:
      {
        result =
            '$rs La petición se ha completado con éxito, pero su contenido no se ha obtenido de la fuente originalmente solicitada, sino que se recoge de una copia local o de un tercero. Excepto esta condición, se debe preferir una respuesta de 200 OK en lugar de esta respuesta.';
      }
      break;
    case 204:
      {
        result =
            '$rs La petición se ha completado con éxito pero su respuesta no tiene ningún contenido, aunque los encabezados pueden ser útiles. El agente de usuario puede actualizar sus encabezados en caché para este recurso con los nuevos valores.';
      }
      break;
    case 205:
      {
        result =
            '$rs La petición se ha completado con éxito, pero su respuesta no tiene contenidos y además, el agente de usuario tiene que inicializar la página desde la que se realizó la petición, este código es útil por ejemplo para páginas con formularios cuyo contenido debe borrarse después de que el usuario lo envíe.';
      }
      break;
    case 206:
      {
        result =
            '$rs La petición servirá parcialmente el contenido solicitado. Esta característica es utilizada por herramientas de descarga como wget para continuar la transferencia de descargas anteriormente interrumpidas, o para dividir una descarga y procesar las partes simultáneamente.';
      }
      break;
    case 207:
      {
        result =
            '$rs Una respuesta Multi-Estado transmite información sobre varios recursos en situaciones en las que varios códigos de estado podrían ser apropiados. El cuerpo de la petición es un mensaje XML.';
      }
      break;
    case 208:
      {
        result =
            '$rs El listado de elementos DAV ya se notificó previamente, por lo que no se van a volver a listar.';
      }
      break;
    case 226:
      {
        result =
            '$rs El servidor ha cumplido una petición GET para el recurso y la respuesta es una representación del resultado de una o más manipulaciones de instancia aplicadas a la instancia actual.';
      }
      break;
    case 300:
      {
        result =
            '$redireccion Esta solicitud tiene más de una posible respuesta. User-Agent o el usuario debe escoger uno de ellos. No hay forma estandarizado de seleccionar una de las respuestas.';
      }
      break;
    case 301:
      {
        result =
            '$redireccion Este código de respuesta significa que la URI  del recurso solicitado ha sido cambiado. Probablemente una nueva URI sea devuelta en la respuesta.';
      }
      break;
    case 302:
      {
        result =
            '$redireccion Este código de respuesta significa que el recurso de la URI solicitada ha sido cambiado temporalmente. Nuevos cambios en la URI serán agregados en el futuro. Por lo tanto, la misma URI debe ser usada por el cliente en futuras solicitudes.';
      }
      break;
    case 303:
      {
        result =
            '$redireccion El servidor envia esta respuesta para dirigir al cliente a un nuevo recurso solcitado a otra dirección usando una petición GET.';
      }
      break;
    case 304:
      {
        result =
            '$redireccion Esta es usada para propositos de "caché". Le indica al cliente que la respuesta no ha sido modificada. Entonces, el cliente puede continuar usando la misma versión almacenada en su caché.';
      }
      break;
    case 305:
      {
        result =
            '$redireccion Fue definida en una versión previa de la especificación del protocolo HTTP para indicar que una respuesta solicitada debe ser accedida desde un proxy. Ha quedado obsoleta debido a preocupaciones de seguridad correspondientes a la configuración de un proxy.';
      }
      break;
    case 306:
      {
        result =
            '$redireccion Este código de respuesta ya no es usado más. Actualmente se encuentra reservado. Fue usado en previas versiones de la especificación HTTP1.1.';
      }
      break;
    case 307:
      {
        result =
            '$redireccion El servidor envía esta respuesta para dirigir al cliente a obtener el recurso solicitado a otra URI con el mismo metodo que se uso la petición anterior. Tiene la misma semántica que el código de respuesta HTTP 302 Found, con la excepción de que el agente usuario no debe cambiar el método HTTP usado: si un POST fue usado en la primera petición, otro POST debe ser usado en la segunda petición.';
      }
      break;
    case 308:
      {
        result =
            '$redireccion Significa que el recurso ahora se encuentra permanentemente en otra URI, especificada por la respuesta de encabezado HTTP Location:. Tiene la misma semántica que el código de respuesta HTTP 301 Moved Permanently, con la excepción de que el agente usuario no debe cambiar el método HTTP usado: si un POST fue usado en la primera petición, otro POST debe ser usado en la segunda petición.';
      }
      break;
    case 400:
      {
        result =
            '$ec Esta respuesta significa que el servidor no pudo interpretar la solicitud dada una sintaxis inválida.';
      }
      break;
    case 401:
      {
        result =
            '$ec Es necesario autenticar para obtener la respuesta solicitada. Esta es similar a 403, pero en este caso, autenticación es posible.';
      }
      break;
    case 402:
      {
        result =
            '$ec Este código de respuesta está reservado para futuros usos. El objetivo inicial de crear este código fue para ser utilizado en sistemas digitales de pagos. Sin embargo, no está siendo usado actualmente.';
      }
      break;
    case 403:
      {
        result =
            '$ec El cliente no posee los permisos necesarios para cierto contenido, por lo que el servidor está rechazando otorgar una respuesta apropiada.';
      }
      break;
    case 404:
      {
        result =
            '$ec El servidor no pudo encontrar el contenido solicitado. Este código de respuesta es uno de los más famosos dada su alta ocurrencia en la web.';
      }
      break;
    case 405:
      {
        result =
            '$ec El método solicitado es conocido por el servidor pero ha sido deshabilitado y no puede ser utilizado. Los dos métodos obligatorios, GET y HEAD, nunca deben ser deshabilitados y no debiesen retornar este código de error.';
      }
      break;
    case 406:
      {
        result =
            '$ec Esta respuesta es enviada cuando el servidor, despues de aplicar una negociación de contenido servidor-impulsado, no encuentra ningún contenido seguido por la criteria dada por el usuario.';
      }
      break;
    case 407:
      {
        result =
            '$ec Esto es similar al código 401, pero la autenticación debe estar hecha a partir de un proxy.';
      }
      break;
    case 408:
      {
        result =
            '$ec Esta respuesta es enviada en una conexión inactiva en algunos servidores, incluso sin alguna petición previa por el cliente. Significa que el servidor quiere desconectar esta conexión sin usar. Esta respuesta es muy usada desde algunos navegadores, como Chrome, Firefox 27+, o IE9, usa mecanismos de pre-conexión HTTP para acelerar la navegación. También hay que tener cuenta que algunos servidores simplemente desconectan la conexión sin enviar este mensaje.';
      }
      break;
    case 409:
      {
        result =
            '$ec Esta respuesta puede ser enviada cuando una petición tiene conflicto con el estado actual del servidor.';
      }
      break;
    case 410:
      {
        result =
            '$ec Esta respuesta puede ser enviada cuando el contenido solicitado ha sido borrado del servidor.';
      }
      break;
    case 411:
      {
        result =
            '$ec El servidor rechaza la petición porque el campo de encabezado Content-Length no esta definido y el servidor lo requiere.';
      }
      break;
    case 412:
      {
        result =
            '$ec El cliente ha indicado pre-condiciones en sus encabezados la cual el servidor no cumple.';
      }
      break;
    case 413:
      {
        result =
            '$ec La entidad de petición es más larga que los limites definidos por el servidor; el servidor puede cerrar la conexión o retornar un campo de encabezado Retry-After.';
      }
      break;
    case 414:
      {
        result =
            '$ec La URI solicitada por el cliente es más larga que el servidor está dispuesto a interpretar.';
      }
      break;
    case 415:
      {
        result =
            '$ec El formato multimedia de los datos solicitados no está soportada por el servidor, por lo cual el servidor rechaza la solicitud.';
      }
      break;
    case 416:
      {
        result =
            '$ec El rango especificado por el campo de encabezado Range en la solicitud no cumple; es posible que el rango está fuera del tamaño de los datos objetivo del URI.';
      }
      break;
    case 4017:
      {
        result =
            '$ec Significa que la expectativa indicada por el campo de encabezado Expect solicitada no puede ser cumplida por el servidor.';
      }
      break;
    case 4018:
      {
        result =
            '$ec El servidor se reúsa a intentar hacer café con una tetera.';
      }
      break;
    case 421:
      {
        result =
            '$ec La petición fue dirigida a un servidor que no es capaz de producir una respuesta. Esto puede ser enviado por un servidor que no esta configurado para producir respuestas por la combinación del esquema y la autoridad que estan incluidos en la URI solicitada';
      }
      break;
    case 422:
      {
        result =
            '$ec La petición estaba bien formada pero no se pudo seguir debido a errores de semántica.';
      }
      break;
    case 423:
      {
        result = '$ec El recurso que está siendo accedido está bloqueado.';
      }
      break;
    case 424:
      {
        result =
            '$ec La petición falló debido a una falla de una petición previa.';
      }
      break;
    case 426:
      {
        result =
            '$ec El servidor se reúsa a aplicar la solicitud usando el protocolo actual pero puede estar dispuesto a hacerlo después que el cliente se actualize a un protocolo diferente. El servidor envía un encabezado Upgrade en una respuesta para indicar los protocolos requeridos.';
      }
      break;
    case 428:
      {
        result =
            '$ec El servidor origen requiere que la solicitud sea condicional. Tiene la intención de prevenir problemas de "actualización perdida", donde un cliente OBTIENE un estado del recurso, lo modifica, y lo PONE devuelta al servidor, cuando mientras un tercero ha modificado el estado del servidor, llevando a un conflicto.';
      }
      break;
    case 429:
      {
        result =
            '$ec El usuario ha enviado demasiadas solicitudes en un periodo de tiempo dado.';
      }
      break;
    case 431:
      {
        result =
            '$ec El servidor no está dispuesto a procesar la solicitud porque los campos de encabezado son demasiado largos. La solicitud PUEDE volver a subirse después de reducir el tamaño de los campos de encabezado solicitados.';
      }
      break;
    case 451:
      {
        result =
            '$ec El usuario solicita un recurso ilegal, como alguna página web censurada por algún gobierno.';
      }
      break;
    case 500:
      {
        result =
            '$es El servidor ha encontrado una situación que no sabe como manejarla.';
      }
      break;
    case 501:
      {
        result =
            '$es El método solicitado no esta soportado por el servidor y no puede ser manejada. Los unicos métodos que los servidores requieren soporte (y por lo tanto no deben retornar este código) son GET y HEAD.';
      }
      break;
    case 502:
      {
        result =
            '$es Esta respuesta de error significa que el servidor, mientras trabaja como una puerta de enlace para obtener una respuesta necesaria para manejar la petición, obtuvo una respuesta inválida.';
      }
      break;
    case 503:
      {
        result =
            '$es El servidor no esta listo para manejar la petición. Causas comunes puede ser que el servidor está caido por mantenimiento o está sobrecargado. Hay que tomar en cuenta que junto con esta respuesta, una página usuario-amigable explicando el problema debe ser enviada. Estas respuestas deben ser usadas para condiciones temporales y el encabezado HTTP Retry-After: debería, si es posible, contener el tiempo estimado antes de la recuperación del servicio. El webmaster debe también cuidar los encabezados relacionados al caché que son enviados junto a esta respuesta, ya que estas respuestas de condicion temporal deben usualmente no estar en el caché.';
      }
      break;
    case 504:
      {
        result =
            '$es Esta respuesta de error es dada cuando el servidor está actuando como una puerta de enlace y no puede obtener una respuesta a tiempo.';
      }
      break;
    case 505:
      {
        result =
            '$es La versión de HTTP usada en la petición no está soportada por el servidor.';
      }
      break;
    case 506:
      {
        result =
            '$es El servidor tiene un error de configuración interna: negociación de contenido transparente para la petición resulta en una referencia circular.';
      }
      break;
    case 507:
      {
        result =
            '$es El servidor tiene un error de configuración interna: la variable de recurso escogida esta configurada para acoplar la negociación de contenido transparente misma, y no es por lo tanto un punto final adecuado para el proceso de negociación.';
      }
      break;
    case 508:
      {
        result =
            '$es El servidor detectó un ciclo infinito mientras procesaba la solicitud.';
      }
      break;
    case 510:
      {
        result =
            '$es Extensiones adicionales para la solicitud son requeridas para que el servidor las cumpla.';
      }
      break;
    case 511:
      {
        result =
            '$es El código de estado 511 indica que el cliente necesita auntenticar para ganar acceso a la red.';
      }
      break;
  }
  return 'Estatus $statusCode => $result';
}

asignid(List<Customer> items, Customer item) {
  if (items == null || items.isEmpty) {
    item.id = 1;
  } else {
    items.sort((b, a) => a.id.compareTo(b.id));
    item.id = items[0].id + 1;
  }
  return item;
}

Widget textfield(String labeltext, TextEditingController controller,
    {bool obscureText, bool validate, bool outlineBorder = false}) {
  InputDecoration inputDecoration;
  if (validate != null && outlineBorder == false) {
    inputDecoration = InputDecoration(
      labelText: labeltext,
      errorText: validate ? null : 'Field can\'t be empty',
    );
  } else if (validate != null && outlineBorder == true) {
    inputDecoration = InputDecoration(
      labelText: labeltext,
      border: OutlineInputBorder(),
      errorText: validate ? null : 'Field can\'t be empty',
    );
  } else if (validate == null && outlineBorder == false) {
    inputDecoration = InputDecoration(
      labelText: labeltext,
    );
  } else {
    inputDecoration = InputDecoration(
      labelText: labeltext,
      border: OutlineInputBorder(),
    );
  }
  return TextField(
    obscureText: obscureText,
    decoration: inputDecoration,
    controller: controller,
  );
}

bool isNullOrEmpty(String string) {
  if (string.isEmpty || string == '' || string == null) {
    return true;
  } else {
    return false;
  }
}

bool isDefault(Customer customer) {
  if (customer == null || (customer.id == -1 && customer.username == '')) {
    return true;
  } else {
    return false;
  }
}

Widget raisedButton(String buttonText, {Function onPressed, double fontSize = 12.0, double height, double width}) {
  if (onPressed == null) {
    onPressed = () {};
  }
  return Container(
    height: height,
    width: width,
      child: InkWell(
        child: RaisedButton(
            textColor: Colors.white,
            child: Text(
              buttonText,
              style: TextStyle(fontSize: 18),
            ),
            onPressed: onPressed),
      ));
}

void openInfoDialog(
    BuildContext context, String dialogTitle, String dialogContent) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: new Text(dialogTitle),
          content: new Text(dialogContent),
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: new Text('Back'))
          ],
        );
      });
}

void openActionDialog(BuildContext context, String dialogTitle,
    String dialogContent, String actionButtonText, Function actionOnPressed) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: new Text(dialogTitle),
          content: new Text(dialogContent),
          actions: <Widget>[
            new FlatButton(
                onPressed: actionOnPressed, child: new Text(actionButtonText)),
            new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: new Text('Back'))
          ],
        );
      });
}
