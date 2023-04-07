Arquitetura Básica Oracle 

Visão Geral O Oracle utiliza muitos componentes de memória, processos background e estruturas de arquivos em seu mecanismo de backup e recovery. 

Uma instância Oracle consiste de áreas de memória (principalmente da SGA - System Global Area) e processos background (PMON, SMON, DBWn, LGWR e CKPT). Uma instância é criada durante o estágio nomount do processo de startup do banco, após o arquivo de parâmetros ser lido. Se qualquer desses processos terminar, a instância sofre shutdown. Enquanto os cinco processos citados são essenciais para o startup de uma instância, para operacionalizar uma instância alguns processos mais são necessários, tais como o processo usuário e o processo servidor. 

Estruturas de Memória Tipo Descrição Data buffer coche Área de memória usada para armazenar blocos lidos dos datafiles. Dados são lidos nos blocos pelo processo servidor e escritos pelo DBWn de forma assíncrona. Log buffer Memória contendo cópias before image e after image dos dados alterados a serem gravados nos redo logs. Large pool Uma área de memória opcional usada para I/O pelo RMAN (Recovery Manager). É discutido adiante neste capítulo. Shared pool Armazena versões compiladas de comandos SQL, rotinas PLJSQL e informação do dicionário de dados. 
Processos Background Tipo Descrição Database Writer (DBWn) Escreve buffers sujos do database buffer cache para os data files. Funciona de forma assíncrona. Log writer (LGWR) Escreve dados do log buffer para os redo log files. 

System Monitor (SMON) 
Executa recuperação automática do instância. Recupera espaço em segmentos temporários quando eles não estão mais em uso. Agrupa áreas contíguas de espaço livre, dependendo de valores de parâmetros. 

Process Monitor (PMON) 
Encerra a comunicação e o processo servidor dedicado a um processo usuário terminado de forma anormal. Executa rollback e libera recursos mantidos pelo processo encerrado. 

Checkpoint (CKPT) 
Sincroniza os headers dos data files e control files com os números correntes de redo log e checkpoint. 
Archiver (ARCn) (opcional) 
Um processo opcional que, quando habilitado, copia automaticamente redo logs que tenham sido marcados para arquivamento. 
Processo do Usuário Esse processo é criado quando um usuário inicia uma ferramenta como o SQL*Plus, Forms, Reports, Enterprise Manager, ou qualquer outra que estabeleça uma conexão com o banco de dados. Esse processo pode estar no cliente ou no servidor, e fornece uma interface para o usuário entrar comandos que interajam com o banco de dados. 
Processo Servidor Esse processo aceita comandos do processo usuário e executa passos para completar as requisições do usuário. Se o banco de dados não está configurado para o uso de Shared Servers, um processo servidor é criado na máquina que contém a instância quando uma conexão válida for estabelecida. 


Banco de Dados Oracle Tipo de Arquivo

 
Data files 
Armazenamento físico de dados (incluindo índices). Pelo menos um arquivo é necessário para armazenar a tablespace SYSTEM.

Redo logs
Contém cópias de before image e after image de dados alterados, para possível recuperação. Pelo menos dois grupos com um arquivo cada são necessários.

Binário 
Control files Registra a estrutura física e o status do banco de dados. Binário Arquivo de parâmetros Armazena parâmetros necessários para o startup do banco. (init) Texto Arquivo de parâmetros binário Armazena parâmetros persistentes para o startup do banco. (spfile) Binário Password file (opcional) Armazena informações sobre usuários que podem iniciar, encerrar e recuperar o banco de dados. Binário Archive logs (opcional) Cópias físicas dos redo logs. Criados quando o banco de dados está configurado para Achivelog Mode. Usado na recuperação. Binário Arquivos físicos do Oracle 
Visões Dinâmicas O Oracle fornece um número de visões padrão do dicionário de dados para disponibilizar informações sobre o banco e a instância. Algumas das quais são: 
• V$SGA: informa o tamanho da instância para o shared pool, log buffer, data buffer cache e tamanhos fixos de memória (depende do sistema operacional). 
• V$INSTANCE: informa o status do instância, tal como seu nome, seu modo, tempo de abertura (startup time) e nome do host. 
• V$PROCESS: fornece os processos background e de servidor criados para a instância. 
• V$BGPROCESS: processos background criados para a instância 
• V$DATABASE lista informações de status e recuperação sobre o banco de dados. Isso inclui informações do nome do banco, identificador único do banco, data de criação, data e hora de criação do control file, último checkpoint do banco, entre outras informações. • V$DATAFILE: lista a localização e os nomes dos data files que compõe o banco de dados. Isso inclui informação referentes ao número e nome do data file, data de criação, status (online/offline), status de habilitação (read-only, read-write), último checkpoint de data file, entre outras informações. 
• V$BACKUP: lista o status de backup de todos os online datafiles. 

Large Pool A Large Pool é uma parte da SGA usada para alocar buffers de I/O seqüenciais a partir da memória compartilhada. 0 RDBMS aloca buffers com algumas centenas de Kbytes para I/O slaves e para backup e restore do Oracle,. 
O Recover Manager (RMAN) usa a large pool para simular operações de I/O assíncrono em operações de backup e restore, se forem configurados os parâmetros DBWR_IO_SLAVES ou BACKUP_TAPE_IO SLAVES. Caso eles não sejam configurados, o RMAN alota memória do processo local, possivelmente competindo com outros processos em execução.

