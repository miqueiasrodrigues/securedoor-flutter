# SecureDoor
Um aplicativo móvel que pode abrir uma fechadura magnética por meio de um QRCode. O SecureDoor escaneia um QRCode único e envia uma informação para base de dados Firebase, em seguida o microcontrolador ESP32 acessa essa base de dados onde estão os cadastro das pessoas que tem acesso e ocorre a validação da informação, se o usuário tiver na base de dados, um LED verde acende, em um display LCD mostra a situação de "aberto!"e é acionado um relé, caso contrário o LED vermelho permanece aceso, mostrando no display LCD a situação de "Trancado!"

<img src="https://github.com/miqueiasrodrigues/SecureDoor/blob/main/assets/images/0.jpeg" width="280">

## Aplicativo Móvel
A interface do SecureDoor deve ser simples, que possui um design que facilita sua utilização, com botões grandes e intuitivos. Ao iniciar o aplicativo o usuário deve-se
cadastrar, para fazer isso, ele deve ir em CRIAR SUA CONTA, nessa tela vai pedir para colocar o nome, e-mail, descrição e senha. O e-mail vai ser usado como ID do usuário,
dessa forma, não é possível cadastrar duas ou mais contas com o mesmo e-mail. Para realizar isso foi necessário construir um classe ***User*** que possui os atributos essências para fazer isso.

<img src="https://github.com/miqueiasrodrigues/SecureDoor/blob/main/assets/images/1.jpeg" width="280"> <img src="https://github.com/miqueiasrodrigues/SecureDoor/blob/main/assets/images/2.jpeg" width="280"> 

Depois de cadastrar a conta, o aplicativo volta para a tela de login, para que o usuário possa acessar a conta criada. 

<img src="https://github.com/miqueiasrodrigues/SecureDoor/blob/main/assets/images/3.jpeg" width="280">

Após fazer o login na conta, o aplicativo redireciona para a tela inicial, onde o usuário pode escanear o QRCode.

<img src="https://github.com/miqueiasrodrigues/SecureDoor/blob/main/assets/images/frame.png" width="200"> 


## Sistema da Fechadura magnética
O microcontrolador ESP32 é um dos principais componentes do protótipo, é ele que vai coletar as informações dos sensores e enviá-las para o banco de dados Firebase. Quando o sistema inicia é possível visualizar o estado padrão do sistema, em que o LED vermelho ligado, o relé não está acionado e é possível visualizar em um display LCD,
a informação que está trancado. Quando é feito o escâner do QRCode, o sistema muda e estado e o relé aciona,
o LED vermelho apaga e o verde acende, e é possível ver no display LCD a situação de aberta. 

[![Demonstração do Projeto](https://yt-embed.herokuapp.com/embed?v=HN4Dl7bCTV0)](https://www.youtube.com/watch?v=HN4Dl7bCTV0 "Demonstração do SecureDoor")


