1. Configuração do Listener

    1.1 No Windows, abra o gerenciador de tarefas e vá para a pasta network\admin na pasta
    de instalação do Oracle "C:\OracleDB21cXE\homes\OraDB21Home1\network\admin"

    1.2 Faça uma copia de backup do arquivo "listener.ora"

    1.3 Edite o arquivo "listener.ora"
	
	    Revise e se necessário altere a configuração do listener para 
	    (host = localhost):
    
	    LISTENER = 
	    		(DESCRIPTION LIST = 
	    		  (DESCRIPTION = 
	    		    (ADDRESS = (PROTOCOL = TCP) (HOST = localhost) (PORT = 1521))
	    		    (ADDRESS = (PROTOCOL = ICP) (KEY = EXTPROC1521))
	    		  )
	    		)

    1.4 Salve a alteração no arquivo listener.ora
2. Configurando o arquivo TNSNAME
    
    2.1 No Windows, abra o gerenciador de tarefas e vá para a pasta network\admin na pasta
    de instalação do Oracle "C:\OracleDB21cXE\homes\OraDB21Home1\network\admin"

    2.2 Faça uma copia de backup do arquivo tnsnames.ora

    2.3 Edite o arquivo "tnsnames.ora"

         Revise e se necessário altere a configuração do listener para 
	    (host = localhost):

        XE =
        (DESCRIPTION =
            (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))
            (CONNECT_DATA =
                (SERVER = DEDICATED)
                (SERVICE_NAME = XE)
            )
        )

        LISTENER_XE =
            (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))
        
        
        ORACLR_CONNECTION_DATA =
            (DESCRIPTION =
                (ADDRESS_LIST =
                    (ADDRESS = (PROTOCOL = IPC)(KEY = EXTPROC1521))
                )
                (CONNECT_DATA =
                    (SID = CLRExtProc)
                    (PRESENTATION = RO)
                )
            )
3. Reiniciando os serviços Oracle e Listener do Windows
    3.1 Pare o serviço: OracleServiceXE

    Obs. Deixe esse serviço como automatico

    3.2 Pare o serviço OracleOraDB21Home1TNSListener

    Obs. Deixe esse serviço como automatico

    3.3 Inicie primeiro o Listener depois o Oracle Service 

4. Criando e testando conexão local

    4.1 Abrir o Menu iniciar
        4.1.1 Clicar em todos aplicativos
        4.1.2 Procurar OraDB21Home1
        4.1.3 Abrir Assistente de Configuração de Rede
        4.1.4 No Assistente selecionar Configuração do Nome do serviço de 
              Rede Local 
        4.1.5 selecionar Adicionar
        4.1.6 Nome: XEPDB1
        4.1.7 TCP
        4.1.8 localhost porta 1521
        4.1.9 sim, fazer um teste
        4.1.10 user system, senha 12345
        4.1.11 Mesmo nome do banco
        4.1.12 Não
        4.1.13 Finalizar
    4.2 Abra o CMD

        4.2.1 Digite "sqlplus system/12345@XEPDB1"
        4.2.2 Digite "select sysdate from dual;"
    

