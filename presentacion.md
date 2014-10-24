---
title: El protocolo SPDY
author: José Carlos Entrena, Francisco David Charte
date: Fundamentos de redes
---

# Introducción

SPDY es un protocolo de nivel de sesión complementario a HTTP que busca reducir el tiempo de carga de páginas web. 
 
* Maximiza el rendimiento de HTTP reduciendo las conexiones TLS.

* Permite manejar distintas peticiones HTTP de forma concurrente.

* Aumento de seguridad al incorporar TLS como capa subyacente. 

* Reducción de las cabeceras para mejorar la velocidad de transmisión.

# Problemas de HTTP

* Gran número de conexiones TCP. Persistencia insuficiente.

* Peticiones iniciadas exclusivamente desde el cliente.

* Cabeceras sin comprimir y redundantes.

* Datos sin cifrar, pobre autenticación.

# SPDY{.titleslide}

# Server Push

Bla bla

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
  pandoc -t revealjs -o presentacion.html presentacion.md --self-contained

  o bien

  pandoc -t dzslides -o presentacion.html presentacion.md --self-contained
-->
