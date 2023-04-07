Redo Log Redo Log History 

Em operações típicas de banco de dados, todas as transações são gravadas nos online redo logs. Isso permite a recuperação automática de transações no caso de uma falha do banco. • Se o banco está configurado para o modo Noarchivelog, nenhum histórico é gravado nos archive log files, e operações de recovery são limitadas e uma perda de transações pode ocorrer. Isso é o resultado da reciclagem automática dos redo log files, onde log files mais antigos necessários para recovery são sobrescritos e somente a parte mais recente do histórico de transação está disponível. • Você pode configurar um banco de dados em modo Archivelog, de modo que um histórico de informações de redo é mantido em archived logs, permitindo uma recuperação completa até o ponto da falha. • 0 banco de dados pode ser inicialmente criado em modo Archivelog, mas por default ele é configurado para modo Noarquivelog. 


Modo Noarchivelog 

Por default um banco de dados é criado modo NOARCHIVELOG. As características de executar um banco de dados em modo noarchivelog são as seguintes: 
• Redo log files são usados de forma circular. 
• Um redo log file pode ser reutilizado imediatamente após ser feito um checkpoint. 
• Urna vez que redo logs tenham sido sobrescritos, a recuperação só é possível até o último backup completo. 
Implicações do Modo Noarchivelog 
• Se uma tablespace se torna indisponível devido a uma falha, você não pode continuar a operar o banco até que a tablespace tenha sido removida ou o banco inteiro tenha sido restaurado a partir de backups. 
• Você pode realizar backups apartir do sistema operacional do banco de dados quando este está desligado. 
• Você deve fazer backup de todo o conjunto de data files, redo log files e control files durante cada backup. 
• Você perderá todos os dados desde o último backup completo. 
• Você não pode fazer backups online. 

Opções de Media Recovery em Modo Noarchivelog 
• Você deve recuperar os data files, redo log files e control files de uma cópia anterior de um backup completo do banco.

• Se você usar o utilitário Export para fazer backup do banco, você pode usar o utilitário Import para recuperar dados perdidos. Entretanto, isso resulta em uma recuperação incompleta e transações podem ser perdidas.


Modo Archivelog 

• Um redo log file preenchido não pode ser reutilizado até que um checkpoint tenha sido executado e o redo log file tenha sido arquivado pelo processo background ARCn. Uma entrada no histórico de log do contrai file registra o número de seqüência de log do log file arquivado. 
• As alterações mais recentes efetuadas no banco de dados estão disponíveis a qualquer hora para uma recuperação da instância, e as cópias dos redo logs antigos podem ser usadas para recuperação de uma falha de mídia. 
Requisitos de Arquivamento 
• O banco de dados deve estar em modo archivelog. Executar o comando para colocar o banco em modo archivelog atualiza o control file. 0 processo background ARCn pode ser habilitado para: implementar arquivamento automático. 
• Recursos suficientes devem estar disponíveis para manter os archived redo log files gerados. 
Implicações de Configurar o Modo Archivelog no Control File 
• O banco de dados fica protegido da perda de dados devido a falha de mídia. 
• Você pode fazer backup do banco enquanto ele está online (veja "alter tablespace begin/end backup"). 
• Quando uma tablespace, sem ser a SYSTEM, fica offline por causa de uma falha de mídia, o restante do banco permanece disponível porque os dados necessários para a recuperação da tablespace offline estão arquivados, e essa recuperação pode ser feita online. 
• Mais grupos de online redo log garantem que o arquivamento de redo files offline seja completado antes que eles se tornem novamente necessários para reutilização. 
Opções de Recuperação de Mídia 
• Você pode restaurar uma cópia de backup dos arquivos danificados e usar archived log files para trazer o data file para um estado atualizado enquanto o banco está online ou offline. 
• Você pode restaurar o banco para um momento específico de tempo. 
• Você pode restaurar o banco para o fim de um archived log file específico. 
• Você pode restaurar o banco para um system change number (SCN) específico. 


Habilitando o Modo Archivelog 

É uma tarefa do DBA alterar o modo. Isso é feito com o comando ALTER DATABASE enquanto o banco está em estado MOUNT. Passo Número Descrição 
1 Tire o banco do ar: SQL> shutdown immediate 
2 Inicie o_ banco no estado MOUNT para alterar o modo archive: SQL> startup mount 
3 Configure o banco para modo archivelog com o comando ALTER DATABASE: SQL> alter database archivelog; 
4 Abra o banco de dados: SQL> alter database open; 
5 Tire o banco do ar: SQL> shutdown immediate 
6 Faça um backup completo do banco de dados.

