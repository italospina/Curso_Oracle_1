--
-- Seção 11 
-- Exibindo dados a partir de Múltiplas Tabelas
--
-- Aula 4 - OUTER JOINS

-- LEFT OUTER JOIN
-- verifica a tabela da esquerda e mostra todos resultados de trabalhadores, tendo ou não departamento
SELECT e.first_name, e.last_name, d.department_id, d.department_name
FROM employees e LEFT OUTER JOIN departments d
     ON (e.department_id = d.department_id) 
ORDER BY d.department_id;

-- RIGHT OUTER JOIN
-- Verifica a tabela da direita e mostra todos os resultados de departamentos tendo ou não empregados
SELECT d.department_id, d.department_name, e.first_name, e.last_name
FROM employees e RIGHT OUTER JOIN departments d
     ON (e.department_id = d.department_id) 
ORDER BY d.department_id;

-- FULL OUTER JOIN
-- Mostra quando não tiver correspondente na esquerda e direita
SELECT d.department_id, d.department_name, e.first_name, e.last_name
FROM   employees e FULL OUTER JOIN departments d
     ON (e.department_id = d.department_id) 
ORDER BY d.department_id;


