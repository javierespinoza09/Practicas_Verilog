# Quiz 4 Verificación Funcional de Sistemas Digitales

![gui](https://github.com/javierespinoza09/Practicas_Verilog/assets/99856936/a78568d9-4a3a-4b45-a654-ebb81c6435c0)

Ruta de los archivos:
``` bash
cd /mnt/vol_NFS_rh003/Est_Verif_II2023/JavierEspinozaR_II_2023/Practicas_Verilog/Verificacion_Javier/Q4
bash run_fifo_asinc.sh
./salida -gui
```

Bash con el comando para ejecutar el diseño propuesto:
bash run_fifo_asinc.sh

./salida -gui //comando para obtener la salida gráfica 


//Se debería ver algo como esto
![gui](https://github.com/javierespinoza09/Practicas_Verilog/assets/99856936/a78568d9-4a3a-4b45-a654-ebb81c6435c0)


En el diseño propuesto se encontró un error de temporización debido a que la captura de datos de los registros dependía en su totalidad de la señal de PUSH y no del CLK, por lo que se pueden producir errores temporales en la salida del sistema como se muestra en la siguiente figura:


![error_temp](https://github.com/javierespinoza09/Practicas_Verilog/assets/99856936/dc7b645d-0e2f-47f0-82cf-30a18f07a725)

En la salida se observa como el dato varía en el momento del PUSH previo a la señal del CLK que modifica el contador.

En la siguiente figura se puede observar la señal de salida en los diferentes tiempos, flanco de reloj y PUSH:

![salida_flanco](https://github.com/javierespinoza09/Practicas_Verilog/assets/99856936/8c984df7-0ea6-4c7f-a731-ff99d03c4d46)


Bash para ejecutar la simulación del sistema con registros síncronos:
```bash
bash run_fifo_sinc.sh
./salida -gui
```


Se diseño un sistema con registros síncronos para corregir el error de temporización mostrado. En este caso se utiliza la señal de PUSH únicamente como eñal de Enable, que permite almacenar el dato en el flanco del reloj, lo que hace que el PUSH se actualicen simultaneamente.

![salida_estab](https://github.com/javierespinoza09/Practicas_Verilog/assets/99856936/e29ddab8-2ec1-49f8-8aa0-fa800d1663b3)

