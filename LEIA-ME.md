# Flameshot já configurado

Instalador do [Flameshot](https://flameshot.org) para Windows que já vem configurado. Ele foi pensado para mandar prints pro Claude Code no terminal.

## Como instalar

1. Vá em **[Releases](../../releases/latest)** e baixe o `Flameshot-Config-Setup.exe`.
2. Abra o arquivo e clique em **Avançar** até terminar.
   - Se aparecer "O Windows protegeu o computador", clique em **Mais informações** e depois em **Executar assim mesmo**. O aviso aparece porque o instalador não tem assinatura paga.

Pronto. O Flameshot já abre configurado e inicia junto com o Windows.

## O que vem configurado

- **Win+Shift+S** abre a captura.
- **Ctrl+S** salva direto em `Imagens\prints`, sem abrir janela, e **copia o caminho do arquivo**. É só colar no Claude.
- **Ctrl+C** copia a imagem, como sempre.
- Interface cinza.
- Blur suave no lugar do pixelado com ruído.
- Barra sem os botões: Fixar, Escolher aplicação, Marcador, Contador e Aumentar/Diminuir tamanho.

Se já existir uma config do Flameshot no PC, ela é guardada como `%APPDATA%\flameshot\flameshot.ini.bak`.

## Arquivos

| Arquivo | Para que serve |
|---|---|
| `flameshot.ini` | A config (o caminho das prints é preenchido na instalação). |
| `flameshot-setup.iss` | Script do [Inno Setup](https://jrsoftware.org/isinfo.php) que gera o instalador. |
| `instalar.ps1` | Alternativa sem instalador: baixa o Flameshot pelo winget e aplica a config. |
| `LICENSE` | Licença GPL-3.0 do Flameshot. |

## Licença

O Flameshot é software livre sob a licença GPL-3.0. O código-fonte original está em https://github.com/flameshot-org/flameshot (versão 14.0.0). Este instalador só junta os arquivos oficiais com uma configuração diferente.

Não edite a linha `buttons=` do `flameshot.ini` à mão, porque ela está num formato especial do Flameshot.