Dimensionando a Large Pool 
Se o parâmetro de inicialização LARGE_POOL_SIZE não for especificado, o Oracle tenta alocar buffers de memória compartilhada da shared pool na SGA. Se o parâmetro for especificado, porém com tamanho insuficiente, a alocação falha e- o componente Oracle requisitando os buffers segue o seguinte comportamento: 
• 0 arquivamento de log falha e retoma um erro. 
• 0 comando RMAN grava uma mensagem no arquivo de alerta e não utiliza I/O Slaves para essa operação.


Parâmetros de Large Pool 
• LARGE POOL_SIZE: se esse parâmetro não for especificado, então não há um large pool. 0 tamanho de memória especificado é alocado a partir da SGA. Descrição: 0 tamanho da Large Pool é mensurado em bytes (pode ser especificado em K ou M) Mínimo: 300k Máximo: pelo menos 2 GB (o tamanho máximo depende do sistema operacional) Para determinar como a Large Pool está sendo usada consulte a V$SGASTAT (WHERE pool='large pool'). 
• DBWR_lO_SLAVES: Este parâmetro especifica o número de I/O slaves usados pelo processo DBWn. 0 processo DBWn e seus escravos (slaves) sempre escrevem no disco. Por default o valor é zero, e os processos escravos não são utilizados. 

Se o DBWR_IO_SLAVES é configurado diferente de zero, o número de processos escravos (I/O slaves) utilizados pelo processos ARCn, LGWR e Recovery Manager é configurado para 4. Tipicamente são usados I/O slaves para simular I/O assíncrono em plataformas que não suportam I/O assíncrono ou implementam isto ineficientemente. Porém, podem ser usados I/O slaves até mesmo quando I/O assíncrono está sendo utilizado. Neste caso, os processos escravos usarão I/O assíncrono.


• BACKUP_TAPE 10_SLAVES: Este parâmetro especifica os processos escravos que serão usados no Recovery Manager para backup, cópia ou restauração de dados da fita. Quando o parâmetro BACKUP_TAPE _IO_SLAVES for TRUE, um I/O Slave é usado para I/O assíncrono quando estiver lendo ou escrevendo para fita . Se este parâmetro for configurado para FALSE (default), então I/O slaves não serão usados para backups; ao invés disso, o processo shadow do backup terá acesso a fita. Nota: Pelo fato de um dispositivo de fita só poder ser acessado através de um processo a cada momento, este parâmetro é boleano e permite ou não a aplicação de um processo de I/O escravo para acesso a um dispositivo de fita. Para executar backup duplexado, este parâmetro precisa ser habilitado, caso contrário um erro será sinalizado. 0 Recovery Manager irá configurar tantos slaves quanto forem necessários para o número de cópias de backup requisitadas quando este parâmetro estiver habilitado. 

Data Buffer Cache, DBWn e Data Files 

Data Buffer Chuche, DBWn e Data Files 
Funções do Data Buffer Cache • 0 Data Buffer Cache é uma área da SGA utilizada para guardar os blocos de dados mais recentemente utilizados. 
• O processo servidor efetua a leitura das tabelas, índices e segmentos de rollback dos data files para o buffer cache, e efetua mudanças nos blocos de dados quando requerido. 
• O Servidor Oracle utiliza uma lista chamada LRU (least recently used) gerenciada por um algorítimo que determina qual bloco pode ser escrito e acomoda os novos blocos no buffer cache. 
Funções do DBWn Background Process 
• O processo DBWn (database writer) escreve os "dirty buffers" do database buffer cache para os datafiles. Assim ele assegura um número suficiente de buffers livres - os buffers que podem ser sobrescritos quando o processo servidor precisa ler novos blocos dos datafiles - estejam disponíveis no database buffer cache. 
• O database writer regularmente sincroniza o database buffer cache e os data files: isto é o evento de checkpoint disparado em várias situações. 


• Embora um DBWn seja adequado para a maioria dos sistemas, você pode configurar processos adicionais. Isto melhora o desempenho de escrita quando seu sistema modificar dados de modo intenso. Estes DBWn adicionais não são úteis em sistemas com um único processador. 
Data Files Os Data files armazenam os dados dos usuários em disco. Estes dados podem ser comitados ou não comitados. 
Data Files Contendo Somente Dados Comitados Isto é normal em um banco de dados fechado. Exceto quando ocorreu uma falha ou a opção "shutdown abort" foi utilizada. Se para fechar a instância foi utilizado um shutdown normal, immediate ou transactional, os datafiles contém somente dados comitados. Isto ocorre porque nestes tipos de shutdown todo dado não comitado sofre um rollback e um check point é disparado para forçar que todos os dados comitados sejam escritos no disco. 
Data Files Contendo Dados Não Comitados Quando a instância está rodando (o banco de dados está aberto) os data files podem conter dados não comitados. Isto acontece quando dados são modificados, porém não são comitados (os dados estão agora no cache) e é necessário mais espaço no cache (os dados não comitados são forçados a serem escritos para o disco). Somente quando eventualmente todos os usuários comitarem as suas transações é que os datafiles irão conter somente dados comitados. Em caso de uma falha, durante um subseqüente recovery o redo log e o segmento de rollback serão utilizados para sincronizar os data files. 
Configurando Tablespaces Tablespaces contém um ou mais_ datafiles. É importante que as tablespaces criadas forneçam flexibilidade na estratégia de backup e recovery. Abaixo segue alguns exemplos de tablespaces: 
• SYSTEM: 0 backup e o recovery tornam-se mais flexíveis se os dados do sistema e os dados dos usuários estiverem contidos em diferentes tablespaces. SYSAUX: Toblespace auxiliar que contém os dados do sistema que não são armazenados na talespace system, entretando a perda desta tablespace não resultará num crash do banco, o que será perdido serão os dados armazenados nela. 

