<img src="https://github.com/marceloams/smart-device-app/blob/master/assets/images/readme/header-readme.png?raw=true">

---

# Smart Device App [![Build Status](https://travis-ci.com/marceloams/smart-device-app.svg?branch=master)](https://travis-ci.com/marceloams/smart-device-app)

---

## 📱 Aplicação 

- Aplicativo web e mobile para manipulação e monitoramento de sensores modulares conectados à internet;

- A aplicação está dividida em três partes: 
  - Aplicativo Mobile (branch master);
  - Aplicativo Web (branch temporary-web-version);
  - Software Embarcado ([outro repositório](https://github.com/marceloams/smart-device));

- Versão web temporária enquanto algumas bibliotecas utilizadas não possuem portabilidade para a versão web do Flutter.

---

## 📝 Funcionalidades 

#### O projeto possuí as seguintes funcionalidades:

- [x] Adição de dispositivo;
- [x] Listagem dos dispositivos;
- [x] Configuração de dispositivo;
- [x] Exclusão de dispositivo;
- [x] Leitura em tempo real da medida de um dispositivo;
- [x] Listagem das medidas de um dispositivo;
- [x] Cadastro de usuário;
- [x] Configuração do usuário.

---

## 📲 Telas do aplicativo

#### O aplicativo possuí as seguintes telas:

<img src="https://github.com/marceloams/smart-device-app/blob/master/assets/images/readme/Screens-readme-user.png?raw=true">
<img src="https://github.com/marceloams/smart-device-app/blob/master/assets/images/readme/Screens-readme-device.png?raw=true">

---

## 🛠️ Ferramentas 

#### Foram utilizadas as seguintes ferramentas no desenvolvimento do projeto:

[![marceloamsProductions](http://img.shields.io/badge/-Dart-0175C2?style=flat&logo=Dart&logoColor=white)](https://dart.dev/)
[![marceloamsProductions](https://img.shields.io/badge/-Flutter-3a495d?style=flat&logo=flutter&logoColor=67b7f7)](http://flutter.dev)
[![marceloamsProductions](http://img.shields.io/badge/-Android%20Studio-3DDC84?style=flat&logo=Android%20Studio&logoColor=black)](https://developer.android.com/studio)
[![marceloamsProductions](https://img.shields.io/badge/-Firebase-3a495d?style=flat&logo=Firebase&logoColor=FFCA28)](https://firebase.google.com/)
[![marceloamsProductions](https://img.shields.io/badge/-Travis-B10000?style=flat&logo=Travis)](https://travis-ci.org/)

---

## 📚 Bibliotecas 

#### Foram utilizadas as seguintes bibliotecas no desenvolvimento do projeto:

- <a href="https://pub.dev/packages/firebase_database" target="_blank">firebase_database</a>;
- <a href="https://pub.dev/packages/firebase_core" target="_blank">firebase_core</a>;
- <a href="https://pub.dev/packages/clipboard" target="_blank">clipboard</a>;
- <a href="https://pub.dev/packages/mockito" target="_blank">mockito</a>;
- <a href="https://pub.dev/packages/flutter_launcher_icons" target="_blank">flutter_launcher_icons</a>;
- <a href="https://pub.dev/packages/auth_buttons" target="_blank">auth_buttons</a>;
- <a href="https://pub.dev/packages/firebase_auth" target="_blank">firebase_auth</a>;
- <a href="https://pub.dev/packages/google_sign_in" target="_blank">google_sign_in</a>;
- <a href="https://pub.dev/packages/flutter_facebook_auth" target="_blank">flutter_facebook</a>;
- <a href="https://pub.dev/packages/firebase_storage" target="_blank">firebase_storage</a>;
- <a href="https://pub.dev/packages/auth_buttons" target="_blank">auth_buttons</a>;
- <a href="https://pub.dev/packages/cloud_firestore" target="_blank">cloud_firestore</a>;
- <a href="https://pub.dev/packages/multiavatar" target="_blank">multiavatar</a>;
- <a href="https://pub.dev/packages/flutter_svg" target="_blank">flutter_svg</a>;
- <a href="https://pub.dev/packages/fake_cloud_firestore" target="_blank">fake_cloud_firestore</a>;
- <a href="https://pub.dev/packages/firebase_auth_mocks" target="_blank">firebase_auth_mocks</a>;
- <a href="https://pub.dev/packages/google_sign_in_mocks" target="_blank">google_sign_in_mocks</a>;
- <a href="https://pub.dev/packages/flutter_native_splash" target="_blank">flutter_native_splash</a>;
- <a href="https://pub.dev/packages/firebase" target="_blank">firebase (somente usada na versão web)</a>;

---

## 📁 Organização do repositório

- <a href="https://github.com/marceloams/smart-device-app/tree/master/lib" target="_blank">Códigos de produção</a>;
- <a href="https://github.com/marceloams/smart-device-app/tree/master/test" target="_blank">Códigos de teste</a>.

---

## ⚡ Como utilizar - passo a passo

  
### Via APK 💿

#### Requisitos

  - No mínimo Android 4.1 - Jelly Bean (API 16);

#### Funcionamento

 - <a href="https://github.com/marceloams/smart-device-app/releases/download/0.1/app-release.apk" target="_blank">Baixe o APK diretamente em seu dispositivo</a>

### Via Código 💻

#### Requisitos

  - Flutter SDK;
  - Android Studio ou Visual Studio Code;
  - Android SDK;
  - Java JDK;
  - Um emulador ou um dispositivo para testar a aplicação.
 
#### Verificação 

Rode a seguinte linha de código no prompt de comando:

```
flutter doctor
```

Caso algo deu errado, segue um [tutorial](https://www.treinaweb.com.br/blog/configurando-ambiente-de-desenvolvimento-flutter/) de como configurar o ambiente de desenvolvimento.

#### Passo 1

  - 👯 Clonar o repositório.

#### Passo 2

  - Abra o projeto e inicie o emulador ou conecte o seu dispositivo.
 
#### Passo 3

- No prompt de comando dentro do diretório do projeto, rode os seguintes comandos:

```
flutter pub get
flutter run
```

 #### Passo 4 (Opcional)
 
 - Por fim, se desejar, siga os passos citados no [repositório do software embarcado](https://github.com/marceloams/smart-device);
 
---
 
✔️ Se seguiu os passos e obteve sucesso é sinal que funcionou!
<br>
<br>
<img src="https://media.giphy.com/media/nDSlfqf0gn5g4/giphy.gif">
<br>
<br>
❌ Se algum dos passos não funcionou, algo de errado não está certo! (Faça um issue)
<br>
<br>
<img src="https://media.giphy.com/media/wofftnAdDtx4s/giphy.gif">

---

## 🔨 Contribuição

### Passo 1

- **Opção 1**
    - 🍴 Forkar esse repositório!

- **Opção 2**
    - 👯 Clonar para sua maquina atual.

### Passo 2

- **Codar!** 👨‍💻👩‍💻

### Passo 3

- 🔃 Crie um novo pull request.

 ---
 
 ## 👨‍💻 Autores


| **Marcelo Amorim** | **Caio Souza** |
| :---: | :---: |
| [![SmartDeviceAppProductions](https://avatars1.githubusercontent.com/u/63866348?&v=4&s=200)](https://github.com/marceloams) | [![SmartDeviceAppProductions](https://avatars1.githubusercontent.com/u/21149887?&v=4&s=200)](https://github.com/CaioHpSouza) |

---
 
 ## ©️ Licença

[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)

- **[MIT license](http://opensource.org/licenses/mit-license.php)**
- Copyright 2020 © <a href="https://github.com/marceloams/smart-device-app" target="_blank">SmartDeviceAppProductions</a>.

---

