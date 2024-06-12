# Haskell Funcional Lagranja

Este es un proyecto en Haskell que modela una granja de animales y diferentes actividades que se pueden realizar sobre ellos.

## Descripción

El proyecto consta de las siguientes partes:

1. **Tipos de datos**: Se definen tipos de datos para representar a los animales, incluyendo su nombre, tipo, peso, edad, estado de enfermedad, días de recuperación y costo de atención.

2. **Funciones sobre animales**: Se implementan funciones para verificar si un animal la pasó mal o si tiene un nombre "falopa" (que termina en 'i').

3. **Actividades**: Se definen diferentes actividades que se pueden realizar sobre los animales, como engorde, revisación, festejo de cumpleaños y chequeo de peso.

4. **Proceso**: Se define una función `proceso` que toma una lista de actividades y un animal, y aplica todas las actividades al animal en orden.

5. **Mejora de peso**: Se implementa una función recursiva `mejoraDePeso` que verifica si un animal mejora sustentablemente su peso después de aplicar una lista de actividades, es decir, si su peso nunca disminuye y no aumenta más de 3 kilos entre actividades consecutivas.

6. **Funciones de orden superior**: Se utiliza la función `take` y `filter` para obtener los primeros tres animales que tengan un nombre "falopa".

7. **Uso de composición y aplicación parcial:** El código hace un uso extensivo de la composición de funciones y la aplicación parcial, dos técnicas fundamentales en Haskell y en la programación funcional en general. 

## PdePreludat

El proyecto hace uso de `PdePreludat`, un módulo de Haskell que proporciona una alternativa al preludio estándar de Haskell (`Prelude`). `PdePreludat` ofrece una serie de funciones y tipos de datos adicionales que complementan las capacidades del lenguaje Haskell, facilitando el desarrollo de código más expresivo y conciso.