• TEMPORARY: Se a tablespace que contém segmentos temporários (usados para sort e outras operações) é perdida, você pode recriá-la em vez de recuperá-la. 
• UNDO: Os procedimentos para backup de tablespaces de undo são os mesmos das demais tablespaces de leitura e escrita. Sendo este tipo de tablespace tão importante para leitura consistente e recovery, você deveria fazer backups freqüentes das tablespaces de undo. 
• DADOS READ ONLY: O tempo de backup pode ser reduzido quando uma tablespace necessita apenas de um backup, pois é uma tablespace read-only. 
• DADOS ALTAMENTE VOLÁTEIS (highly volatile data): Esta tablespace pode sofrer o backup com mais freqüência, também reduzindo o tempo de recovery. 
• ÍNDICES (index data): Tablespaces que armazenam somente segmentos de índices podem ser recriadas ao invés de serem recuperadas. 

Redo Log Buffer, LGWR e Redo Log Files 

Funções do Redo Log Buffer 

• O redo log buffer é um buffer circular que armazena as informações sobre as mudanças sofridas pelo banco dados. Estas informações são armazenadas em entradas de redo. 
• Entradas, ou registros, de Redo contém a informação necessária para reconstruir, ou refazer, as mudanças efetuadas no banco de dados por operações de INSERT, UPDATE, DELETE, CREATE, ALTER ou DROP. Redo entries são utilizadas para recovery do banco de dados se necessário. Redo entries são copiadas pelo Processo Servidor Oracle do espaço de memona do usuário para o redo log buffer. 
Funções do Processo Background LGWR O LGWR (log writer) escreve os redo entries no redo log files que foi copiado no redo log buffer e por fim escreve novamente nos redo log files, isto ocorre: 
• Quando o redo log buffer está mais de um terço cheio 
• Quando ocorreu um timeout (a cada três segundos) 
• Antes do DBWn escreva os dados modificados do database buffer cache files. • Quando as transações são comitadas. 
Redo Log Files Os Redo log files armazenam todas as modificações feitas no banco de dados. Se o banco de dados precisar ser recuperado até um determinado momento, ou até um determinado ponto onde era operacional, os redo logs são usados para assegurar que todas as tranzações comitadas estejam gravadas em disco, e todas as transações não comitadas sejam desfeitas (rollback). Os pontos importantes relativos a redo logs seguem abaixo: 
• O LGWR escreve os redo log files de forma circular. Este comportamento resulta que todos os membros de um grupo de logfiles sejam sobrescritos. • Apesar de ser obrigatório ter dois grupos de redo log files para suportar sua natureza cíclica, em muitos casos, você terá necessidade de especificar mais do que dois grupos de redo logs. Você pode criar grupos adicionais de log files utilizando comandos SQL: Você pode apagar grupos de redo log files utilizando o seguinte comando SQL: 

• Para evitar problemas de perda de mídia é recomendável que seja feita a multiplexação (espelhamento) dos redo logs. 
Redo Log Switches A cada log switch, o grupo corrente de redo log é identificado com um número de sequência. Essa informação é salva no gupo de redo log e também é usada para sincronização. 
• O log switch ocorre quando o LGWR para de escrever em um determinado grupo de redo log e começa °a escrever em outro. 
• O log switch ocorre quando LGWR encheu um grupo de redo log files. 
• O DBA pode forçar um switch usando o comando ALTER SYSTEM SWITCH LOGFILE. 
• Um checkpoint automatico ocorre a cada log switch. 
• O processamento pode continuar contanto que pelo menos um membro do grupo esteja disponível. Se um membro é danificado ou está indisponível, mensagens são escritas nos arquivos de trace do LGWR e no arquivo de alerta. 

Visões Dinâmicas 
• V$LOG: Lista o número de membros em um grupo. Contém: 
• O número do grupo 
• O número de sequência corrente do log 
• O tamanho do grupo 
• O número de espelhamentos (membros) 
• O Status ( CURRENT ou INACTIVE) • 0 número de mudança de checkpoint 

• O status (ACTIVE, CLEARING, CLEARING CURRENT, CURRENT, INACTIVE, UNUSED) 
• V$LOGFILE: Lista o nome, status (STALE ou INVALID), e o grupo de coda log file. 
• V$LOG_HISTORY: Contém informações do control file sobre o histórico de logs. 

Multiplexação dos Redo Log Files Diretrizes para Multiplexaçáo (espelhamento) 
A configuração dos redo log files requer no mínimo dois membros de log por grupo, com cada membro guardado em um disco diferente para evitar perda em caso de falhas. A localização dos redo log files online podem ser mudadas, mudando-se o nome dos redo log files online. Antes de mencionar o novo nome do redo log files, tenha certeza que o mesmo exista na nova localização. 0 servidor Oracle muda somente os ponteiros dentro dos control files, porém não remove, renomeia ou cria fisicamente qualquer arquivo no sistema operacional Se o arquivo antigo for um arquivo gerenciado pelo Oracle (OMF), e ele ainda existir, então ele será removido. 
ALTER SYSTEM SWITCH LOGFILE; 

