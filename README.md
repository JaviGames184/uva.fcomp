# Prácticas en ensamblador MIPS
Este repositorio contiene el código desarrollado para la asignatura de Fundamentos de Computadoras como respuesta a: [Enunciado de la práctica](./Enunciado.pdf)

La práctica consiste en contruir un programa en lenguaje ensamblador de MIPS que recibe por teclado una cadena.
Esta cadena estará compuesta por:
- Operación a realizar
- Operando 1
- Operando 2 (opcional)
  
(separados por al menos un espacio o un tabulador)

**Si la entrada no obedece a la sintaxis requerida el programa debe imprimir "ENTRADA INCORRECTA".**

Las operaciones que se pueden realizar son:
| **Operación** | **Operando 1** | **Operando 2** | **Salida** | **Observaciones** |
|-----------|------------|------------|--------|---------------|
| *len*   | Cadena     |            | Número de caracteres de la cadena en hexadecimal. | |
| *lwc*   | Cadena     |            | Cadena en minúsculas. | |
| *upc*   | Cadena     |            | Cadena en mayúsculas. | |
| *cat*   | Cadena1    | Cadena2    | Concatenación de las dos cadenas. | |
| *cmp*   | Cadena1    | Cadena2    | "IGUAL", "MAYOR" o "MENOR" | Compara Cadena1 con Cadena2 carácter a carácter en código ASCII. |
| *chr*   | Cadena1    | Cadena2    | Lugar ocupado por el primer carácter de la primera cadena en la segunda empezando a buscar desde el principio en hexadecimal. | Si el carácter no se encuentra deberá imprimir 0. |
| *rchr*  | Cadena1    | Cadena2    | Lugar ocupado por el primer carácter de la primera cadena en la segunda empezando a buscar desde el final en hexadecimal. | Si el carácter no se encuentra deberá imprimir 0. |
| *str*   | Cadena1    | Cadena2    | Lugar ocupado por la primera cadena dentro de la segunda empezando a buscar desde el principio en hexadecimal. | Si la primera cadena no se encuentra dentro de la segunda deberá imprimir 0. |
| *rev*   | Cadena     |            | Cadena con los caracteres en orden inverso. | |
| *rep*   | Cadena     | Número     | Cadena repetida tantas veces como indique el número en hexadecimal. | |

# Autores
- [Javier Ramos](https://github.com/JaviGames184)
- Mario Danov
