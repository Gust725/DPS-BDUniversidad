echo Instalador de la base de datos Universidad
echo Autor: Gustavo Delgado 
echo 8 de agosto de 2022
sqlcmd -S. -E -i BDUniversidad.sql
sqlcmd -S. -E -i BDUniversidadPA.sql
echo Se ejecuto correctamente la base de datos
pause