Como Realocar um Redo Log File 

1. Se o log file é o corrente, execute um log switch utilizando: 

2. Copie o redo log file da sua localização anterior para a sua nova localização utilizando comandos do sistema operacional (cp no UNIX/Linux ou copy no Windows). 
ALTER DATABASE [database] RENAME FILE 'filename'[,'filename']... TO filename[, 'filename']... 
comandos do sistema operacional (cp no UNIX/Linux ou copy no Windows). 

3. Use o comando ALTER DATABASE RENAME FILE para efetuar as mudanças no control file: 
Como Funcionam Arquivos de Redo Log Multiplexados 
• Todos os membros do grupo possuem a mesma informação e devem ser do mesmo tamanho. • Os membros de um mesmo grupo são modificados simultãneamente. • Cada grupo deveria conter o mesmo número de membros, e do mesmo tamanho 
Também é possível criar um novo membro em um grupo e depois remover o antigo. Para adicionar um; membro a um grupo: 
ALTER DATABASE [database] ADD LOGFILE MEMBER [filename' [REUSE] [,'filename' [REUSE]...]] TO (GROUP nj ('filename'[, 'filename-]...)}]..


Como Remover um Membro de um Grupo


ALTER DATABASE [database] DROP LOGFILE MEMBER 'filename' [, 'filename']... 
Você pode remover um membro de um grupo de redo log online, se este estiver com status INVALID. Use o comando: Nota: Não é possível remover um membro de um grupo de redo log corrente ou ativo. 
Checkpoint Checkpoints são sinalizadores usados para indicar em que ponto dos redo log files o processo de recuperação deve iniciar a leitura de seus blocos, no caso de falha da instância. Todos os blocos de redo anteriores ao último checkpoint já foram gravados com sucesso pelo DBWn nos datafiles. Checkpoints agem ainda como um marcas de sincronia entre os datafiles e control files. Se eles possuem o mesmo número de checkpoint, então o banco está em um estado considerado "consistente". 

Checkpoints sincronizam também a operação de escrita entre o LGWR e o DBWR. 

Checkpoint Queue Os blocos de dados presentes no Database Buffer Cache que foram alterados, chamados Dirty Blocks, necessitam ser gravados nos datafiles pelo DBWn, e são listados em uma fila, chamada Checkpoint Queue. Cada registro dessa fila inclui o número do arquivo e número do bloco desse arquivo, a posição no redo log file da primeira alteração desse bloco (chamado Redo Byte Address, ou RBA), e a posição do última alteração desse bloco. A fila está ordenado por data de alteração, ou seja, o primeiro da fila é o bloco alterado a mais tempo. 0 DBWn grava os dirty blocks pela ordem da fila e remove o registro dessa após essa gravação. 
Tipos de Checkpoint e suas Freqüências Existem 3 tipos de checkpoint, cada um ocorrendo em determinadas situações: 
• Full Checkpoint Ocorre quando é feito um shutdown (de qualquer tipo exceto abort) ou pela execução do comando 'ALTER SYSTEM CHECKPOINT'. Nesse tipo de checkpoint todos os dirty buffer são gravados nos datafiles. Causa a atualização dos cabeçalhos dos datafiles bem como dos control files. 
• Incremental Checkpoint Tipo mais freqüente. Ocorre de acordo com a configuração de parâmetros (ver adiante nesse capítulo), fazendo com que o DBWn escreva os dirty blocks mais antigos nos datafiles e avançando o sinalizador de início de recuperação de instância. Checkpoint incrementais não atualizam cabeçalhos de datafiles, apenas de control files, evitando uma sobrecarga de escrita. 
• Partial Checkpoint Ocorrem quando executados alguns comandos DDL, tais como: - ALTER TABLESPACE ... BEGIN BACKUP - ALTER TABLESPACE... OFFLINE NORMAL - ALTER TABLESCPACE ... READ ONLY 


- DROP TABLESPACE ... 
Esse checkpoint são usados para escrever todos os dirty blocks relativos à tablespace referenciada no comando, de forma que ela possa mudar para os estados de backup, offline, read only, etc. 

Processo CKPT 
Características do CKPT 
• O processo CKPT está sempre habilitado. 
• O processo CKPT,atualiza headers de arquivos no momento do término do checkpoint. 
• Checkpoint mais freqüentes reduzem o tempo de recuperação para falhas de instância com uma possível redução de performance. A frequencia com que o processo CKPT gera checkpoints incrementais deve ser configurado de forma a "haver um balanceamento entre desempenho geral do banco e desempenho, do processo de recuperação (instance recovery)."


A geração muito freqüente de checkpoints diminui o desempenho geral do servidor, porém acelera o processo' de recuperação', pois haverão menos blocos a serem lidos entre o último checkpoint e o final do redo log file. Por outro lado, checkpoints muito esporádicos melhoram o desempenho geral do banco, mais podem deixar muitos blocos para serem lidos, conseqüentemente muitas operações a serem reconstruídas, durante o processo de recovery, atrasando mais a abertura do banco de dados após uma falha de instância. 
Parãmetros de Configuração para Checkpoints Existem quatro parâmetros de inicialização que você pode usar para configurar a freqüência de ocorrência de checkpoints. 


