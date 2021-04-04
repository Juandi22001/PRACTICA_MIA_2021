

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

SELECT DISTINCT T.name_, T.apellido_,T.direccion_ FROM(SELECT DISTINCT 
NOMBRE_VISTIMA as name_ , APELLIDO_VISTIMA as apellido_,DIRECCION_VISTIMA  as direccion_ 
,COUNT(CONT.DESC_ASOCIADO_ID) AS efe
 FROM VISTIMA AS V ,CONTACTO AS CONT
 
WHERE V.ID_VISTIMA=CONT.VISTIMA__ID and V.MUERTE IS NOT NULL

GROUP BY NOMBRE_VISTIMA,APELLIDO_VISTIMA,DIRECCION_VISTIMA) AS T WHERE T.efe>3;

/* L AHICE DE 2 MANERAS XDXDXD ASI QUE NO SE CUAL ES LA CORRECTA JAJA**/


/* CONSULTA3 2.0**/

SELECT DISTINCT name_, apellido,direccion FROM(SELECT DISTINCT 
NOMBRE_VISTIMA as name_ , APELLIDO_VISTIMA as apellido,DIRECCION_VISTIMA  as direccion 
,COUNT(CONTACT.DESC_ASOCIADO_ID) AS efe
 FROM CONTACTO AS CONTACT,VISTIMA AS V  
 INNER JOIN Desc_Paciente AS D ON (ID_ESTADO_P=D.ID_ESTADO )
WHERE V.ID_VISTIMA=CONTACT.VISTIMA__ID and D.DESCP_ESTADO_PACIENTE="Muerte"

GROUP BY NOMBRE_VISTIMA,APELLIDO_VISTIMA,DIRECCION_VISTIMA) AS T WHERE T.efe>3;

#CONSULTA 4


/**

Mostrar el nombre y apellido de todas las víctimas en estado “Suspendida”
que tuvieron contacto físico de tipo “Beso” con más de 2 de sus asociados.


*/


#CONSULTA 5


/**

Top 5 de víctimas que más tratamientos se han aplicado del tratamiento
“Oxígeno”.

*/
