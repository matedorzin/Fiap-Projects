import 'package:flutter/material.dart';
import 'screens/lista_bandas_screen.dart';
import 'models/banda_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bandas App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListaBandasScreen(bandas: bandas),
    );
  }
}

// Dados de exemplo
List<Banda> bandas = [
  Banda(
    nome: 'The Beatles',
    genero: 'Rock',
    imagemUrl: 'imagembeatles',
    descricao: 'The Beatles foi uma banda de rock britânica, formada na cidade de Liverpool em 1960. Com os integrantes John Lennon, Paul McCartney, George Harrison e Ringo Starr, o grupo tornou-se altamente reconhecido como o melhor e mais bem sucedido da era do rock.',
  ),
  Banda(
    nome: 'Queen',
    genero: 'Rock',
    imagemUrl: 'imagemqueen',
    descricao: 'Queen foi uma banda britânica de rock, fundada em 1970 e ativa, sob sua formação clássica, até 1991. O grupo, formado por Brian May (guitarra e vocais), Freddie Mercury (vocais e piano), John Deacon (baixo) e Roger Taylor (bateria e vocais), é frequentemente citado como um dos expoentes do seu estilo, também sendo um dos recordistas de vendas de discos a nível mundial.',
  ),
    Banda(
    nome: 'Guns N Roses',
    genero: 'Rock',
    imagemUrl: 'imagem Guns and Roses',
    descricao: 'Guns N Roses (por vezes abreviado como G N R ou GnR) é uma banda norte-americana de hard rock formada em Los Angeles, Califórnia, em 1985. A banda lançou, até o momento, seis álbuns de estúdio, três EPs e um álbum ao vivo.',
  ),
    Banda(
    nome: 'Metallica',
    genero: 'Rock',
    imagemUrl: 'Imagem Metallica',
    descricao: 'Metallica é uma banda norte-americana de thrash metal originária de Los Angeles, mas com base em San Francisco. O seu repertório inclui tempos rápidos, pesados, melódicos, instrumentais e musicalidade agressiva, a qual os consagrou como pioneiros do thrash metal e uma das bandas participantes do Big Four of Thrash, conjuntamente com Slayer, Megadeth e Anthrax. O Metallica se formou em 1981, após James Hetfield responder a um anúncio que Lars Ulrich havia colocado no jornal local.',
  ),
    Banda(
    nome: 'System of a Down',
    genero: 'Rock',
    imagemUrl: '',
    descricao: 'System of a Down (também conhecida como SOAD ou simplesmente System) é uma banda de heavy metal armênio-americana formada em Glendale, Califórnia, em 1994. Desde 1997, banda é composta pelo vocalista principal Serj Tankian, o guitarrista solo e vocalista Daron Malakian, o baixista Shavo Odadjian e o baterista John Dolmayan, que substituiu o baterista original Andy Khachaturian.',
  ),
     Banda(
    nome: 'Coldplay',
    genero: 'Rock',
    imagemUrl: '',
    descricao: 'Coldplay é uma banda britânica de rock fundada em 1997 na Inglaterra pelo vocalista e pianista Chris Martin e o guitarrista Jonny Buckland no University College London.',
  ),
       Banda(
    nome: 'AD/DC',
    genero: 'Rock',
    imagemUrl: '',
    descricao: 'AC/DC (estilizado como ACϟDC) é uma banda australiana de rock formada em Sydney, Austrália em 1973, pelos irmãos escoceses Malcolm e Angus Young. O estilo musical da banda é normalmente classificado como hard rock e até mesmo blues rock. Mas seus membros sempre classificaram a sua música simplesmente como "rock and roll".',
  ),
       Banda(
    nome: 'Maroon 5',
    genero: 'rock',
    imagemUrl: '',
    descricao: 'O grupo foi formado em 1994 com o nome de Karas Flowers enquanto seus membros ainda estavam no ensino médio. Com um line-up de Adam Levine, Jesse Carmichael, Mickey Madden e Ryan Dusick,eles assinaram com a Reprise Records e lançaram um álbum, The Fourth World, em 1997.',
  ),
        Banda(
    nome: 'One Direction',
    genero: 'Pop',
    imagemUrl: '',
    descricao: 'One Direction (ocasionalmente abreviado por 1D) foi uma boyband pop formada na cidade de Londres, Reino Unido, em 2010. O grupo era formado por Louis Tomlinson, Harry Styles, Liam Payne, Niall Horan e Zayn Malik.[1]. O quinteto foi formado após seus membros participarem do reality show musical The X Factor como competidores solo, até que, durante o programa, a cantora Nicole Scherzinger e Simon Cowell os uniram para concorrer como um grupo. A banda acabou em terceiro lugar do programa, atrás apenas de Rebecca Ferguson e Matt Cardle, respectivamente.',
  ),
          Banda(
    nome: 'Imagine Dragons',
    genero: 'Pop',
    imagemUrl: '',
    descricao: 'magine Dragons é uma banda de pop rock formada em Las Vegas nos Estados Unidos, consistindo do vocalista Dan Reynolds, do guitarrista Wayne Sermon, do baixista Ben McKee e do baterista Daniel Platzman.[9] A banda primeiro ganhou exposição com o lançamento do single "Its Time", seguido por seu álbum de estreia, Night Visions (2012), que resultou nos singles "Radioactive" e "Demons". A Billboard colocou-os no topo do ranking "Year In Rock" de 2013[10] e 2017[11] e nomeou-os como "Banda Revelação de 2013" e "Melhor Banda de 2017".[12] A Rolling Stone nomeou "Radioactive", que deteve o recorde da maioria das semanas na Billboard Hot 100 entre 2014 e 2021,[13] como o maior hit de rock do ano (2013),e a MTV os chamou de a maior banda de breakout do ano (também em 2013).',
  ),
  
  
];

// Variáveis globais para armazenar o nome e a foto do perfil
String globalNome = 'Mateus de Lima Raymundo RM:95758';
String globalFotoUrl = 'https://th.bing.com/th/id/R.7a68f360a5624f548a3002eb566aae8d?rik=R%2blzAAaCBPJb4w&riu=http%3a%2f%2fwww.loe.org%2fcontent%2f2014-04-18%2f10-bananabunch.gif&ehk=dPqjeFevYPyjOuDxThhqTIbbtlZAp5ZryjuIgNE%2fWsM%3d&risl=&pid=ImgRaw&r=0';
