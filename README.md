# market_list

Um projeto utilizando o framework Flutter.

## Getting Started

Esse projeto consiste em uma lista de mercado, onde pode-se fazer uma 
conversão do valor total da lista em reais para dólar americano.

O projeto utiliza o provider para fazer adição ou subtração das quantidades, também
utiliza Retrofit para fazer um GET de uma Rest API Free, onde todo dia é atualizado os\
valores de conversão.

Para navegar entre telas, é utilizado a ferramenta de rotas nomeadas, podendo
passar dados entre as mesmas.

Utilizou-se o vibrator para fazer uso do plataform channel, onde o Flutter
requisita ao android nativo para vibrar o dispositivo.