onde: archivelog estabelece o modo archivelog para os grupos de redo log files. noarchivelog estabelece o modo no archivelog para os grupos de redo log files. 
Nota: depois de o modo do banco de dados ter sido mudado para archivelog, você deve fazer um backup de todos os data files e do control file. O seu backup anterior não é mais reutilizável, pois ele foi feito enquanto o banco estava em modo noarchivelog. 0 novo backup feito depois de o banco ter sido posto em modo archivelog é o backup sobre o qual todos os seus futuros archived log files serão aplicados. 

Configurando o destino dos Archivelogs 

Configure o arquivamento modificando os seguintes parâmetros do init.ora: LOG_ARCHIVE_DEST n = none-do-arquivo 
onde: é um número de 1 a 10. É possível especificar até 10 destinos diferentes. nome_ do_arquivo e uma string de texto representando a localização default dos archived log files e pode incluir um diretório ou caminho. Exemplo no UNIX/Linux: LOG ARCHIVE_DEST_1=/oracle/flash_recovery_area/CURSO/archivelog/ 
Exemplo no Windows: LOG_ARCHIVE_DEST_1=c:\oracle\flash recovery_area\cursobr\archivelog\ 
E também o parâmetro: 
LOG-ARCHIVE-FORMAT = extensão 
onde: 
extensão deve incluir as variáveis %r, %t e %s. 
Exemplo no UNIX/Linux e Windows: LOO ARCHIVE_FORMAT=arch%r?6t?ss.arc 

Opções de Nome de Arquivo • %s ou %S: incluem o número de seqüência do log como parte do nome do arquivo. • %t ou %T: inclui o número da thread como parte do nome do arquivo. • %r ou %R: inclui o identificador de resetlog do banco de dados. • Usando caixa alta (%S) fará com que o valor fique com tamanho fixo, sendo preenchido com zeros à esquerda. 
Especificando Multiplas Localizações de Arquivamento Especifique até dez destinos de arquivamento utilizando o parâmetro LOG ARCHIVE DEST n. Disco local ou banco de dados remoto 
Parâmetro LOG ARCHIVE DEST n 
LO4 ARCHIVE_DEST_1 = 'LOCATION=/archival'
LOCI ARCHIVE DEST 2 = 'SERVICE=ataadby_db1'


• O parâmetro dinâmico LOG_ARCHIVE_DEST n pode ser modificado a nível de sessão. 0 número máximo de destinos é dez (10) pode ser especificado utilizando um sufixo que varia de 1 até 10. 
• O destino pode ser qualquer um Um diretório local, definido quando utilizada a palavra chave LOCATION: a localização especificada deve ser válida não pode ser um diretório NFS montado. 
Um alias ORACLE NET para um banco de dados remoto, pode ser especificado utilizando a palavra chave SERVICE: o nome do serviço especificado é encontrado através da utilização do arquivo TNSNAMES.ORA, este utilizado para identificar a instância remota. O Oracle suporta somente transporte de archive log files para uma maquina remota através dos protocolos de rede IPC ou TCP/IP. Somente um destino de arquivamento por banco remoto pode ser especificado. 
Parâmetros LOG ARCHIVE DEST e LOG ARCHIVE: DUPLEX DEST Um dos meios alternativos de definir múltiplas localizações de arquivamento é especificando uma localização primária usando o parâmetro LOG_ARCHIVE_DEST e utilizando o parâmetro LOG_ARCHIVE_DUPLEX_DEST para definir um destino para backup. Este método é equivalente a utilização do parâmetro LOG_ARCHIVE_DEST_1 e LOG_ARCHIVE DEST 2, com a exceção que o primeiro método não pode ser utilizado para arquivamento em localizações remotas. Os dois métodos para definir destinos de arquivamento são mutuamente exclusivos. LOG_ARCHIVE_DEST_n é recomendado. Entretando, LOG_ARCHIVE_DEST e LOG ARCHIVE_DUPLEX_DEST são os únicos parâmetros aceitos em bancos não-Enterprise. 
Opções de Múltiplos Arquivamentos • Configure a localização para arquivamento corno MANDATORY ou OPTIONAL. • Defina o tempo que deve aguardar antes de tentar arquivar novamente. LOG_ARCHIVE_DEST_1 = LOCATION=/archive MANDATORY REOPEN" LOG_ARCHIVE_DEST_2 = "SERVICE=atandby_dbi MANDATORY REOPEN-6001 LOG_ARCHIVS_DEST_3 = "LOCATION=/arChive2 OPTIONAL" 
MANDATORY versus OPCIONAL • Quando utilizado o parâmetro LOG_ARCHIVE_DEST_n, um destino pode ser designado como mandatory ou opcional como segue abaixo: - MANDATORY implica que o arquivamento para o destino deve ter ocorrido com sucesso para que um online redo log file possa ser sobrescrito. 

