Configurar variaveis de ambiente para O Java
------------------
1- Configurar Path
------------------
1.1- Menu iniciar
1.2- Procurar por "Editar as variaveis de ambiente"
1.3- Ir na aba Avançado
1.4- Pressione Variaveis de ambiente
1.5- Em variaveis do sistema, selecionar Path
1.6- Clique em Editar
1.7- Adicionar novo
1.8- Ir até "C:\Arquivos de Programas\Java\jdk-18.0.1.1\bin" e pegar o caminho
------------------------------------------------------------------------------
------------------
2- Criar novo JAVA_HOME
------------------
2.1- Ainda em Variaveis de ambiente, apertar em "Novo"
2.2- Nome da variavel: JAVA_HOME
2.3- valor do ambiente: C:\Arquivos de Programas\Java\jdk-18.0.1.1
2.4- Dar OK para finalizar e ir aos testes
------------------------------------------------------------------------------
-----------------
3- Testes
-----------------
3.1- Abrir CMD
3.2- Digitar "java -version"
3.3- Verificar se está na aplicada nos passos anteriores
3.4- Digitar "javac -version"
3.3- Verificar se está na aplicada nos passos anteriores
3.5- Digitar "echo %JAVA_HOME%"
3.6- Verificar se está na aplicada nos passos anteriores
3.7- Digitar "echo %Path%"
3.8- Verificar se está na aplicada nos passos anteriores