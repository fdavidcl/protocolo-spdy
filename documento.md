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

## Seguridad
El uso común de HTTP es sin cifrar, lo que conlleva algunas desventajas 
en cuanto a privacidad de los usuarios, y a seguridad en cuanto a 
autenticación de los puntos finales. 

# SPDY

# Test bloque de código

~~~sh
curl --head http://www.google.es
~~~

~~~
HTTP/1.1 200 OK
Date: Mon, 20 Oct 2014 18:34:03 GMT
Expires: -1
Cache-Control: private, max-age=0
Content-Type: text/html; charset=ISO-8859-1
Server: gws
X-XSS-Protection: 1; mode=block
X-Frame-Options: SAMEORIGIN
Alternate-Protocol: 80:quic,p=0.01
Transfer-Encoding: chunked
~~~

<!-- Compilar con
  pandoc --to latex --latex-engine pdflatex -o documento.pdf documento.md --toc -N --template template.tex
-->
