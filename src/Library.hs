{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
module Library where
import PdePreludat


type Nombre = String
type TipoAnimal = String
type Peso = Number
type Edad = Number
type Enfermo = Bool
type DiasRecuperacion = Number
type CostoAtencion = Number

data Animal = Animal {
  nombre  :: Nombre,
  tipo    :: TipoAnimal,
  peso    :: Peso,
  edad    :: Edad,
  enfermo :: Enfermo,
  diasRecuperacion :: DiasRecuperacion,
  costoAtencion    :: CostoAtencion
} deriving Show 

type VisitaMedica = (DiasRecuperacion, CostoAtencion)


-- 1) ANIMALES SUELTOS
-- Verifica si un animal la pasó mal
laPasoMal :: Animal -> Bool
laPasoMal animal = ((> 30) . diasRecuperacion) animal

-- Verifica si un animal tiene un nombre falopa
nombreFalopa :: Animal -> Bool
nombreFalopa animal = ((== 'i') . last . nombre) animal



-- 2) ACTIVIDADES 

pipiPerro :: Animal
pipiPerro = Animal {
    nombre  = "Pipi",
    tipo    = "Perro",
    peso    = 10,
    edad    = 5,
    enfermo = True,
    diasRecuperacion = 5,
    costoAtencion    = 5
}
type Actividades = Animal -> Animal

-- Funcion que incrementan la mitad de su peso hasta un máximo de 5 kilos
engorde :: Peso -> Actividades
engorde alimentoBalanceado animal = animal { peso = min (peso animal + alimentoBalanceado / 2)
                                                        (peso animal + 5) }

-- Función para la revisación de un animal
revisacion :: DiasRecuperacion -> CostoAtencion -> Actividades
revisacion dias costo animal 
  | enfermo animal = engorde 2 (animal { diasRecuperacion = dias, costoAtencion = costo })
  | otherwise      = animal

-- Función para el festejo de cumpleaños de un animal
festejoCumple :: Actividades
festejoCumple animal = animal { edad = edad animal + 1, peso = peso animal - 1 }

-- -- Función para el chequeo de peso de un animal
-- chequeoPeso :: Peso -> Actividades
-- chequeoPeso pesoX animal = peso animal > pesoX animal || enfermo animal 
chequeoPeso :: Peso -> Actividades
chequeoPeso pesoX animal
  | peso animal < pesoX = animal { enfermo = True }
  | otherwise = animal


-- 3) EL PROCESO
-- Proceso que realiza una serie de actividades sobre un animal
proceso :: [Actividades] -> Animal -> Animal
proceso actividades animal = foldl (flip ($)) animal actividades

{-
> proceso [chequeoPeso 12 . festejoCumple . revisacion 20 7 . engorde 10] pipiPerro                                                        10] pipiPerro     
Animal
    { nombre = "Pipi"
    , tipo = "Perro"
    , peso = 15
    , edad = 6
    , enfermo = True
    , diasRecuperacion = 20
    , costoAtencion = 7
    }
-}

-- 4) MEJORA O NO MEJORA
mejoraDePeso :: [Actividades] -> Animal -> Bool
mejoraDePeso [] animal = True
mejoraDePeso (actividad1:actividad2:actividades) animal =
    peso (actividad1 animal) <= peso (actividad2 animal) 
    && peso (actividad2 animal) - peso (actividad1 animal) <= 3
    && mejoraDePeso (actividad2:actividades) animal

-- 5) GIVE ME ONE, GIVE ME TWO
primerosTresFalopas :: [Animal] -> [Animal]
primerosTresFalopas listaAnimales = (take 3 . filter nombreFalopa) listaAnimales 

{-
¿Si le pasáramos una cantidad infinita de animales, 
sería posible obtener un valor computable para la función del punto anterior? 

La función take tomará solo los primeros tres elementos de la lista que cumplan 
con la condición de tener un nombre falopa, y Haskell evaluará la lista de manera 
perezosa para producir los resultados esperados. 

Todo esto sucedera unicamente si filter logra encontrar los tres animales con nombre 
falopa en la lista de animales. Si no lo hace, la función take no producirá ningún 
resultado.

Haskell utiliza evaluación diferida, podemos trabajar con listas infinitas de manera segura 
siempre que nos aseguremos de que nuestras funciones converjan y no entren en un bucle infinito. 
-}