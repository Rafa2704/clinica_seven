import pandas as pd
import sqlite3

# Caminhos dos arquivos CSV tratados
path_usuarios = 'usuarios_tratado.csv'
path_pedidos = 'pedidos_tratado.csv'
path_produtos = 'produtos_tratado.csv'

# Leitura dos DataFrames
df_usuarios = pd.read_csv(path_usuarios)
df_pedidos = pd.read_csv(path_pedidos)
df_produtos = pd.read_csv(path_produtos)

# Conexão com o banco SQLite
con = sqlite3.connect('dados.db')

# Carga dos dados (substitui se já existir)
df_usuarios.to_sql('dim_usuarios', con, if_exists='replace', index=False)
df_pedidos.to_sql('fato_pedidos', con, if_exists='replace', index=False)
df_produtos.to_sql('dim_produtos', con, if_exists='replace', index=False)

# Confirma e fecha
con.commit()
con.close()

print("Carga concluída com sucesso.")
