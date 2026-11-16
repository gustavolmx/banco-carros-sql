# Banco de Dados de Concessionaria (MySQL)

Projeto de portfolio em SQL: um banco relacional de uma concessionaria de carros, com 4 tabelas ligadas por chaves primarias e estrangeiras, e 10 consultas que respondem perguntas de negocio.

## Objetivo

Praticar modelagem relacional e consultas em MySQL, saindo do basico (`SELECT`, `WHERE`) ate `JOIN`, agregacoes, `HAVING`, subquery e `LEFT JOIN`.

## Modelo do banco

```
marcas (1) ----< (N) inventario (1) ----< (N) vendas (N) >---- (1) clientes
```

| Tabela | Colunas | Chaves |
|---|---|---|
| `marcas` | id, nome_marca, origem | PK: id |
| `inventario` | id, modelo, transmissao, motor, marcas_id | PK: id / FK: marcas_id -> marcas(id) |
| `clientes` | id, nome, sobre_nome, endereco | PK: id |
| `vendas` | id, clientes_id, inventario_id, data_venda, valor | PK: id / FK: clientes_id -> clientes(id), inventario_id -> inventario(id) |

Como ler: uma marca tem varios carros no inventario; cada venda liga um cliente a um carro.

## Perguntas de negocio e conceitos usados

| # | Pergunta | Conceito |
|---|---|---|
| 1 | Listar todos os carros com o nome da marca | `INNER JOIN` |
| 2 | Listar os carros automaticos com a marca e o pais de origem | `JOIN` + `WHERE` |
| 3 | Quantas vendas foram feitas e qual o valor total faturado? | `COUNT`, `SUM` |
| 4 | Qual o ticket medio das vendas? | `AVG` |
| 5 | Qual o total vendido por marca? | 3 tabelas + `GROUP BY` |
| 6 | Qual o modelo mais vendido? | `GROUP BY` + `ORDER BY` + `LIMIT` |
| 7 | Quais clientes compraram mais de um carro? | `GROUP BY` + `HAVING` |
| 8 | Quanto foi vendido em cada mes? | `MONTH()` + `GROUP BY` |
| 9 | Quais vendas ficaram acima do ticket medio? | Subquery |
| 10 | Quais carros do inventario nunca foram vendidos? | `LEFT JOIN` + `IS NULL` |

## Como executar

1. Tenha o MySQL e o MySQL Workbench instalados.
2. Abra o arquivo `carros.sql` no Workbench.
3. Execute o script inteiro (ele apaga o banco `carros`, se ja existir, e cria tudo de novo: banco, tabelas e dados de exemplo). Cuidado: se voce ja tem um banco chamado `carros`, ele sera apagado.
4. Execute as consultas uma a uma, selecionando cada trecho.

## Observacoes

- Todos os dados sao ficticios, criados apenas para praticar.
- Os nomes seguem o padrao `tabela_id` para chaves estrangeiras (por exemplo, `marcas_id`).

# Autoria e uso de IA

- As tabelas `marcas`, `inventario` e `clientes` foram criadas por mim.
- A tabela `vendas` e os dados de exemplo de `clientes` e `vendas` foram gerados com ajuda de uma IA (Claude).
- As consultas 1, 2, 3, 4, 6, 8, 9 e 10 foram escritas por mim.
- As consultas 5 e 7 foram feitas com ajuda de IA, e eu revisei o raciocinio de cada uma.

## O que aprendi

- Como identificar a chave estrangeira e a primaria para escrever o `ON` de um `JOIN`.
- A diferenca entre `WHERE` (filtra linhas, antes do agrupamento) e `HAVING` (filtra grupos, depois do agrupamento).
- A diferenca entre `INNER JOIN` e `LEFT JOIN`, e como o `NULL` ajuda a achar registros sem correspondencia.
- Conferir o resultado de cada consulta, porque uma consulta pode rodar sem erro e ainda assim devolver o numero errado.

## Proximos passos

- Aplicar o mesmo raciocinio a um banco maior.
- Conectar o resultado das consultas a um dashboard no Power BI.

## Contato

- LinkedIn: linkedin.com/in/gustavodelimamaximo
- E-mail: maximogustavo47@gmail.com
