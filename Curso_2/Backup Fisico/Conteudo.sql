Backups Físicos - Conteúdo

Backups Lógicos = um backup lógico de um banco de dados abrange a leitura de um conjunto de linhas do banco de dados e a gravação dessas linhas em um arquivo. Esses registros são lidos independentes de sua localização física. No Oracle, o utilitário Data pump backup faz esse tipo de backup de banco. 
Backup Físico = os backups físicos abrangem a copia dos arquivos que constituem o banco de dados. No Oracle , Há suporte para 2 tipos diferentes de backups físicos : Backups Offline e OnLine ( conhecidos como backups frio e backup quente )

Backup OffLine = ocorrem quando o banco de dados é desligado normalmente usando a opção NORMAL,TRANSACTIONAL ou IMMEDIATE do comando SHUTDOWN. Enquanto o banco estiver offline, os seguintes arquivos devem ser copiados em backup:
Todos os arquivos de dados.
Todos os arquivos de controle
Todos os arquivos de redo log arquivado (Archives)
O arquivo init.ora ou o arquivo de parâmetro do servidor (SPFILE)
Arquivos em formato texto, como o arquivo de senhas e o tnsnames.ora
 

Backup Online = é possível utilizar os backups online em qualquer banco de dados em execução no modo archivelog. Nesse modo os redo logs on line são arquivados, gerando um log de todas as transações ocorridas no banco.
 OBS: O Oracle grava nos arquivos de redo log online, de modo cíclico: após preencher o primeiro arquivo de log, ele começa a gravar no segundo, ate que este esteja também preenchido. Em seguida ele vai para o terceiro, e assim sucessivamente. Quando o ultimo redo log online estiver cheio, o processo em segundo plano Log writer (LGWR), começa a substituir o conteúdo do primeiro arquivo de redo log.

Com o banco de dados aberto é possível fazez backup dos seguintes arquivos:
Todos os arquivos de dados
Todos os arquivos de redo log arquivados
O arquivo de controle, por meio do comando alter database backup controlfile;
O SPFILE
Políticas de retenção:
Todas as copias ou backups extras alem do numero especificado na política de redundância são marcados como OBSOLETE. Como acontece em uma janela de recuperação, os backups obsoletos são automaticamente removidos se o espaço em disco for necessário e se for utilizada a área de recuperação flash.
Por padrão, a política de retenção é uma única copia (com política de retenção definida por 1). Você pode definir essa política com 2 copias ou mais por meio do seguinte comando :
RMAN> configure retention policy to redundancy 2;
A área de recuperação flash, disponível a partir do Oracle 10g, é um local de armazenamento unificado para todos os arquivos relacionados à recuperação em um banco de dados Oracle. Todos os arquivos necessários para recuperar um banco de dados a partir de uma falha de mídia ou de um erro lógico estão contidos na área de recuperação flash.
Arquivo de controle
Arquivos de redo log online
Arquivos de redo log arquivados (archives)
Logs da flashback
Backup automático de arquivos de controle
Copias dos arquivos de dados
Conjuntos de backup do RMAN
Arquivos de RMAN 
Área de recuperação Flash = alem de receber um aviso ou alerta critico você pode ser um pouco mais proativo ao monitorar o tamanho da área de recuperação flash. Na visão de desempenhoV$recovery_file_dest, você encontrara o total utilizado e o espaço reclamável no sistema de arquivos de destino. Alem disso, você pode utilizar a visão V$flash_recovery_area_usage para ver a divisão do uso por tipo de arquivo.
Mudar tamanho da área de recuperação flash para 3GB: 
alter system set db_recovery_file_dest_size=3g scope=both; 
Os itens permanentes e armazenados na área de recuperação flash são: arquivo de controle e arquivo de redo log online.
Os itens transientes e armazenados na área de recuperação flash são: arquivos de redo log arquivados, backup de arquivo de controle e conjuntos de backup rman.