
# 📊 Projeto de Análise de Dados - Clínica Seven

Este projeto foi desenvolvido com o objetivo de estruturar, tratar e visualizar os dados operacionais da Clínica Seven. Utilizamos ferramentas como **Python**, **Jupyter Notebooks**, **SQLite** e **Power BI** para construir um pipeline de dados completo, da ingestão à análise visual.

---

## ✅ Visão Geral do Projeto

- 🚀 **Objetivo**: Automatizar o fluxo de dados da clínica, permitindo análise rápida de KPIs operacionais e comerciais.
- 📂 **Fontes de dados**: arquivos CSV (`user_raw.csv`, `orders_raw.csv`, `products_raw.csv`).
- 🐍 **Tratamento dos dados**: realizado em notebooks Jupyter com a biblioteca `pandas`.
- 🗄️ **Armazenamento**: banco de dados relacional `SQLite` (`dados.db`).
- 📑 **Modelagem**: uso de tabelas dimensionais e fato (dim_usuarios, dim_produtos, fato_pedidos).
- 🧠 **Views SQL**: criadas para facilitar a análise e integração com o Power BI.
- ⚙️ **Orquestração**: automatizada com um arquivo `.bat` agendável no Windows.
- 📊 **Visualização**: realizada no Power BI via conector ODBC para SQLite.

---

## 🐍 Etapas do Pipeline de Dados

1. **Pré-processamento** dos arquivos `.csv`:
   - Limpeza de colunas `total`, `entry_time`, `e-mail`, `name` etc.
   - Conversão de tipos de dados (`float`, `date`, `time`)
   - Flatten de colunas complexas (`items` em `orders_raw.csv`)
   - Exclusão de valores inválidos

2. **Execução dos Notebooks**:
   - `usuarios.ipynb`, `pedidos.ipynb`, `produtos.ipynb`
   - Cada notebook transforma e exporta os dados tratados como CSV

3. **Carga com `main.py`**:
   - Lê os CSVs tratados e insere nas tabelas:
     - `dim_usuarios`
     - `dim_produtos`
     - `fato_pedidos`

4. **Criação de Views SQL (`criar_views.py`)**:
   - Views analíticas criadas diretamente no banco, como:
     - `total_pedidos_por_mes`
     - `ticket_medio_por_cliente`
     - `receita_por_produto`
     - `pedidos_por_hora`, entre outras (10+ views)

---

## ⚙️ Orquestração com Arquivo .BAT

Criamos um `.bat` que:

- Executa todos os notebooks automaticamente com `papermill`
- Gera os arquivos tratados
- Carga os dados no SQLite
- Permite agendamento com o **Agendador de Tarefas do Windows**

Exemplo de execução:

```bat
papermill usuarios.ipynb output_usuarios.ipynb
papermill pedidos.ipynb output_pedidos.ipynb
papermill produtos.ipynb output_produtos.ipynb
```

---

## 📊 Dashboard no Power BI

O painel foi desenvolvido no **Power BI Desktop** e está conectado ao banco de dados **`dados.db`** via **ODBC**.

### 🔗 Conexão com o Banco

- Conexão realizada com o driver ODBC para SQLite
- Utiliza um DSN configurado apontando para o arquivo `dados.db`
- Fonte dos dados são **views SQL** já modeladas para consumo analítico

### 🔍 O que o Dashboard consome

- As **views** criadas via script Python e armazenadas no SQLite:
  - `total_pedidos_por_mes`
  - `receita_por_metodo_pagamento`
  - `produto_mais_vendido`
  - `ticket_medio_por_cliente`
  - `pedidos_por_status_envio`
  - `pedidos_por_hora`, entre outras

### 🧩 Tabelas normalizadas

- `dim_usuarios`  
- `dim_produtos`  
- `fato_pedidos`  

Essas tabelas estão no formato ideal para criação de **relacionamentos no modelo estrela** dentro do Power BI.

### 🔁 Atualização Automática

Após execução do `.bat` ou dos notebooks, o Power BI já pode:
- Recarregar os dados (botão "Atualizar")
- Manter relatórios sempre atualizados com as novas entradas no SQLite

---

## ▶️ Como Executar o Projeto

```bash
# 1. Clone o repositório
git clone https://github.com/Rafa2704/clinica_seven.git
cd clinica_seven

# 2. Coloque os arquivos CSV brutos na raiz

# 3. Execute o arquivo .bat para rodar todo o processo

# 4. Abra o dashboard no Power BI (já conectado ao banco via ODBC)
```

---

## 📂 Estrutura do Projeto

```
clinica_seven/
│
├── data/                     # CSVs tratados
├── notebooks/                # Notebooks Jupyter de transformação
├── scripts/
│   ├── main.py               # Cria as tabelas e carrega o SQLite
│   └── criar_views.py        # Cria as views no SQLite
├── dados.db                  # Banco SQLite com dados finais
├── atualiza.bat              # Arquivo de orquestração automática
├── README.md
└── dashboard.pbix            # (Opcional) Power BI conectado
```

---

## ✅ Conclusão

Este projeto entrega um pipeline completo e escalável de dados para a Clínica Seven, com automação, governança, análise visual e facilidade de manutenção.