FAST_START MTTRTARGET 
Tempo estimado, em segundos, para duração da fase de roll foward do processo de recuperação. Seu uso é recomendado em substituição à combinação dos parâmetros seguintes. 

LOG CHECKPOINT INTERVAL
Número de blocos de redo que podem existir entre um checkpoint incremental e o último bloco do redo log file. 

LOG CHECKPOINT TIMEOUT
Intervalo máximo de tempo, em segundos, desde o último checkpoint incremental. 

FAST START 10 TARGET  
Número de máximo de operações de E/S (para leitura e escrita) permitidas em caso de falha. Parâmetros de configuração para checkpoints 

Checkpoints ocorrem ainda em duas outras situações: 
• A cada log switch (não pode ser suprimido). 
• 90% do tamanho do menor log file: o próximo redo log group não é utilizado até que o checkpoint tenha sido gerado no final do redo log file corrente. Para minimizar a espera pela geração do último chekcpoint a >coda log switch (e conseqüente gravação dos dados), o Oracle garante que pelo menos um checkpoint seja colocado a não mais do que 90% do tamanho do menor log file. Quanto menor o tamanho do menor redo log, mais agressivamente o servidor Oracle escreve os dirty buffers para o disco, assegurando que o checkpoint avance no log atual antes de estarem completamente preenchidos. O tamanho do redo log pode ser verificado na coluna LOG_FILE _SIZE _REDO _BLKS da visão dinâmica V$INSTANCE_RECOVERY. Este valor mostrado refere-se ao redo log online de menor tamanho afetado pelo checkpoint. 

Aumentando e diminuindo o tamanho dos seus redo logs online, indiretamente você influência a frequência de escrita do checkpoint. 0 database writer considera todos estes fatores como aplicáveis, e utiliza o ponto mais agressivo como o- alvo para o posicionamento do checkpoint. Escolhendo o ponto mais próximo do final do redo log baseado nestes fatores, todos os critérios definidos são satisfeitos. A visão V$INSTANCE_RECOVERY pode ser usado para visualizar as configurações atuais dos parâmetros relativos a checkpoint. 
V$INSTANCE RECOVERY  

RECOVERY_EDTIMATED_IOS 
Número de dirty buffers no db. Buffer cache (Enterpreise Edition apenas). 

ACTUAL_REDO_BLKS Número atual de blocos do redo log a serem lidos para fazer o recovery. 

TARGET _REDO _BLKS Número máximo desejado de blocos do redo log a serem processados durante o recovery. E o menor valor entre os parâmetros 

LOG_FILE _SIZE _REDO_BLKS, LOG_CHKPT_TIMEOUT_REDO _BLKS e LOG CHKPT INTERVAL REDO BLKS. 

LOG_FILE_SIZE_REDO_BLKS 
Número de blocos de redo correspondente a 90% do menor redo log file. 

LOG_CHKPT_TIMEOUT_REDO_BLKS 
Número de blocos de redo a serem processados no recovery para atender a 

LOG CHECKPOINT TIMEOUT. LOG_CHKPT_INTERVAL_REDO_BLKS Número de blocos de redo a serem processados no recovery para atender a LOG CHECKPOINT INTERVAL. 

FAST START 10 TARGET REDO BLKS 
Sempre NULL. Mantido por compatibilidade. 

TARGET_MTTR 
Tempo médio desejado em segundos, para a duração do recovery.O ideal é que seja igual ao parâmetro FAST _START _MTTR_TARGET. Se este for tão baixo que seja impossível fazer o recovery em tão pouco tempo, então TARGET _MTTR será maior que FAST START MTTR_TARGET e será o tempo efetivo de recovery. Se FAST START _MTTR_TARGET for tão alto que seja impossível que o recovery demore tanto, então TARGET MTTR será o tempo efetivo do recovery para o pior caso. Este campo vale 0 se FAST START MTTR TARGET não for definido. 
ESTIMATED_MTTR Tempo médio estimado atual, em segundos, para a duração do recovery baseado no número de dirty buffer e blocos de redo log (mesmo que FAST START MTTR TARGET não esteja definido). CKPT BLOCK WRITES Número de blocos escritos por checkpoints escritos. 

Sincronização 

• A cada checkpoint incremental, o número do checkpoint é atualizado em cada cabeçalho de control file. A cada checkpoint full ou log switch, o número do checkpoint é atualizado também em cada cabeçalho de datafiles (mas NÃO força a escrita dos dirty buffers). 
• O número de checkpoint age como uma marca de sincronia para os data files, redo log files e control files. Se eles possuem o mesmo número de checkpoint, então o banco está em um estado considerado "consistente". 
• O control file confirma que todos os arquivos estejam com o mesmo número de checkpoint durante o startup do banco. Qualquer inconsistência entre números de checkpoint dos vários cabeçalhos de arquivos resulta em falha, e o banco não pode ser aberto. Nesse momento, o recovery é necessário. Nota: o parâmetro de inicialização LOG_CHECKPOINTS_TO_ALERT = TRUE, faz com que cada checkpoint seja registrado no arquivo de alerta, e pode ser usado para determinar se checkpoints estão ocorrendo com a freqüência desejada. 


Control Files 

