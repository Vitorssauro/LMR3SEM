import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  // Gerar um número aleatório entre 1 e 100
  Random random = Random();
  int numeroAleatorio = random.nextInt(100) + 1;

  int tentativas = 0;
  bool acertou = false;

  print('Bem-vindo ao jogo de adivinhar o número!');
  print('Tente adivinhar o número secreto entre 1 e 100.');

  while (!acertou) {
    stdout.write('Digite um número: ');
    int palpite = int.parse(stdin.readLineSync()!);

    tentativas++;

    if (palpite == numeroAleatorio) {
      acertou = true;
      print('Parabéns! Você acertou o número em $tentativas tentativas.');
    } else if (palpite < numeroAleatorio) {
      print('O número é maior. Tente novamente.');
    } else {
      print('O número é menor. Tente novamente.');
    }
  }
}
