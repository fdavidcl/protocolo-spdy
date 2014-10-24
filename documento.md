---
title: El protocolo SPDY
author: José Carlos Entrena, Francisco David Charte
date: Fundamentos de redes
---

# Introducción

SPDY es un protocolo de nivel de sesión complementario a HTTP que busca reducir el tiempo de carga de páginas web. Esto se consigue maximizando el rendimiento de HTTP mediante una reducción del número de conexiones TCP necesarias, permitiendo manejar distintas peticiones HTTP de forma concurrente. 

SPDY consigue un aumento de seguridad al incorporar TLS como capa subyacente. Además, SPDY reduce las cabeceras para mejorar la velocidad de transmisión y reducir el envío de datos. 

# Problemas de HTTP
Con el surgimiento de las aplicaciones web y el cambio de comportamiento
de los usuarios en Internet, que ahora pasan cada vez más tiempo conectados,
salen a relucir algunos problemas que presenta HTTP para manejar los 
intercambios de información:

## Conexiones
Utilizar HTTP implica abrir un gran número de conexiones TCP entre
cliente y servidor para obtener los objetos y recursos de una web.
La persistencia que aporta HTTP1.1 no es suficiente, ya que 
generalmente un *timeout* en el servidor cierra la conexión.

## Solicitudes
HTTP está diseñado para que el cliente haga siempre las peticiones
necesarias. Sin embargo, en las aplicaciones web son muchas las 
ocasiones en las que no se conoce el momento en que se obtendrán
nuevos datos desde el servidor, lo que conlleva que el cliente esté
consultando repetidamente al servidor acerca de los nuevos datos.

## Cabeceras
Las cabeceras de HTTP se envían sin comprimir. Esto implica cierta
latencia, acentuada por la baja velocidad de subida de las redes ADSL.

Además, las cabeceras generalemente son 
redundantes, ya que parte de ellas se puede haber mandado en 
solicitudes anteriores y no cambian a lo largo de toda la sesión.

A continuación se muestra la cabecera HTTP que envía el servidor de
la Universidad de Granada al realizar una petición GET de la página 
principal: 

~~~sh
curl --head http://www.ugr.es
~~~

~~~
HTTP/1.1 200 OK
Date: Fri, 24 Oct 2014 10:36:36 GMT
Server: Apache/2.2.22 (Debian)
X-UniWeb-Server-Name: uniweb10
Vary: Host,X-Forwarded-Host,Accept-Encoding
X-Powered-By: PHP/5.4.4-14+deb7u14
Expires: Thu, 19 Nov 1981 08:52:00 GMT
Cache-Control: must-revalidate, post-check=0, pre-check=0
Pragma: private
ETag: "ca40cd00b5bf682ebc5723adddb32f43"
X-UniWeb-CMS-Server: uniweb10 on steroids
Content-Length: 38262
content-language: es
Content-Type: text/html; charset=utf-8
~~~

Podemos observar que muchos de estos datos solo es necesario 
recibirlos una vez, y sin embargo se enviarán en cada cabecera
para cada respuesta del servidor.

## Seguridad
El uso común de HTTP es sin cifrar, lo que conlleva algunas desventajas 
en cuanto a privacidad de los usuarios, y a seguridad en cuanto a 
autenticación de los puntos finales. 

# SPDY

## Server Push 

Server Push es una técnica que permite al servidor enviar múltiples respuestas a una única petición del cliente. Esto se basa en que a veces, el servidor sabe que tiene que mandar múltiples recursos como respuesta a una petición del cliente. Sin *server push*, el cliente debe primero obtener el recurso principal, y al ver que necesita recursos secundarios, solicitarlos con nuevas peticiones. Todas estas peticiones innecesarias se evitan permitiendo al servidor enviar los recursos secundarios relacionados con el principal, sin esperar a que el cliente los pida. 

Si bien esto reduce el tiempo de obtención de recursos, también crea un posible conflicto en el caso en el que el servidor envía recursos mientras el cliente está en proceso de solicitarlos. Este problema se intenta resolver de la siguiente forma: 

* El navegador que recibe un push debe comprobar que viene de un origen válido (usualmente el mismo que generó la respuesta inicial). 

* Si el push es aceptado, el navegador debe guardar en caché las respuestas de la misma forma que lo haría con cualquier otra respuesta. 

* Al no tener una petición, las respuestas mediante *server push* no tienen una cabecera de petición asociada. Se indicará el identificador de flujo asociado, que nos dirá el flujo de petición inicial con el que se asocia el push. Este hereda todas las cabeceras del flujo asociado, salvo "*:host*", "*:scheme*", y "*:path*". 

### Server Hint

Server Hint es un mecanismo mediante el cual el servidor puede notificar al cliente que existen recursos disponibles antes de que el cliente los descubra. El servidor envía información sobre el recurso, y el cliente puede obtenerlo si lo necesita enviando una petición. 

# Seguridad 

SPDY trabaja sobre TLS. 

# Test bloque de código

<!-- Compilar con
  pandoc --to latex --latex-engine pdflatex -o documento.pdf documento.md --toc -N --template template.tex
-->
