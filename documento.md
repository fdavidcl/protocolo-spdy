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

* Utilizar HTTP implica abrir un gran número de conexiones TCP entre
  cliente y servidor para obtener los objetos y recursos de una web.
  La persistencia que aporta HTTP1.1 no es suficiente, ya que 
  generalmente un *timeout* en el servidor cierra la conexión


# SPDY

## Server Push 

Server Push es una técnica que permite al servidor enviar múltiples respuestas a una única petición del cliente. Esto se basa en que a veces, el servidor sabe que tiene que mandar múltiples recursos como respuesta a una petición del cliente. Sin *server push*, el cliente debe primero obtener el recurso principal, y al ver que necesita recursos secundarios, solicitarlos con nuevas peticiones. Todas estas peticiones innecesarias se evitan permitiendo al servidor enviar los recursos secundarios relacionados con el principal, sin esperar a que el cliente los pida. 

Si bien esto reduce el tiempo de obtención de recursos, también crea un posible conflicto en el caso en el que el servidor envía recursos mientras el cliente está en proceso de solicitarlos. Se puede resolver con:  

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
