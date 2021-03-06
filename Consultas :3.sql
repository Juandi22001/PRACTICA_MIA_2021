/**

CONSULTAS  en este apartado estaran todas las consultas creadas  
*/

#COSULTA 1 
/*
Tengo que mostrar el nombre del hospital su direccion  y el numero de fallecidos por cada hospital 
*/



use Practica_MIA;
/*primero hago un count para poder contar las veces que aparece la victima morida*/
#2jalo los datos que quiero
#3 primero verifico que sea la victima   con su nombre y todo 
/*por ultimo solo los agrupo conforme lo pide la consulta*/
SELECT DISTINCT COUNT(MUERTE) AS M , DIRECCION_HOSPITAL,NOMBRE_HOSPITAL FROM VISTIMA AS V  ,TemporalR  
WHERE TemporalR.NOMBRE_VICTIMA = V.NOMBRE_VISTIMA AND TemporalR.APELLIDO_VICTIMA = V.APELLIDO_VISTIMA 
AND TemporalR.DIRECCION_VICTIMA = V.DIRECCION_VISTIMA AND DIRECCION_HOSPITAL!="" AND NOMBRE_HOSPITAL!=""
group by NOMBRE_HOSPITAL,DIRECCION_HOSPITAL ORDER BY M ;


#CONSULTA 2
/**

Mostrar el nombre, apellido de todas las víctimas en cuarentena que
presentaron una efectividad mayor a 5 en el tratamiento “Transfusiones de
sangre”.
*/

SELECT DISTINCT NOMBRE_VISTIMA,APELLIDO_VISTIMA FROM VISTIMA AS V
INNER JOIN  DEF_TRATAMIENTO AS DEF ON (V.ID_VISTIMA=DEF.VISTIMA_ID)
INNER JOIN Tratamiento_Aplicado AS T ON( DEF.ID_TRATAMIENTO_APLICADO=T.ID_TRATAMIENTO)
INNER JOIN Desc_Paciente AS Des_c ON (Des_c.ID_ESTADO=V.ID_ESTADO_P)
WHERE DEF.EFECTIVIDAD_VISTIMA > 5 AND T.NOMBRE_TRATAMIENTO="Transfusiones de sangre"
AND Des_c.DESCP_ESTADO_PACIENTE="En cuarentena"
group by NOMBRE_VISTIMA ,APELLIDO_VISTIMA ;
/**
primero que nada , vamos  obtener el nombre de la vistima  junto con  su apellido _v
segundo vamos a hacer los inner correspondientes para poder  obtener lo que querremos
basicamente vamos bajando de nivel en nivel en nuestras tablas
por ultimo lo unico que hago es irlas agrupando  por como lo pide la consulta
*/
#CONSULTA 3 


/**

Mostrar el nombre, apellido y dirección de las víctimas fallecidas con más de
tres personas asociadas.

*/


SELECT DISTINCT T.name_, T.apellido_,T.direccion_ 
FROM(
SELECT DISTINCT 
NOMBRE_VISTIMA as name_ , APELLIDO_VISTIMA as apellido_,DIRECCION_VISTIMA  as direccion_ 
,COUNT(CONT.DESC_ASOCIADO_ID) AS efe
 FROM VISTIMA AS V,CONTACTO AS CONT 
 INNER JOIN DESC_ASOCIADO as des on (des.ID_ASOCIADO=CONT.DESC_ASOCIADO_ID)
 
WHERE V.ID_VISTIMA=CONT.VISTIMA__ID and V.MUERTE !=''
 
GROUP BY V.ID_VISTIMA) AS T WHERE T.efe>3;


/* L AHICE DE 2 MANERAS XDXDXD ASI QUE NO SE CUAL ES LA CORRECTA JAJA**/


/* CONSULTA3 2.0**/

