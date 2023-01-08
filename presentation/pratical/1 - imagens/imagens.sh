#!/bin/bash

# Imagens
# Slide 15 (58): Puxar uma imagem
docker pull hello-world

# Slide 15 (58): Testando um registro privado
docker pull 192.168.0.20:443/ascii-art:1.0

# Slide 15 (61): Puxando e rodando uma imagem qualquer
docker run archlinux
