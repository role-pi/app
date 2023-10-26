# app
![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?logo=Flutter&logoColor=white) ![iOS](https://img.shields.io/badge/iOS-000000?logo=apple&logoColor=white) ![Android](https://img.shields.io/badge/Android-3DDC84?logo=android&logoColor=white)

Este repositório contém o código-fonte do aplicativo rolê, desenvolvido em Flutter. O rolê é um aplicativo que permite aos usuários organizarem eventos sociais e fazerem controle de gastos de forma prática, intuitiva e eficiente.

### Requisitos

Antes de executar o projeto, verifique se o seguinte software está instalado em seu sistema Windows:

- Flutter SDK
- Android Studio
- Um emulador de dispositivo Android ou um dispositivo Android físico para testar o aplicativo.

<details>
<summary>Instalação do Flutter SDK</summary>
<br>

Para instalar o Flutter SDK em seu sistema, siga os seguintes passos:

1. **Baixe o Flutter:** Visite o site oficial do Flutter em https://flutter.dev/ e faça o download da versão mais recente do SDK para o seu sistema operacional (Windows, macOS ou Linux).

2. **Extraia o arquivo baixado:** Após o download ser concluído, extraia o arquivo ZIP baixado em um diretório de sua preferência.

3. **Configurar as variáveis de ambiente:** Adicione o diretório do Flutter extraído ao seu PATH para que você possa executar comandos Flutter a partir de qualquer local no terminal.

4. **Verificar a instalação:** Abra um terminal e execute o seguinte comando para desativar builds nativas para Windows e verificar se o Flutter foi instalado corretamente:

   ```
   flutter config --no-enable-windows-desktop
   flutter doctor
   ```

   Este comando exibirá um relatório sobre o estado da sua instalação do Flutter e informará se há algum problema ou requisito faltando.

</details>

<details>
<summary>Instalação do Android Studio</summary>
<br>

O Android Studio é uma IDE oficial do Google para desenvolvimento Android e fornece ferramentas necessárias para o desenvolvimento de aplicativos Android. Siga os passos abaixo para instalá-lo:

1. **Baixe o Android Studio:** Acesse o site oficial do Android Studio em https://developer.android.com/studio e baixe a versão adequada para o seu sistema operacional.

2. **Instale o Android Studio:** Após o download ser concluído, execute o instalador e siga as instruções na tela para concluir a instalação.

3. **Configurar o Android SDK:** Após a instalação do Android Studio, execute-o e siga o assistente de configuração para configurar o Android SDK e baixar as ferramentas necessárias para desenvolvimento Android.

4. **Configurar um emulador:** No Android Studio, abra o AVD Manager (Android Virtual Device Manager) e crie um emulador de dispositivo Android com a imagem de sistema que deseja usar para testar o aplicativo. Alternativamente, você também pode usar um dispositivo Android físico para testar o aplicativo.
</details>

### Como executar o projeto

Siga os passos abaixo para executar o projeto em sua máquina local:

1. **Clone o repositório:** Comece clonando este repositório em seu ambiente de desenvolvimento local usando o comando:

   ```
   git clone https://github.com/role-pi/flutter.git
   ```

2. **Instale as dependências:** Navegue até o diretório do projeto e execute o seguinte comando para instalar as dependências do Flutter:

   ```
   cd pasta-do-projeto
   flutter pub get
   ```

3. **Iniciar o emulador ou conectar o dispositivo:** Inicie o emulador de dispositivo Android criado no Android Studio ou conecte seu dispositivo Android físico ao computador.

4. **Executar o aplicativo:** Use o seguinte comando para executar o aplicativo no emulador ou dispositivo físico:

   ```
   flutter run
   ```

O aplicativo será compilado e instalado no emulador ou dispositivo Android conectado. Aguarde alguns instantes para que o aplicativo seja totalmente carregado. Ao salvar qualquer arquivo de código-fonte, a interface atualizará automaticamente com um hot reload.
