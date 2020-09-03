O conteúdo da pasta install é apenas um exemplo de pacote compilado. Não é indicado que esses executáveis sejam atualizados e publicados no git, servem apenas para centralizar as instruções e facilitar o entendimento de como utilizar o software e modificá-lo para seus propósitos.

# Instruções de instalação

* Instale o gereciador de banco de dados Firebird-2.1.X.XXXXX_0_Win32.exe
* Instale o conector ODBC Firebird_ODBC_2.0.X.XXX_Win32.exe
* Instale o Software Attend pelo setup_attend_3.0.X.XX.exe

Durante as instalações utilize as configuraçoẽs sugeridas (basta clicar em NEXT/PROXIMO)

## Configuração de impressão

* Crie uma impressora "Genérico Somente Texto".
* Configure o tipo de papel para formulário contínuo sem quebras.
* Na aba comandos "ao iniciar trabalhos de impressão" digite <1B>c<01> para que a impressora encerre a impressão conforme o comprimento do pedido.

# Instruções de execução

* Se a instalação foi realizada com sucesso basta clicar 2 x no ícone da área de trabalho chamado Attend 2009. Ao rodar o programa deve exibir uma mensagem de licença, basta aguardar o tempo e para então clicar em "Registrar depois".
* Para ver um pedido completo você pode digitar um telefone qualquer (exemplo 12345678) e clicar em ENTER, isso deve abrir a janela de cadastro, digite um nome (exemplo teste) e vai clicando em ENTER até salvar, de volta a janela de pedidos clique em ENTER novamente, digite o pedido (exemplo: 101/102+c), finalize usando F12, vai teclado ENTER até encerrar e imprimir.

# Instruções de atualização

- Após criar um novo executável Attend.exe através do código disponibilizado no [github](https://github.com/cleberjamaral/Attend_3) basta substituir o executável do cliente que normalente fica na pasta `C:\Program Files\OT-Soft\Attend\bin`.