SELECT DISTINCT name_, apellido,direccion FROM(SELECT DISTINCT 
NOMBRE_VISTIMA as name_ , APELLIDO_VISTIMA as apellido,DIRECCION_VISTIMA  as direccion 
,COUNT(CONTACT.DESC_ASOCIADO_ID) AS efe
 FROM CONTACTO AS CONTACT,VISTIMA AS V  
 INNER JOIN Desc_Paciente AS D ON (ID_ESTADO_P=D.ID_ESTADO )
WHERE V.ID_VISTIMA=CONTACT.VISTIMA__ID and D.DESCP_ESTADO_PACIENTE="Muerte"

GROUP BY NOMBRE_VISTIMA,APELLIDO_VISTIMA,DIRECCION_VISTIMA) AS T WHERE T.efe>3;


USE Practica_MIA;
#CONSULTA 4


/**

Mostrar el nombre y apellido de todas las víctimas en estado “Suspendida”
que tuvieron contacto físico de tipo “Beso” con más de 2 de sus asociados.


*/
SELECT DISTINCT T.name_, T.apellido_
FROM(
SELECT  
T2.NOMBRE AS name_ , T2.APELLIDO AS apellido_,COUNT(T2.EFE) AS efe
 FROM(
 SELECT DISTINCT
 ID_VISTIMA AS  ORDER_, NOMBRE_VISTIMA AS NOMBRE , APELLIDO_VISTIMA AS APELLIDO , DESC_ASOCIADO_ID AS EFE
 FROM VISTIMA AS V, CONTACTO AS CONT, DESC_CONTACTO AS DESC_ , Desc_Paciente AS des , DESC_ASOCIADO AS DESC_A
 WHERE  CONT.DESC_CONTACTO_ID= DESC_.ID_CONTACTO  AND DESC_.DESC_CONTACT='Beso'
 AND des.ID_ESTADO=V.ID_ESTADO_P and des.DESCP_ESTADO_PACIENTE="Sospecha" AND
 DESC_A.ID_ASOCIADO=CONT.DESC_ASOCIADO_ID  and V.ID_VISTIMA=CONT.VISTIMA__ID
 
 )AS T2 GROUP BY ORDER_
 
 )AS T WHERE T.efe>2;

/*
SELECT DISTINCT T.name_, T.apellido_
FROM(
SELECT DISTINCT 
NOMBRE_VISTIMA as name_ , APELLIDO_VISTIMA as apellido_,COUNT(CONT.DESC_ASOCIADO_ID) AS efe
 FROM CONTACTO AS CONT,VISTIMA AS V 
 INNER JOIN Desc_Paciente as des on (V.ID_ESTADO_P=des.ID_ESTADO)
 INNER JOIN CONTACTO as C ON (V.ID_VISTIMA=C.VISTIMA__ID)
 INNER JOIN DESC_CONTACTO AS DESC_ ON (DESC_.ID_CONTACTO=C.DESC_CONTACTO_ID)
 INNER JOIN DESC_ASOCIADO AS DESC_A ON (DESC_A.ID_ASOCIADO=C.DESC_ASOCIADO_ID)
 WHERE DESC_A.ID_ASOCIADO=CONT.DESC_ASOCIADO_ID  and V.ID_VISTIMA=CONT.VISTIMA__ID
 AND  CONT.DESC_CONTACTO_ID= DESC_.ID_CONTACTO  AND DESC_.DESC_CONTACT='Beso'
 AND des.ID_ESTADO=V.ID_ESTADO_P and des.DESCP_ESTADO_PACIENTE="Sospecha"  
GROUP BY V.ID_VISTIMA) AS T WHERE T.efe>2;
*/
SELECT DISTINCT T.name_, T.apellido_,T.efe
FROM(
SELECT  
T2.NOMBRE AS name_ , T2.APELLIDO AS apellido_,COUNT(T2.EFE) AS efe
 FROM(
 SELECT DISTINCT
 ID_VISTIMA AS  ORDER_, NOMBRE_VISTIMA AS NOMBRE , APELLIDO_VISTIMA AS APELLIDO , DESC_ASOCIADO_ID AS EFE
 FROM VISTIMA AS V, CONTACTO AS CONT, DESC_CONTACTO AS DESC_ , Desc_Paciente AS des , DESC_ASOCIADO AS DESC_A
 WHERE  CONT.DESC_CONTACTO_ID= DESC_.ID_CONTACTO  AND DESC_.DESC_CONTACT='Beso'
 AND des.ID_ESTADO=V.ID_ESTADO_P and des.DESCP_ESTADO_PACIENTE="Sospecha" AND
 DESC_A.ID_ASOCIADO=CONT.DESC_ASOCIADO_ID  and V.ID_VISTIMA=CONT.VISTIMA__ID
 
 )AS T2 GROUP BY ORDER_
 
 )AS T WHERE T.efe>2 ORDER BY T.efe;



