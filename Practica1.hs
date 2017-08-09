{-
- Lenguajes de programación 2018-1
- Profesora: Susana H. Martín Lunas
- Ayudante: Alejandra Krystel Colapa Díaz
- Laboratorio: Fernando A. Galicia Mendoza
- Implementación del lenguaje PostFix.
- Integrantes:
- <Nombres> - <Número de cuenta>
-}

module LenguajePostfix where

--Sintaxis
data PF = Postfix deriving(Show)
data Comando = L Int | ADD | DIV | EQ | EXEC | GT | LOT | MUL | NGET | POP | REM | SEL | SUB | SWAP |SEC [Comando] deriving(Show)

type Programa=(PF,Int,[Comando])
type Pila =[Comando]

--Semántica

--Ejemplos de prueba:
verifProg :: Programa -> Pila -> Bool
verifProg (_,m,_) p = m==length p
--Programas que terminan con un valor entero.

--Resultado: L 3
programa1 = exec (Postfix,0,[L (-1),L 2,ADD,L 3,MUL]) []
--Resultado: L (-14)
programa2 = exec (Postfix,3,[MUL,SWAP,L 2,MUL,SWAP,SUB]) [L 5,L 4,L 3]
--Resultado: L 14
programa3 = exec (Postfix,1,[SEC [L 2,MUL],EXEC]) [L 7]
--Resultado: L (-7)
programa4 = exec (Postfix,0,[SEC [L 0,SWAP,SUB],L 7,SWAP,EXEC]) []
--Resultado: L 12
programa5 = exec (Postfix,4,[LOT,SEC [ADD],SEC [MUL],SEL,EXEC]) [L 5,L 6,L 4,L 3]
--Resultado: L 12
programa6 = exec (Postfix,2,[L 2,NGET]) [L 9,L 12]

--Programas que terminan en error.

--Resultado: *** Exception: Error argumentos: Número de argumentos distintos al tamaño de la pila.
error1 = exec (Postfix,2,[SWAP]) [L 3]
--Resultado: *** Exception: Error argumentos: Número de argumentos distintos al tamaño de la pila.
error2 = exec (Postfix,1,[POP]) [L 4,L 5]
--Resultado: *** Exception: Error aritmético: Argumentos insuficientes.
error3 = exec (Postfix,1,[L 4,MUL,ADD]) [L 3]
--Resultado: *** Exception: Error NGET: Índice fuera de rango.
error4 = exec (Postfix,2,[L 3,NGET]) [L 7,L 8]
--Resultado: *** Exception: Error NGET: J-ésimo elemento no entero.
error5 = exec (Postfix,1,[SEC [L 2,MUL],L 1,NGET]) [L 3]
