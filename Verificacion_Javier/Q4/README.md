# Quiz 4 Verificación Funcional de Sistemas Digitales

![Alt text](https://github.com/javierespinoza09/Practicas_Verilog/edit/master/Verificacion_Javier/Q4/Diagrama.png)

Ruta de los archivos:
/mnt/vol_NFS_rh003/Est_Verif_II2023/JavierEspinozaR_II_2023/Practicas_Verilog/Verificacion_Javier/Q4

Bash con el comando para ejecutar el diseño propuesto:
bash run_fifo_asinc.sh

./salida -gui //comando para obtener la salida gráfica 


//Se debería ver algo como esto
![Alt text](https://github.com/javierespinoza09/Practicas_Verilog/edit/master/Verificacion_Javier/Q4/gui.png)


En el diseño propuesto se encontró un error de temporización debido a que la captura de datos de los registros dependía en su totalidad de la señal de PUSH y no del CLK, por lo que se pueden producir errores temporales en la salida del sistema como se muestra en la siguiente figura:


![Alt text](https://github.com/javierespinoza09/Practicas_Verilog/edit/master/Verificacion_Javier/Q4/error_temp.jpg)

En la salida se observa como el dato varía en el momento del PUSH previo a la señal del CLK que modifica el contador.

En la siguiente figura se puede observar la señal de salida en los diferentes tiempos, flanco de reloj y PUSH:

![Alt text](https://github.com/javierespinoza09/Practicas_Verilog/edit/master/Verificacion_Javier/Q4/salida_flanco.jpg)


Bash para ejecutar la simulación del sistema con registros síncronos:
bash run_fifo_sinc.sh

./salida -gui //comando para obtener la salida gráfica 


Se diseño un sistema con registros síncronos para corregir el error de temporización mostrado. En este caso se utiliza la señal de PUSH únicamente como eñal de Enable, que permite almacenar el dato en el flanco del reloj, lo que hace que el PUSH se actualicen simultaneamente.

![Alt text](https://github.com/javierespinoza09/Practicas_Verilog/edit/master/Verificacion_Javier/Q4/salida_estab.jpg)

