
-- 1. Número y nombre de los vendedores a los que les hemos solicitado algún pedido en el año 1995 pero no les hemos solicitado ninguno en el año 1992.

SELECT NUMVEND, NOMVEND FROM VENDEDOR 
WHERE NUMVEND IN (SELECT NUMVEND FROM PEDIDO WHERE FECHA BETWEEN TO_DATE('01-01-95','DD/MM/YY') AND TO_DATE('31-12-95','DD/MM/YY') GROUP BY NUMVEND) 
AND NUMVEND NOT IN (SELECT NUMVEND FROM PEDIDO WHERE FECHA BETWEEN TO_DATE('01-01-92','DD/MM/YY') AND TO_DATE('31-12-92','DD/MM/YY') GROUP BY NUMVEND)  
ORDER BY NUMVEND
;

-- 2. Obtener el número y el nombre las piezas que puedan sernos suministradas por más de dos vendedores de la provincia de Alicante, 
--y que en total (entre todos los pedidos solicitados a todos los vendedores) hayamos pedido más de 500 unidades.

SELECT P.NUMPIEZA, P.NOMPIEZA
FROM PIEZA P
JOIN PRECIOSUM PS ON P.NUMPIEZA = PS.NUMPIEZA
JOIN VENDEDOR V ON PS.NUMVEND = V.NUMVEND
JOIN LINPED LP ON PS.NUMPIEZA = LP.NUMPIEZA
WHERE V.PROVINCIA = 'ALICANTE'
GROUP BY P.NUMPIEZA, P.NOMPIEZA
HAVING COUNT(DISTINCT PS.NUMVEND) > 2
AND SUM(LP.CANTPEDIDA) > 500
;


/*   COMPROBACIONES APARTADO 2
--PIEZAS QUE PUEDEN SUMINSITRAR MAS DE DOS VENDEDORES
SELECT NUMPIEZA  FROM PIEZA WHERE NUMPIEZA IN (SELECT NUMPIEZA "pieza mas de 2 vende" FROM PRECIOSUM  GROUP BY NUMPIEZA HAVING COUNT(DISTINCT NUMVEND)>2) ;

-- SUBCONSULTA QUE DEVUELVE LOS VENDERORES QUE PUEDEN SUMINISTRAR MAS DE UNA PIEZA
SELECT NUMPIEZA "pieza mas de 2 vende" FROM PRECIOSUM  GROUP BY NUMPIEZA HAVING COUNT(DISTINCT NUMVEND)>2;
*/


-- 3. Obtener para el número y nombre de los vendedores de Alicante a los que se les haya solicitado alguna pieza,
-- de la que nos habían indicado que su plazo de suministro sería superior a una semana,
-- junto con el número y nombre de la pieza, y la cantidad de pedidos distintos en los que se les ha solicitado.
-- Ordena el resultado por la última columna.
   
SELECT V.NUMVEND, V.NOMVEND, PI.NUMPIEZA, PI.NOMPIEZA, L.NUMPEDIDO FROM VENDEDOR V
JOIN PEDIDO P ON V.NUMVEND = P.NUMVEND 
JOIN LINPED L ON P.NUMPEDIDO = L.NUMPEDIDO
JOIN PIEZA PI ON PI.NUMPIEZA = L.NUMPIEZA
WHERE  V.PROVINCIA='ALICANTE'
AND  PI.NUMPIEZA IN (SELECT PS.NUMPIEZA FROM PRECIOSUM PS WHERE DIASSUM>7)
GROUP BY V.NUMVEND, V.NOMVEND, PI.NOMPIEZA, PI.NUMPIEZA, L.NUMPEDIDO 
ORDER BY L.NUMPEDIDO DESC    
;




-- 4. Crea una vista con los datos con todos los datos de los productos que aparezcan en el inventario
-- pero que no hayan aparecido en un pedido.

CREATE OR REPLACE VIEW PIEZA_INVENTARIADA_NOPEDIDA AS SELECT * FROM PIEZA P WHERE P.NUMPIEZA IN
(SELECT I.NUMPIEZA FROM INVENTARIO I WHERE I.NUMPIEZA NOT IN (SELECT L.NUMPIEZA FROM LINPED L))
;
SELECT * FROM PIEZA_INVENTARIADA_NOPEDIDA
;

-- 5. Crea un listado con el numero, nombre, precio de suministro y descuento de todos aquellas piezas que tengamos en la base de datos
-- indepediendentemente que puedan sernos suministradas o no por un vendedor.

SELECT pi.numpieza, pi.nompieza, pr.preciounit, pr.descuento FROM pieza pi
JOIN preciosum pr ON pi.numpieza=pr.numpieza;
/*
--comprobaciones
SELECT * FROM PIEZA;
SELECT NUMPIEZA FROM PRECIOSUM WHERE NUMPIEZA='DD-0001-210'; --las piezas tienen distintos precios segun el vendedor
SELECT * FROM INVENTARIO;
*/