- OPTIONAL implica que o online redo log file pode ser reutilizado mesmo que o arquivamento para o destino não tenha ocorrido com sucesso. • 0 valor default da opção de destinos de arquivamento é OPTIONAL. Deve haver pelo menos um destino como obrigatório. • Se você utilizar o método secundário, LOG_ARCHIVE_DEST é implicitamente considerado como localização obrigatória, enquanto o LOG ARCHIVE_DUPLEX DEST é considerado como localização opcional.
Atributo REOPEN • 0 atributo REOPEN define se um destino de arquivamento deve ser tentado de novo em caso de falha. Se um número é especificado após a palavra chave REOPEN, como REOPEN=600, o archiver espera para escrever no destino após o número de segundos especificado apartir do momento da falha. 0 default é 300 segundos. Não há nenhum limite de número de tentativas para arquivar em um destino, exceto se especificado MAXFAILURES=n. Qualquer erro que ocorra ao tentar arquivar no destino primário é informado no alert file. • Se o REOPEN não for especificado, erros para destinos opcionais são gravados e ignorados. Nenhum redo log adicional será enviado para estes destinos. Erros em destinos obrigatórios previnirão a reutilização do online redo log até o arquivamento terminar com êxito. É fixado 'ERROR' para um destino de arquivamento sempre que o arquivamento falhar. 
Especificando o Número Mínimo de Destinos Locais • Parâmetro LOG ARCHIVE MIN SUCCEED DEST • Um grupo de online redo logs pode ser reutilizado somente se: O arquivamento foi efetuado em todas as localizações obrigatórias. O número de localizações para arquivamento local é maior ou igual ao valor do parâmetro LOG ARCHIVE MIN SUCCEED DEST. 

LOG ARCHIVE MIN SUCCEED DEST e. Mandatory O número de destinos que precisam ser arquivados com sucesso antes que um online redo log file possa ser utilizado é baseado nas seguintes colocações: • 0 número de destinos definidos como MANDATORY. • 0 valor do parâmetro LOG_ARCHIVE_MIN_SUCCEED_DEST. 0 valor especificado do parâmetro LOG_ARCHIVE_MIN_SUCCEEDDEST, é o limite mínimo de destinos locais que precisam ser arquivados. Se este número é menor que número de destinos locais obrigatórios, não faz nenhum efeito no comportamento do arquivamento. Se o número excede o número de destinos locais obrigatórios, o número de destinos de arquivamento tem que ser pelo menos igual a este valor para que o online redo log file possa ser reutilizado.

Nota: Quando configurado o arquivamento, você deve ter certeza que os nomes dos caminhos são fixos de acordo com o ambiente do sistema operacional. Estes diferem entre o UNIX/Linux e o Windows 
Exemplo: Considerando um caso onde o parâmetro LOG_ARCHIVE_MIN_SUCCEED_ DEST é configurado para 2. Se o número de destinos locais obrigatórios (mandatory) é 3, nestas três localizações deve ocorrer o arquivamento antes que os online redo logs possam ser reutilizados. Em outro caso, se o número de destinos locais obrigatórios (mandatory) é 1, então pelo menos um destino de arquivamento opcional local deve ser arquivado antes que um online redo log file possa ser reutilizado. Em outras palavras, o parâmetro LOG_ARCHIVE MIN _SUCCEED_DEST pode ser utilizado para fazer o arquivamento de um ou mais destinos opcionais obrigatórios, porém não o contrário. 
Controlando o Arquivamento para um Destino 
• Um destino de arquivamento pode ser desabilitado por um parâmetro de inicialização dinâmico: LOG ARCHIVE DEST STATE n 
LOG-ARCHIVE DEST STATE_2 = DEFER LOG_ARCHIVE DEST STATE_3 = DEFER 