#CONSULTA 5


SELECT DISTINCT NOMBRE_VISTIMA ,APELLIDO_VISTIMA, COUNT(DEF_TRATAMIENTO.VISTIMA_ID) AS CONT FROM DEF_TRATAMIENTO, VISTIMA AS V 
INNER JOIN DEF_TRATAMIENTO AS DEF_T ON(DEF_T.VISTIMA_ID =V.ID_VISTIMA)
INNER JOIN Tratamiento_Aplicado AS T ON(T.ID_TRATAMIENTO = DEF_T.ID_TRATAMIENTO_APLICADO)
WHERE T.NOMBRE_TRATAMIENTO="Oxígeno"
GROUP BY ID_VISTIMA order by CONT LIMIT 5;

#CONSULTA 6
/**

Mostrar el nombre, el apellido y la fecha de fallecimiento de todas las
víctimas que se movieron por la dirección “1987 Delphine Well” a los cuales
se les aplicó "Manejo de la presión arterial" como tratamiento.

*/

SELECT DISTINCT NOMBRE_VISTIMA ,APELLIDO_VISTIMA,  MUERTE  FROM DEF_TRATAMIENTO, VISTIMA AS V 
INNER JOIN DEF_TRATAMIENTO AS DEF_T ON(DEF_T.VISTIMA_ID =V.ID_VISTIMA)
INNER JOIN Tratamiento_Aplicado AS T ON(T.ID_TRATAMIENTO = DEF_T.ID_TRATAMIENTO_APLICADO)
INNER JOIN VISITAS AS VIS ON (VIS.VISTIMA_IDS=VISTIMA_ID)
INNER JOIN LUGARES_VISITADOS AS L ON (L.ID_LUGAR=VIS.UBICACION_ID)

WHERE T.NOMBRE_TRATAMIENTO="Manejo de la presión arterial" AND L.LUGAR="1987 Delphine Well" 
GROUP BY ID_VISTIMA ;



#CONSULTA 7


/**
Mostrar nombre, apellido y dirección de las víctimas que tienen menos de 2
allegados los cuales hayan estado en un hospital y que se le hayan aplicado
únicamente dos tratamientos.


*/


USE Practica_MIA;
SELECT DISTINCT NOMBRE_VISTIMA, APELLIDO_VISTIMA,DIRECCION_VISTIMA 
FROM VISTIMA 
INNER JOIN  DEF_TRATAMIENTO AS DEF ON(VISTIMA.ID_VISTIMA=DEF.VISTIMA_ID)
AND (
SELECT COUNT(DEF_TRATAMIENTO.VISTIMA_ID) FROM DEF_TRATAMIENTO
WHERE DEF_TRATAMIENTO.VISTIMA_ID =VISTIMA.ID_VISTIMA
)=2
INNER JOIN  CONTACTO AS CONT ON(CONT.VISTIMA__ID=VISTIMA.ID_VISTIMA)

 AND( SELECT COUNT(CONTACTO.VISTIMA__ID) FROM CONTACTO
WHERE CONTACTO.VISTIMA__ID =VISTIMA.ID_VISTIMA
)<2
AND VISTIMA.HOSPITAL!=""
LIMIT 4;



#CONSULTA 8


/**

Mostrar el número de mes ,de la fecha de la primera sospecha, nombre y
apellido de las víctimas que más tratamientos se han aplicado y las que
menos. (Todo en una sola consulta).


*/