Função dos Control Files O control file é um pequeno arquivo binário que descreve a estrutura do banco de dados. Ele deve estar disponível para gravação pelo servidor Oracle sempre que o banco de dados estiver montado ou aberto e seu nome default depende do sistema operacional. Sem este arquivo o banco de dados não pode ser montado, e sua recuperação será necessária. Recomenda-se multiplexar esse arquivo com pelo menos mais uma cópia (ver adiante). 
Propriedades do Control File O control file armazena 
• A localização e nome de todos os data files e redo log files 
• O nome do banco de dados 
• A data do criação do banco (time stamp) 
• Informação de sincronia (checkpoint e seqüência de log) necessárias para recuperação 
• Configuração de arquivamento (archive mode) Outras propriedades: 
• A configuração mínima recomendada é de dois control files em discos diferentes. 
• O control file é necessário para montar, abrir, e manter o banco. 
• Informações extras de backup são armazenadas quando for utilizado o Recovery Manager (RMAN metadata). 
Visão Dinâmica Para obter a localização e os nomes dos control files, utilize a visão de performance dinâmica V$PARAMETER ou V$CONTROLFILE. 

Como Multiplexar o Control File Para adicionar um novo control file ou modificar o número ou localização do control file, siga estes passos: 
1. Efetue o shutdown do banco de dados. 
2. Faça uma cópia do control file existente para um dispositivo diferente utilizando comandos do sistema operacional. 
3. Edite ou adicione o parâmetro CONTROL_FILES e especifique os nomes para todos os control files. 
4. Inicie o banco de dados. 

Processos ARCn e Archived Log Files 
Função do Processo Background de Archive Os processos ARCn são processos opcionais. Quando habilitados, arquivam os redo log files para uma área de armazenamento especificada. Esse processo é muito importante para o backup, restauração e recuperação de um banco configurado em modo Archivelog, que permanece operacional vinte e quatro horas por dia, sete dias por semana. 
Os procesos ARCn são disparados quando ocorre um log switch, e copiam um membro do último redo log group (não arquivado) para pelo menos um dos destinos especificados por alguns parâmetros do init.ora. 
Archived Log Files 
Quando o banco de dados está configurado para o modo Archivelog, o processo LGWR verifica se um redo log file foi arquivado (por um processo ARCn ou manualmente) antes de reutilizar o arquivo de log. Se um online redo log file estiver corrompido, outro membro do mesmo grupo é utilizado. Archived logs são benéficos para o processo de backup e recovery porque: 

• Um backup do banco de dados, combinado com archived log files, garante que todos os dados comitados possam ser recuperados até o ponto da falha. 
• Backup válidos do banco de dados podem ser efetuados com o banco de dados online. 
Considerações Arquivamento 
A escolha para habilitar o archive ou não depende dos requisitos de disponibilidade e confiabilidade de cada banco de dados. Archive logs podem ser armazenados em mais de uma localização (duplexação ou múltiplos destinos), uma vez que são vitais para o recovery. Para bancos de dados de produção, é recomendado que você utilize a característica de archive log com múltiplos destinos. 

LOG_ARCHIVE_MAX_PROCESSES = n 
O Oracle irá iniciar o número de processos especificados em LOG ARCHIVE MAX PROCESSES. 
Em muitos ambientes um único processo ARCn é suficiente para arquivar todos redo log files a medida em que esses vão sendo preenchidos e log switches vão ocorrendo. Entretando, em ambientes com grandes quantidades de transações e comandos DDL e DML executados em paralelo, grandes quantidades de registros em redo logs são geradas. Nesses caso um único processo ARCn pode não
conseguir suprir a demanda, e se tornar um gargalo. 

O Oracle irá então iniciar novos processos de acordo com o necessário. 
Para evitar esse trabalho extra ao servidor, o DBA pode especificar o número de processos a serem instanciados quando o banco de dados for aberto. Até 10 processos podem ser carregados como parâmetro LOG ARCHIVE MAX_PROCESSES. ALTER SYSTEM SET LOG-ARCHIVE-MAX-PROCESSES = n; 
O DBA pode iniciar ou parar processos ARCn adicionais, de acordo com a carga de trabalho do servidor. Para isso, altere o parâmetro dinamicamente com o comando: 
Múltiplos Destinos de Arquivamento Existem duas formas de especificar múltiplos destinos de arquivamento para uma instância: 
• Permitir que um DBA especifique tanto localizações remotas quanto locais para receber archived log files. Opcionalmente, os destinos podem ser especificados como requeridos ou desejáveis. Se um destino remoto for especificado para arquivamento, um novo processo, o remote file server (RFS), recebe o arquivo no site remoto e o armazena no diretório especificado. 
• Especificar somente destinos locais. 
Categorias de Falhas Diferentes tipos de falhas podem ocorrer em um ambiente de banco de dados Oracle. Esses tipos incluem: 
• Falha de comando. 
• Falha de processo usuário. 
• Erro do usuário. 
• Falha da instância.
• Falha de mídia. 
Cada tipo de falha requer um nível variável de envolvimento do DBA para o banco ser efetivamente recuperado dessa situação. Em alguns casos, o recovery é independente de acordo com a estratégia de backup implementada. 

