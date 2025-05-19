@echo off
echo Executando notebooks da Clínica Seven...

REM Ativa o ambiente Conda (ajuste "base" se estiver usando outro ambiente)
CALL C:\Users\rafae\anaconda3\Scripts\activate.bat base

REM Vai até a pasta onde estão os notebooks
cd /d "C:\Users\rafae\Desktop\clinica_sevem\Data_Lake\notebooks"

REM Executa cada notebook com papermill
papermill usuarios.ipynb output_usuarios.ipynb
papermill pedidos.ipynb output_pedidos.ipynb
papermill produtos.ipynb output_produtos.ipynb

echo Execução dos notebooks concluída com sucesso!
pause


