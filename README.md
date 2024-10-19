# Prácticas en ensamblador MIPS
Este repositorio contiene todos los códigos desarrollados para la asignatura de Fundamentos de Computadoras que constan de:
- [Practica 1](./Practica1)
- [Practica 2](./Practica2)
- [Practica 3](./Practica3)
- [Practica 4](./Practica4)

Por último, también se planteaba una práctica final: [Enunciado de la práctica](./Enunciado.pdf)

Esta práctica consiste en contruir un programa en lenguaje ensamblador de MIPS que recibe por teclado una cadena que esta compuesta por:
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