Causas Comuns de Falhas de Comando Falhas de comando ocorrem quando existe uma falha lógica no tratamento de um comando em um programa Oracle. Tipos de falhas de comando incluem: 
• Existe um erro de lógica na aplicação. 
• O usuário tentou entrar com dados inválidos na tabela, talvez violando uma constraint de integridade.
• O usuário tentou realizar uma operação com privilégios insuficientes, tal como um INSERT em uma tabela na qual possua apenas o privilégio de SELECT. 
• O usuário tentou criar uma tabela mas excedeu o limite de sua quota. 
• O usuário tentou um INSERT ou UPDATE em uma tabela, causando a tentativa de alocação de uma nova extensão, porém com espaço insuficiente na tablespace. Nota: quando uma falha de comando ocorre, é provável que o servidor Oracle ou o sistema operacional retorne um código e uma mensagem de erro. O comando SQL inválido é automaticamente desfeito (rollback), e o controle é retornado ao programa do usuário. 0 desenvolvedor da aplicação ou o DBA podem usar o código de erro Oracle para diagnosticar e resolver a falha. 
Soluções para Falhas de Comandos O grau de intervenção do DBA para falhas de comandos irá variar dependendo da falha: 
• Conserte a aplicação de modo que o fluxo lógico ocorra corretamente. Dependendo do ambiente, essa pode ser mais uma tarefa do desenvolvedor do que do DBA. 
• Modifique o comando SQL e execute-o novamente. Essa também seria uma tarefa mais para o desenvolvedor do que para o DBA. 
• O DBA pode ter que providenciar os privilégios de banco necessários para o usuário executor o seu comando corretamente. 
• O DBA pode ter que executor o comando "alter user" para aumentar a quota. 
• O DBA pode ter que adicionar espaço em arquivos para a tablespace. Tecnicamente o DBA deve garantir que isso não aconteça. Entretanto, em alguns casos pode ser necessário adicionar espaço em arquivos. O DBA também pode usar o RESIZE e o AUTOEXTENT para datafiles. 

Causas de Falhas de Processo Usuário Um processo usuário pode falhar por uma série de razões. Entretanto, as causa mais comuns são: • O usuário se desconectou de forma anormal do banco de dados. Por exemplo, um usuário executa um CTRL+ALT+DEL, no Windows, encerrando o SQL*Plus, enquanto estava conectado com um banco em uma configuração cliente-servidor. 
• A sessão do usuário foi encerrada de forma anormal. Uma situação possível é de o usuário reiniciar o cliente enquanto está conectado com o banco em uma configuração cliente-servidor. 
• O programa do usuário disparou uma exceção de endereço, encerrando a sessão. Isso é comum se a aplicação não trata apropriadamente as exceções quando elas aparecem. Soluções para Falhas de Processo Usuário


Falha de Processo Usuário e Ações do DBA 
Raramente o DBA precisará tomar uma atitude para resolver erros de processo usuário. O processo usuário não pode continuar funcionando, apesar de que processos Oracle e outros processos usuário terão um impacto mínimo no sistema ou em outros usuários. 
Processo Background PMON 
O processo background PMON é normalmente suficiente para "fazer a limpeza" após um processo usuário terminar anormalmente. 
• O processo PMON detecta um processo usuário terminado anormalmente. 
• O processo PMON executa um rollback da transação do processo usuário encerrado anormalmente, e libera quaisquer recursos ou locks que este tenha adquirido. 

SQL> DROP TABLE tclientes; 
SQL> TRUNCATE TABLE tclientes; 
SQL> DELETE FROM tclientes; 
SQL> UPDATE tcontratos SET total SQL> COMMIT; 

Possíveis Falhas por Erro do Usuário 
A intervenção do DBA é normalmente necessária para uma recuperação de erros de usuário. 
Causas Comuns para Falhas por Erro do Usuário 
• O usuário acidentalmente removeu ou truncou uma tabela. 
• O usuário apagou todas as linhas de uma tabela, que eram necessárias. 
• O usuário confirmou dados (commit) mas descobriu um erro nos dados gravados. 

Soluções para Erros de Usuário 

• Treinar os usuários do banco. 
• Fazer recovery de um backup válido. 
• Utilizar o comando de recuperação de objetos removidos.

Minimizando Falhas de Erro do Usuário Uma questão chave em qualquer ambiente de banco de dados e aplicação é garantir que os usuários sejam devidamente treinados e que estejam cientes das implicações sobre disponibilidade e integridade do banco. 
Um DBA deve entender os tipos de aplicações e negócios que podem resultar em perda de dados devido a erros do usuário, e como implementar medidas de recovery, tal como fazer recuperação a partir de um backup válido. Algumas situações de recovery podem ser bem extensivas, tais como recuperar uma instância e um banco até um instante no tempo antes do erro, exportação de dados perdidos, e importação dos dados no banco em que eles foram perdidos. 

Falha de Instancia 
Uma falha de instância pode ocorrer devido a uma série de razões: 
• Uma queda de força torna o servidor indisponível. 
• O servidor fica indisponível devido a uma falha de hardware, tais como falha de CPU ou corrupção de memória, ou quando o sistema operacional "trava". 
• Um dos processos background do Oracle (DBWR, LGWR, PMON, SMON, CKPT) sofre uma falha. O procedimento do DBA para recuperação de falha da instância será: 
• Iniciar a instância com o comando "startup". O servidor Oracle irá se recuperar automaticamente, realizando ambas as fases de roll-foward e rollback. 
• Investigar a causa da falha através do arquivo alert.log e quaisquer outros arquivos de trace gerados durante a falha. 

SQL> connect sys/oracle as sysdba; 
Connected. 
SQL> startup; 
Database opened. 

