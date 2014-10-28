---
title: El protocolo SPDY
author: José Carlos Entrena, Francisco David Charte
date: Fundamentos de redes
---

# Introducción{.titleslide}

# Objetivos

* Maximizar el rendimiento de HTTP reduciendo las conexiones TCP.

* Permitir manejar distintas peticiones HTTP de forma concurrente.

* Aumentar la seguridad incorporando TLS como capa subyacente. 

* Reducir las cabeceras para mejorar la velocidad de transmisión.

# Problemas de HTTP

* Gran número de conexiones TCP. Persistencia insuficiente.

* Peticiones iniciadas exclusivamente desde el cliente.

* Cabeceras sin comprimir y redundantes.

* Datos sin cifrar, pobre autenticación.

# Cabeceras HTTP

~~~bash
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

# SPDY{.titleslide}

# Negociación de protocolo

* NPN/ALPN permiten escoger protocolo y versión.

* En NPN la selección se envía cifrada, en ALPN sin cifrar.

~~~bash
spdycat -nv https://duckduckgo.com
~~~
~~~
[  0.316] NPN select next protocol: remote server offers:
          * spdy/3.1
          * http/1.1
          NPN selected the protocol: spdy/3.1
[  0.388] Handshake complete
~~~

* Compatible con servidores / clientes que no soporten SPDY.

# Sesiones

* Utiliza una conexión TCP persistente. 

* Envío y recepción de marcos
    
    * `SYN_STREAM`, `SYN_REPLY`
    
    * `DATA_FRAME`
    
    * `GOAWAY` (cierra conexión) 

* No se repiten los datos que se envían al comienzo de la sesión. 

# Server Push

Permite al servidor mandar múltiples respuestas a una única peticion del cliente. 

* Reduce el tiempo de obtención de recursos. 

* Libera de carga al cliente. 

* Server Hint nos informa de recursos sin enviarlos completamente. 

# Seguridad

* Uso de TLS como capa de seguridad, encriptando la información. 

* No se añaden posibles ataques *cross-protocol*. 

# HTTP/2

# Demo time!{.titleslide}

<!-- Compilar con
  pandoc -t revealjs -o presentacion.html presentacion.md --self-contained

  o bien

  pandoc -t dzslides -o presentacion.html presentacion.md --self-contained
-->

<!-- Estilo -->

<link href='http://fonts.googleapis.com/css?family=Lato:400,300,700,400italic,700italic' rel='stylesheet' type='text/css'>
<style>
  * {
    
  }
  body {
    background: #303030;
    color: white;
  }
  section {
    font-family: Lato, 'Lato', Open Sans, Ubuntu, sans-serif;
  }
  h1 {
    font-weight: 300;
    font-size: 2.4em;
  }
  section.slide:not(.titleslide) h1 {
    font-size: 2.1em;
  }
  h1, b, strong {
    color: #66bbee;
  }
  section.titleslide {
    background: #000;
    color: white;
  }
  pre {
    font-size: 0.8em;
  }

  section {
      -moz-transition: left 400ms ease-in-out 0s, opacity 300ms ease-in-out;
      -webkit-transition: left 400ms ease-in-out 0s, opacity 300ms ease-in-out;
      -ms-transition: left 400ms ease-in-out 0s, opacity 300ms ease-in-out;
      transition: left 400ms ease-in-out 0s, opacity 300ms ease-in-out;
  }
  /* Before */
  section { left: -150%; opacity: 0; }
  /* Now */
  section[aria-selected] { left: 0; opacity: 1; }
  /* After */
  section[aria-selected] ~ section { left: +150%; opacity: 0; }
</style>
