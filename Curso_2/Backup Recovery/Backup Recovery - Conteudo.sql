Backup e Recovery - Conteúdo


Visão Geral 

Uma das maiores responsabilidades de um Administrador de Banco de Dados (DBA) é manter o banco de dados disponível para uso. Se houver uma falha de qualquer tipo no sistema, o DBA deve disponibilizar novamente o banco de dados o mais rápido possível com o mínimo ou nenhuma perda de dados. 
Para proteger os dados de todos os tipos de falhas que podem ocorrer, o DBA deve fazer backups regulares do banco de dados. Sem o backup, é impossível para o DBA recolocar o banco no ar sem perda de dados caso haja uma falha de arquivo. Backups são críticos para a recuperação de diferentes tipos de falhas. Além disso, o DBA deve configurar o banco de forma que ele suporte tais falhas o máximo possível sem ficar indisponível. E para que, em caso de indisponibilidade, os tempos de downtime e recuperação sejam mínimos. Definindo uma Estratégia de Backup e Recovery 
Para qualquer abordagem que você escolha, é importante obter aprovação de todos os níveis de gerência. Por exemplo, se a sua compania quer evitar a necessidade de efetuar cópias físicas dos arquivos para minimizar o uso de espaço em disco, a gerência deve estar ciente das consequências que esta decisão pode acarretar. 

Perguntas a Serem Feitas 
Realizar uma análise completa dos requisitos técnicos, operacionais e de negócio fornece à gerência as informações que ela precisa para dar apoio a uma estratégia efetiva de backup e recovery. 

Perguntas a serem feitas incluem: 
• A gerência conhece as trocas envolvidas na estratégia de backup escolhida, tendo em vista suas expectativas de disponibilidade do sistema? 
• A gerência está disposta a fomecer os recursos necessários para garantir uma estratégia bem sucedida de backup e recovery? 
• A gerência compreende a importância de implementar tal estratégia? 

Requisitos do Negócio 

Impacto no Negócio 
E importante compreender o impacto que o tempo de indisponibilidade do sistema terá no negócio. Nesse coso, a gerência deve quantificar o custo desse tempo e a perda de dados e comporá- los como custo de reduzir a indisponibilidade e de minimizar a perda de dados. MTTR Disponibilidade de sistema é a questão chave para um DBA. No caso de uma falha o DBA deve se esforçar para reduzir o Tempo Até a Recuperação (Mean-Time-To-Recover, MTTR). Isso garante que o banco de dados fica indisponível pelo menor espaço de tempo possível. Antecipando os tipos de falhas que podem ocorrer e usando estratégias de recuperação efetivas, o DBA pode definitivamente reduzir o MTTR. MTBF Protegendo o banco de dados contra vários tipos de falhas é também uma tarefa-chave para o DBA. Nesse caso, o DBA deseja aumentar o Tempo-Entre-Falhas (Mean-Time¬Between-Failures, MTBF). Isso pode ser feito compreendendo-se as estruturas de backup e recovery dentro do ambiente do banco de dados Oracle e configurando-o de modo que falhas não ocorram freqüentemente. 

Processo em Evolução 
Uma estratégia de backup e recovery está sempre evoluindo a medida que os requisitos técnicos, operacionais e de negócio mudam. É importante que tanto o DBA quanto a gerência revejam a validade da estratégia de backup e recovery regularmente. 
Requisitos Operacionais 
Operações em Tempo Integral A natureza de backups e recovery sempre são afetadas pelo tipo de operações de negócio, particularmente quando um banco de dados deve estar disponível vinte e quatro horas por dia, sete dias por semana. Configurações apropriadas são necessárias para suportar essas exigências operacionais, visto que elas afetam diretamente os aspectos técnicos do ambiente do banco de dados. 

Testando Backups 
A única maneira pela qual DBAs podem ter certeza de que possuem uma estratégia que os permitirá reduzir o MTTR e aumentar o MTBF, é tendo um plano implantado para testar regularmente a validade dos backups. Uma recuperação é tão boa quanto os backups disponíveis.