Recuperação de Falhas de Instância (Crash or Instance Recovery) 
• Nenhuma ação especial do DBA é necessária. 
• Inicie a instância. 
• Aguarde pela notificação do banco de estar aberto. 
• Notifique os usuários. 
• Verifique o arquivo de alerta para obter o motivo da falha. Um recovery de instância restaura o banco de dados ao estado consistente de transações imediatamente anterior à falha da instância. 0 servidor Oracle executa automaticamente, se necessário, o recovery da instância quando o banco é aberto. 

• Nenhuma ação é necessária por parte do DBA. Toda informação de redo necessária é lida pelo processo SMON. Para fazer a recuperação desse tipo de falha, simplesmente reinicie o banco. 
• Após o banco ser reaberto, informe os usuários que qualquer alteração não confirmada deverá ser redigitada. 

Nota: 

• Pode haver um atraso entre a inicialização do banco e o aviso "Database opened.". Isso é devido à fase de roll-foward, que ocorre enquanto o banco é montado. 
• processo- SMON realiza o processo de roll-foward aplicando as mudanças registradas nos online redo log files desde o último checkpoint. 
• processo- de roll-foward recupera dados que não tenham sido gravados nos datafiles, mas que tenham gravados nos online redo log, incluindo o conteúdo dos segmentos de rollback. 
• 0 rollback pode ocorrer enquanto o banco está aberto, visto que tanto o processo SMON quanto o processo servidor podem realizar a operação de rollback. Isso permite que o banco fique disponível para os usuários mais rapidamente. 


Fases do Instance Recovery 

Arquivos Não Sincronizados O Oracle determina se um banco precisa ser recuperado quando arquivos não sincronizados são encontrados. Falha de instância pode causar isso, tal como um shutdown abort. Essa situação causa perda de dados não confirmados, visto que a memória não é gravada em disco e arquivos não são sincronizados antes do shutdown.

Processo Roll-Foward O processo DBWR grava tanto dados confirmados quanto não confirmados nos datafiles. 0 propósito do processo de roll-foword é de aplicar todas as mudanças registradas no log file para os blocos de dados.

Nota: Segmentos de UNDO são gravados durante a fase de roll-foward. Visto que redo logs armazenam imagens dos dados anteriores e posteriores, um registro é feito no segmento de UNDO se um bloco não confirmado é encontrado no datafile sem que exista um registro de rollback. Redo logs são aplicados usando log buffers. Os buffers usados são marcados para recovery e não participam de transações normais até que tenham sido abandonados pelo processo de recovery. - Redo logs só são aplicados a um datafile read-only se existir um conflito de status, ou seja, o cabeçalho do arquivo atesta que ele é um arquivo read-only, apesar do control file reconhecê-lo corno um arquivo read-write, ou vice-versa.

 Dados Confirmados e Não Confirmados em Datafiles Uma vez que a fase de roll-foward tenha sido completada com sucesso, todos os dados confirmados se encontram nos datafiles, apesar de que dados não confirmados ainda possam existir. 0 banco de dados é aberto. 4 Fase de Rollback Para remover os dados não confirmados dos arquivos, segmentos de rollback populados durante a fase de roll-foward são utilizados. Blocos são restaurados (rolled back) quando requisitados, seja pelo servidor Oracle ou por um usuário, dependendo de quem requisita-lo primeiro.


Dados Confirmados em Datafiles Quando ambas as fases de roll-foword e rollback tenham sido completadas, apenas dados 
Causas de Falhas de Mídia Falhas de mídia involvem um problema físico quando da leitura ou gravação em um arquivo necessário para operar o banco de dados. Esse é o tipo mais sério de falha considerando que geralmente requer a intervenção do DBA. 

Tipos Comuns de Problemas Relativos à Mídia 
• O disco que continha um dos arquivos do banco sofreu um problema de "head crash". 
• Existe um problema físico no leitura ou escrita nos arquivos necessários para operações normais do banco. 
• Um arquivo foi acidentalmente apagado. 

Soluções para Falhas de Mídia Uma estratégia testada de backup é o componente chave para resolver problemas com falha de mídia. 

A habilidade do DBA de minimizar o tempo de indisponibilidade do banco e a perda de dados por falha de mídia depende do tipo de backups disponíveis. Portanto uma estratégia de backup depende de: 
• O método de backup escolhido e que arquivos são afetados. 
• Se for usado arquivamento, você pode aplicar archived redo log files para recuperar dados gravados desde o último backup. 
Sincronização do Banco 
Um banco de dados Oracle não pode ser aberto se todos os datafiles, redo logs e control files não estiverem sincronizados. Nesse caso, um recovery é necessário. 
• Para erros de comando ou do usuário, os arquivos devem estar sincronizados. 
• Para falha de instância, a recuperação é feita automaticamente pelo servidor Oracle. 
• Para falhas de mídia, a recuperação necessita de intervenção do DBA. 
Sincronização de Arquivos do Banco de Dados 
• Para o banco poder ser aberto, todos os datafiles devem possuir o mesmo número de checkpoint, a não ser que estejam offline ou sejam parte de urna tablespace "read only". 
• A sincronização de todos os arquivos Oracle é baseada nos números seqüência e de checkpoint do redo log corrente. 
• Archived redo log files e online redo log files recuperam transações confirmadas e desfazem (rollback) transações não confirmadas para sincronizar os arquivos do banco de dados. 
• Archived redo log files e online redo log files são automaticamente requisitados pelo servidor Oracle durante a fase de recovery. Garanta que existem logs nos locais requisitados.