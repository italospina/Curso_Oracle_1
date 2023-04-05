/*
Mantendo Redo Log


Arquivo de redo log.

Todo banco de dados oracle tem no mínimo dois grupos de arquivos de redo log cada um com pelo menos um arquivo de redo log. Serve pra registrar alteração feitas nos dados.

Para proteger os arquivos contra falha no disco, o oracle suporta arquivos Redo log multiplexado. Você pode manter uma cópia do arquivo em diferentes discos.

As cópias do arquivo de redo log mantidos em discos diferentes são chamados de arquivos de log espelhados. Cada membro de cada grupo de arquivo de log tem um arquivo de log espelhado de um mesmo tamanho.

Os seguintes itens são os valores mais comuns para a coluna STATUS:

• UNUSED indica que o grupo de online rede log nunca recebeu escrito. Este é o estado de um online redo log file que foi recentemente adicionado.

• CURRENT indica o grupo de online rede log corrente.Isto indica que o grupo de online redo log está ativo.

• ACTIVE indica que o grupo de online está ativo, mas não é o grupo de online redo log corrente.Ele é necessário para a recuperação de uma falha.Ele pode ou não estar arquivado.

• INACTIVE indica que um grupo online redo log não é necessário para a recuperação da instância.ele pode ou não estar arquivado. Para obter o nome de todos os membros de um grupo, consulte a visão de desempenho dinâmica V$LOGFILE na qual o valor da coluna STATUS pode ser:

-> INVALID indica que o arquivo está inacessível.

-> STALE indica que o conteúdo do arquivo está incompleto. Por exemplo, ao adicionar-se um membro de log file.

-> DELETED indica que o arquivo não está sendo utilizado.

-> NULL indica que o arquivo está em uso
*/

