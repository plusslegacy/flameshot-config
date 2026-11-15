# Minha config do Flameshot

Config pronta do [Flameshot](https://flameshot.org) para Windows, pensada para mandar prints pro Claude Code no terminal.

## O que ela faz

- **Win+Shift+S** abre a captura.
- **Ctrl+S** salva direto em `Imagens\prints` (sem janela) e **copia o caminho do arquivo**. É só colar no Claude.
- **Ctrl+C** copia a imagem, como sempre.
- Interface cinza.
- Blur suave no lugar do pixelado com ruído.
- Barra sem os botões: Fixar, Escolher aplicação, Marcador, Contador e Aumentar/Diminuir tamanho.

## Como instalar num PC novo

1. Baixe este repositório (botão verde **Code** > **Download ZIP**) e extraia.
2. Clique com o botão direito em `instalar.ps1` > **Executar com o PowerShell**.
   Se o Windows bloquear, abra o PowerShell na pasta e rode:
   ```
   powershell -ExecutionPolicy Bypass -File instalar.ps1
   ```

O script instala o Flameshot pelo winget (se ainda não tiver), cria a pasta `Imagens\prints`, aplica a config e abre o Flameshot. Se já existia uma config antes, ela fica salva como `flameshot.ini.bak`.

## Observação

A linha `buttons=` do `flameshot.ini` está num formato especial do Flameshot. Não edite ela à mão. Para mudar os botões, use a tela de configuração do Flameshot e copie o `flameshot.ini` de novo (de `%APPDATA%\flameshot`), trocando a linha `savePath=` por `savePath=__SAVEPATH__`.
