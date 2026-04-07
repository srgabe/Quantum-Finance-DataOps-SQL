# 📈 Quantum-Finance-DataOps: SQL & Engineering

Este repositório contém o pipeline de **Engenharia de Dados** e **Analytics** desenvolvido para dar suporte a modelos de computação quântica aplicados ao mercado financeiro. O foco aqui é a transição entre dados brutos (Raw Data) e inteligência de negócios (Insights) utilizando **SQL de alta performance**.

---

## 🎯 Objetivos do Projeto
Como físico migrando para Data Science, este módulo demonstra a aplicação de rigor estatístico em bancos de dados relacionais para:
* **Ingestão Automatizada:** Pipeline em Python para consumo da API `yfinance`. 
* **Armazenamento OLAP:** Utilização do **DuckDB** para criação de um banco de dados analítico local (`.db`) de alta velocidade. 
* **SQL Avançado:** Implementação de lógicas complexas (Window Functions, CTEs) para processamento de séries temporais. 

---

## 🛠️ Stack Tecnológica
* **Linguagem:** Python 3.12 
* **Banco de Dados:** DuckDB & SQLite 
* **Exploração de Dados:** SQLiteOnline 
* **Bibliotecas:** `yfinance`, `pandas`, `duckdb` 

---

## 📂 Estrutura do Repositório
* `notebook_ingestao.ipynb`: Notebook com o processo de ETL (Extract, Transform, Load). 
* `quantum_crypto_queries.sql`: Script SQL puro com análises de volatilidade e médias móveis. 
* `quantum_crypto_analytics.db`: Arquivo de banco de dados persistente gerado. 
* `data/`: Arquivos CSV para portabilidade entre diferentes motores SQL. 

---

## 📊 Análises Implementadas (SQL)

### 1. Médias Móveis Cruzadas
Utilização de `AVG() OVER()` para calcular médias de 7 e 21 dias, permitindo a suavização de ruído em dados de fechamento do Bitcoin. 

### 2. Volatilidade de "Alta Energia"
Queries desenhadas para identificar dias onde a amplitude (High - Low) superou 5% do valor de abertura, sinalizando regimes de alta instabilidade. 

### 3. Cálculo de Momentum com LAG
Uso da função de navegação `LAG()` para calcular o retorno diário percentual sem a necessidade de Self-Joins custosos. 

> **Nota de Interoperabilidade:** O banco de dados foi validado no **SQLiteOnline**, garantindo que a lógica analítica seja portável para ambientes de produção e ferramentas de BI. 

---

## 📊 Demonstração de Query Analítica

Para exemplificar a robustez do pipeline, implementamos uma análise de **Volatilidade Diária** e **Suavização de Ruído**. Esta abordagem une conceitos de **Física Estatística** (análise de flutuações) com **Finanças Quantitativas**.

A query abaixo utiliza **Window Functions** para calcular a média móvel de 20 dias, permitindo identificar se a volatilidade atual é um desvio padrão comum ou uma anomalia do sistema:

### Stress Test: Volatilidade vs. Médias Móveis
Abaixo, observamos a execução da lógica no **SQLiteOnline**, validando a interoperabilidade do arquivo `.db` gerado:

<p align="center">
  <img width="500" alt="Query de Volatilidade no SQLiteOnline" src="https://github.com/user-attachments/assets/086864ff-334b-4d23-ab2d-d9381854e088" />
</p>

---

## 🔬 O Insight do Físico
Nesta análise, a **Amplitude Diária** ($Máxima - Mínima$) é tratada como a "Energia de Flutuação" do ativo. Ao processar esses dados via SQL, conseguimos:
* **Reduzir o ruído temporal** através de janelas deslizantes (`AVG OVER`).
* **Otimizar a performance** delegando o cálculo pesado ao motor do banco de dados (DuckDB), mantendo o código Python limpo e focado no modelo quântico.


## 🎓 Conclusão
Este projeto fecha o ciclo entre a captura de dados e a prontidão para o uso em algoritmos quânticos (como QAOA e VQE). Ele prova que a eficiência de um modelo quântico depende diretamente de uma fundação de dados sólida e bem estruturada em SQL.