Arquivamento para os destinos podem ser habilitados novamente: 
LOG ARCHIVE_DEST STATE_2 = ENABLE ALTER SYSTEM SET LOG_ARCHIVE_DEST_STATE_2 = ENABLED 
Parâmetro LOG ARCHIVE DEST STATE n 
• O estado de um destino de arquivamento pode ser modificado dinamicamente. Por default um destino para arquivamento tem o estado de ENABLE, indicando que o Oracle Server pode utilizar este destino. O estado de arquivamento para um determinado destino pode ser modificado setando o correspondente parâmetro LOG_ARCHIVE DESTSTATE n. Por exemplo, para parar o arquivamento para um destino obrigatório temporariamente quando um erro ocorre, o estado deste destino pode ser setado para DEFER. Um destino pode ser definido, mas setado para DEFER no arquivo de parâmetros. Este destino pode ser habilitado quando algum outro destino tem um erro ou necessita de manutenção. 
Habilitando o Processo Archive Uma vez que o banco de dados tenha sido posto em modo archivelog, o DBA deve decidir se os online redo log files devem ser arquivados automaticamente ou manualmente. Esse é o segundo passo após ter archive logs criados para serem usados em recuperações posteriores. 
Arquivamento Automatico x Arquivamento Manual 
• Com arquivamento automático, o processo background ARCn é habilitado e copia os redo log files a medida que eles são preenchidos. 
• Com arquivamento manual, o DBA deve usar o SQL*PLUS ou o OEM. 
• É recomendado habilitar o arquivamento automático dos log files.

Diretrizes • Antes de decidir se o arquivamento deve ser manual ou automático, o banco deve ser colocado em modo archivelog. 

• Uma falha em trocar para modo archivelog impedirá o ARCn de copiar os redo log files. 
• O banco de dados deve ser desligado normalmente (usando as opções normal, transactional ou immediate) antes de habilitar o processo ARCn. Nota: Se o processo ARCn falhar por qualquer razão, logo que as transações tenham enchido todos os redo logs, o Oracle "trava Isso é proposital, visto que colocar o banco em modo archivelog diz ao Oracle não sobrescreva os online redo log files se não estiverem arquivados". Dessa forma deve ser observado que o arquivamento de redo logs acompanhe as atividades de transação no sistema (geração de redo logs). No Oracle 11g, o parâmetro LOG_ARCHIVE_START foi depreciado. 0 arquivamento automático é habilitado por padrão e o processo de arquivamento é iniciado de acordo com a localização identificada no parâmetro LOG_ARCHIVE_DEST_N. Para realizar o arquivamento manual utilize o parâmetro MANUAL no comando ALTER DATABASE ARCH IVELOG.


Multiplos Processos Archiver 
• O parâmetro dinâmico que controla o número de processos archiver e LOG ARCHIVE MAX PROCESSES. 
Parâmetro LOG ARCHIVE MAX PROCESSES Os comandos DDL (data definition language) e DML (data manipulation language) podem gerar uma quantia grande de operações nos redo logs, principalmente aqueles em paralelo. Um simples processo ARCO pode não conseguir manter o arghivamento destes redo logs. Para resolver este problema, o Oracle inicia processos adicionais de acordo com o necessário. Entretanto, eles podem ser préviamente iniciados para evitar o tempo de carga dos processos quando esses forem requisitados. Isto pode ser feito manualmente ou através da utilização de job queue. 

• O DBA pode definir multiplos processos de arquivamento, utilizando o parâmetro LOG ARCHIVE MAX PROCESSES. 
• Quando o LOG_ARCHIVE START está configurado como TRUE, a instância Oracle inicializa tantos processos archiver quanto foram definidos no parâmetro LOG ARCHIVE MAX PROCESSES. 
• O número máximo de processos arhive permitido é dez (10). 0 valor mínimo é um (1). 
• O DBA pode adicionar ou matar processos archives adicionais durante qualquer momento da vida da instância. 
Parando e Iniciando Processos Archive Adicionais 
Figura: Parando e iniciando processos archive adicionais 
Número Dinâmico de Processos ARCn Durante pesado carga ou atividade transacional, o DBA pode iniciar processos de archives adicionais temporários para, previnir gargalos no trabalho de arquivamento. Quando a atividade transacional diminui, voltando ao normal, o- DBA pode parar alguns processos ARCn. Por Exemplo: Todos os dias do mês, o banco de dados inicia com dois processos archive. Durante o último dia do mês, ocorre um acréscimo nas atividades: Após este dia, se o banco de dados não foi desligado, o DBA pode através de comando SQL parar o processo archive adicional:

SQL> ALTER SYSTEM SET LOa ARCHIVE_MAX_PROCESSES-3 
Nota: Se o banco de dados foi desligado durante a noite, no outro dia será inicializado somente com dois processos archive, como está configurado no arquivo de parâmetros. 

SQL> ALTER SYSTEM SET LOG ARCHIVE_MAX_PROCESSES=2 
Obtendo Informações sobre Archived Log Visões Dinâmicas Você pode gerenciar e ver os arquivos de log usando as visões do dicionário de dados. 
• V$ARCHIVED LOG: mostra informações do control file sobre arquivamento de log. 
• V$ARCHIVE DEST: descreve para a instância corrente, todos os destinos de archive log, o valor corrente, modo e status. 
SQL> SELECT destination, binding, target, status FROM v$archive dust; 
DESTINATION BINDING TARGET STATUS --------------------- ----------- -------- -------- /dbl/oracle/DEMO/arch MANDATORY PRIMARY VALID /dbl/oracle/DEMO/arch2 OPTIONAL PRIMARY DEFERRED standbyDEMO OPTIONAL STANDBY ERROR OPTIONAL PRIMARY INACTIVE OPTIONAL PRIMARY INACTIVE 

Nota: A consulta mostra dez (10) linhas, onde a informação representa possíveis destinos. O status de INACTIVE indica quais os destinos não estão definidos. Um status VALID indica os destinos habilitados :e livres de erros. Para checar os erros e o número de sequencia dos logs no qual o erro aconteceu para cada destino, utilize a seguinte consulta: 
• V$LOG_HISTORY: contém informação de log file do control file. 
• V$DATABASE: estado corrente de arquivamento.
• V$ARCHIVE_PROCESSES: prove informações sobre o estado de vários processos ARCn para a instância 
SQL> SELECT FROM v$archive_processes; 


Uma lista dos 10 possíveis processos archive é exibida. Um status de ACTIVE indica que o processo está iniciado e rodando. Um processo está arquivando quando o status indica BUSY. A coluna LOG SEQUENCE para o processo com status BUSY apresenta o número de seqüência do log que está sendo arquivado. 

Informação Sobre Archive Log O comando ARCHIVE LOG LIST fornece ao DBA informação sobre o modo e status de arquivamento de um banco: 
Informação Descrição Database log mode - Modo corrente de arquivamento Automatic archival Estado do processo opcional Archiver 
Archive destination 
Destino para o qual log files serão copiados (tanto manualmente quanto automaticamente). Mostra somente 1 destino. Oldest online log sequence Número de seqüência do online loq mais antiqo. 
Next log sequence to archive 
próximo redo log a ser arquivado (mostrado somente em modo archivelog). Current log sequence Número de seqüência do log file corrente. Tabela:Informações do comando archive log list 
Configurando o Recovery 
Fatores que Influenciam no Tempo de Recovery 
• Fast-start recovery possui uma boa estimativa de tempo de recuperação 
• O Recovery pode levar muito tempo devido: O Checkpoint só ocorrer em um intervalo de tempo específico. Atividades de recovery adicional como ler os logs não são considerados. O tempo recovery pode ser mais rápido se utilizado o parallel recovery. 


Tempo de Recovery e Parametro 
FAST START MTTR TARGET Devemos atingir um balanço entre a duração do processo de crash (ou instance) recovery e o desempenho geral do banco de dados. O tempo de recovery pode ser determinado utilizando-se o parâmetro FAST_START_MTTR_TARGET, mas é somente um tempo desejado, e não há nenhuma garantia de que será cumprido pelo banco. Os blocos no cache podem ter ficado sujos desde o último checkpoint. O tempo de cálculo também não leva em conta outras atividades do recovery como a leitura dos arquivos de redo log files, e o remastering lock. Entretanto estas atividades normalmente representam menos de 5% dos atividades do recovery. O atual lapso do tempo para recovery pode ser menor, especialmente se o recovery paralelo for utilizado. 
Defina o parâmetro FAST START_MTTRTARGET baseado em: 
• Tempo desejado de recuperação do banco. 
• Coluna AVGIOTIM de V$FILESTAT. Confira o impacto desse parâmetro em V$INSTANCE_RECOVERY.