(SELECT MONTH(FECHA_SOSPECHA) , NOMBRE_VISTIMA , APELLIDO_VISTIMA , COUNT(DEF.VISTIMA_ID) 
AS CONT FROM   VISTIMA AS V  
LEFT JOIN DEF_TRATAMIENTO AS DEF  ON (DEF.VISTIMA_ID = V.ID_VISTIMA)
GROUP BY ID_VISTIMA  ORDER BY CONT DESC LIMIT 5)
UNION (
SELECT MONTH(FECHA_SOSPECHA) , NOMBRE_VISTIMA , APELLIDO_VISTIMA , COUNT(DEF.VISTIMA_ID) 
AS CONT FROM   VISTIMA AS V  
LEFT JOIN DEF_TRATAMIENTO AS DEF  ON (DEF.VISTIMA_ID = V.ID_VISTIMA)
GROUP BY ID_VISTIMA  ORDER BY CONT ASC LIMIT 5);



#CONSULTA 9

/*
9. Mostrar el porcentaje de víctimas que le corresponden a cada hospital.
1. OBTENER EL TOTAL DE VICTIMAS  DONDE HOSPITAL SEA DIFERENTE DE NULL

*/
SELECT HOSPITAL_  , 100*(V.TOTAL_V/H.TOTAL_H ) AS RESULTADO_PORCENTAJE FROM
  (SELECT NOMBRE__HOSPITAL AS HOSPITAL_, COUNT(VI.ID_VISTIMA                 ) AS TOTAL_V
FROM HOSPITAL_COVID
LEFT JOIN VISTIMA AS VI ON (VI.HOSPITAL=HOSPITAL_COVID.NOMBRE__HOSPITAL) GROUP BY 
HOSPITAL_COVID.ID_HOSPITAL
)AS V ,
(
SELECT COUNT(ID_VISTIMA) AS TOTAL_H  FROM VISTIMA WHERE HOSPITAL!=""

) AS H ;
# CONSULTA 10
/*
. Mostrar el porcentaje del contacto físico más común de cada hospital de la
siguiente manera: nombre de hospital, nombre del contacto físico, porcentaje
de víctimas.


**/
/*MAX(SUM(CONSULTA.CONT)) AS MAX_CONT*/
#CONSULTA 10
USE Practica_MIA;
SELECT  N_H,N_C ,  SUM_CONT  FROM(
SELECT VISTIMA.HOSPITAL AS N_H,CONSULTA.DESC_CONTACT AS N_C, SUM(CONSULTA.CONT) AS SUM_CONT 
,ROW_NUMBER() OVER (PARTITION BY VISTIMA.HOSPITAL  ORDER BY SUM(CONSULTA.CONT) DESC   ) AS row_num
 FROM 
 
 (SELECT NOMBRE__HOSPITAL AS HOSPITAL_, COUNT(VI.ID_VISTIMA                 ) AS TOTAL_V
FROM HOSPITAL_COVID
LEFT JOIN VISTIMA AS VI ON (VI.HOSPITAL=HOSPITAL_COVID.NOMBRE__HOSPITAL) GROUP BY 
HOSPITAL_COVID.ID_HOSPITAL
)AS V,
 (
 
 
SELECT VISTIMA__ID,DESC_CONTACT , COUNT(DESC_CONTACTO_ID) AS CONT FROM  CONTACTO , DESC_CONTACTO 
WHERE DESC_CONTACTO.ID_CONTACTO = CONTACTO.DESC_CONTACTO_ID
group by VISTIMA__ID,DESC_CONTACTO.DESC_CONTACT) AS CONSULTA,VISTIMA 
WHERE VISTIMA.ID_VISTIMA=CONSULTA.VISTIMA__ID AND HOSPITAL!="" 
GROUP BY VISTIMA.HOSPITAL,CONSULTA.DESC_CONTACT  ORDER BY   VISTIMA.HOSPITAL,SUM_CONT DESC

) AS PRINCIPAL WHERE row_num =1 