Perguntas a serem feitas incluem: 
• Posso depender de administradores de sistema, DBAs, fornecedores e assim por diante quando precisar de ajuda? 
• Posso testar minhas estratégias de backup e recovery em intervalos regulares?
• São armazenadas cópias de backup em outro(s) local(ais)? 
• O plano está bem documentado e mantido?


Volatilidade do Banco de Dados 
Outra questão que causa impacto nos requisitos operacionais é a volatilidade dos dados e dos estruturas do banco. Questões a serem feitas incluem: 

• As tabelas são freqüentemente atualizadas? Os dados são muito voláteis? Se são, serão necessários mais backups do que em um negócio onde os dados são mais estáticos? 
• A estrutura do banco de dados muda freqüentemente? 
• Com que freqüência são adicionados datafiles?


Requisitos Técnicos 
Cópias Físicas 
Certos requisitos técnicos são ditados pelos tipos de backups necessários. Por exemplo, se cópias físicas são necessárias, isso pode impactar significativamente em espaço de armazenamento disponível. 
Cópias Lógicas 
Realizando cópias lógicas de objetos no banco de dados pode não significar tanto em requisitos de armazenamento quanto cópias físicas de imagem, entretanto, recursos do sistema podem ser afetados, visto que cópias lógicas são realizadas enquanto o banco de dados está sendo utilizado por usuários. 

Configuração de Banco de Dados 
Configurações diferentes de banco de dados afetam a forma de como os backups são realizados e a disponibilidade do banco. Dependendo da configuração do banco, recursos do sistema para suportar uma estratégia de backup e recovery, tais como espaço em disco, podem ser limitados. 
Volume de Transações 
Volume de transações também afetam os recursos de sistema. Se operações de vinte e quatro horas e backups regulares devem ser feitos, então a carga de recursos de sistema aumenta. 

Requisitos Técnicos 
Perguntas a serem feitas incluem: 
• Quanta informação eu tenho no banco? 
• Eu tenho o poder e a capacidade de máquina para suportar backups? 
• Os dados são facilmente recriados? 
• É possível recarregar os dados no banco de dados a partir de arquivos texto (flat files) ? 

• A configuração do banco de dados suporta diferentes tipos de falhas? 
Questões sobre Recuperação de Desastres 
Desastres Naturais 
Quem sabe seus dados são tão importantes que você deve garantir flexibilidade mesmo no evento de uma falha total do sistema. Desastres naturais e outras questões podem afetar a disponibilidade dos dados e devem ser consideradas na criação de um plano de recuperação de desastres. Questões a serem feitas incluem: 
• O que acontecerá ao negócio no caso de um desastre sério tal como inundação, incêndio, terremoto ou furacão? 
• Se o seu banco de dados falhar, o seu negócio estará apto a funcionar durante as horas, dias ou mesmo semanas que levará para conseguir um novo sistema de hardware? 
• São mantidos backups físicos em outro lugar? 

Soluções 
• Backups fora do local de trabalho. 
• Uso do Oraclel Data Guard Banco para configurar e manter bancos de dados standby, que podem para assumir o papel do banco de dados primário em caso de falha deste. 
Perda de Pessoal Chave 

Em termos de pessoal Chave, você deve se perguntar: 
• Como a perda de pessoal importante irá afetar o seu negócio? 
• Se o seu DBA deixar a empresa ou ficar incapacitado de trabalhar, o seu sistema continuará funcionando? 
• Quem irá gerenciar uma situação de recuperação se o DBA não estiver? 

Recursos do Oracle Real Application Cluster 
O Oracle Real Application Cluster (RAC) é uma recurso opcional que permite a você utilizar múltiplas instâncias de banco de dados agrupados em cluster como se fossem um único banco de dados. Dessa forma, quando uma das máquinas falha, as demais assumem as tarefas do máquina que falhou. A implementação do Oracle Real Application Cluster é discutido em um curso separado. 
Oracle FailSafe 
Com o Oracle FailSafe, duas máquinas compartilham um sistema de discos onde um banco de dados está localizado, de forma semelhante ao RAC. Porém, em qualquer momento, somente uma instância está operacional. Quando uma falha operacional ocorre, a outra máquina assume os discos (inicia a instância) automaticamente.