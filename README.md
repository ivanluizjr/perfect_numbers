# :shield: Perfect Number

Este projeto foi um desafio proposto de fazer um app que encontre os números perfeitos, digitando um número ou digitando dois números entre um intervalo.
  
## :computer: Tecnologias, APIs, Packages utilizados:
  
  * Flutter / Dart
  * VSCode IDE
  * Package Flutter Bloc
  * Package Get It
  * Package Flutter Localizations
  * Package Equatable
  * Package Shared Preferences
  * Package Uuid
  * Package Intl
  * Package Url Launcher
  * Package Mocktail
  * Package Flutter Launcher Icons
  * Package Flutter Native Splash

## :national_park: UX/Ui

A UX/UI deste projeto foi desenvolvido pela ferramenta Stitch da Google passando a ideia que foi proposta. É sempre bom ter um fluxo de telas a seguir para um bom desenvolvimento tanto de front como de regra de negócio.

<img width="19%" alt="tela1" src="https://github.com/user-attachments/assets/7f7ee146-8d8e-4588-9c4e-7e1e338d7200" />

<img width="19%" alt="tela2" src="https://github.com/user-attachments/assets/88bc766f-6b7a-47d4-af14-9c5114851e9f" />

<img width="19%" alt="tela3" src="https://github.com/user-attachments/assets/5a21ff83-65d3-4fe1-9990-831a4ca09238" />

<img width="19%" alt="tela4" src="https://github.com/user-attachments/assets/d249a476-b9c8-4eea-83f7-a1f3e807b470" />

<img width="19%" alt="tela5" src="https://github.com/user-attachments/assets/b39df80e-1e7d-48a2-bb6d-a40ca4416651" />

  
## :file_folder: Organização de pastas e arquivos do projeto:

<img width="40%" alt="pastas" src="https://github.com/user-attachments/assets/93de54b0-b4dc-49b4-97fc-eac7e9ff8e5f" />

## :keyboard: Estágios de desenvolvimento do projeto:

  - Seguindo os conceitos de uma arquitetura limpa, fiz a organização das pastas do nosso projeto e configurações de pacotes e widgets 
    que utilizariamos durante o desenvoltimento, como também toda a configuração inicial necessária para um app.

  - Este projeto utiliza Clean Architecture não por necessidade de escala, mas como demonstração prática de princípios de engenharia de software: separação de responsabilidades                             (Data/Domain/Presentation), inversão de dependência via interfaces, injeção de dependência com GetIt, gerenciamento de estado reativo com BLoC/Cubit, e testes unitários com mocks. A arquitetura         permitiu, por exemplo, migrar o cálculo de números perfeitos para um Isolate sem alterar nenhuma linha na camada de apresentação.

  - Um problema enfrentado durante os testes do app, foi colocar um intervalo entre 1 e 10.000.000 milhões. O que aconteceu, o app travou, precisamos como já citado desenvolver um isolate, como
    sabemos o Flutter ele utiliza uma única thread que fica responsável por processar animações, renderizar frames, executar o código dart. Com um intervalo de cálculo de milhões de interações
    matemáticas, resumindo, tudo irá travar e o app não vai mais responder. A busca em intervalo utiliza Isolate.run() para executar o cálculo computacionalmente intensivo em uma thread separada,           garantindo que a interface permaneça responsiva mesmo em intervalos de milhões de números.

  - Para rodar o projeto você precisa clonar o mesmo e executar em uma IDE de sua preferência utilizando um emulador ou device ou gerar um APK e rodar em seu aparelho Android.

  - **IMPORTANTE**, o projeto foi desenvolvido na SDK 3.11.1 do Dart e Flutter SDK 3.41.3, podendo talvez não rodar em SDKs inferiores.
 
##

 # :iphone: Demonstração do App
  

https://github.com/user-attachments/assets/1f79f531-672b-4b1d-b7ce-25abb5216e4c


#
![FLutter-1](https://user-images.githubusercontent.com/41458938/161364495-d0dbe155-75f3-4a03-a58f-307d9212b8aa.png)



