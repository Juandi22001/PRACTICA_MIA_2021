
use Practica_MIA
;


/**

Mostrar el nombre y apellido de todas las víctimas en estado “Suspendida”
que tuvieron contacto físico de tipo “Beso” con más de 2 de sus asociados.


*/


/**

Mostrar el nombre y apellido de todas las víctimas en estado “Suspendida”
que tuvieron contacto físico de tipo “Beso” con más de 2 de sus asociados.


*/


/**

Mostrar el nombre y apellido de todas las víctimas en estado “Suspendida”
que tuvieron contacto físico de tipo “Beso” con más de 2 de sus asociados.


*/
SELECT DISTINCT name_, apellido,direccion FROM(SELECT DISTINCT 
NOMBRE_VISTIMA as name_ , APELLIDO_VISTIMA as apellido,DIRECCION_VISTIMA  as direccion 
,COUNT(CONTACT.DESC_ASOCIADO_ID) AS efe
 FROM CONTACTO AS CONTACT,VISTIMA AS V  
 INNER JOIN Desc_Paciente AS D ON (ID_ESTADO_P=D.ID_ESTADO )
WHERE V.ID_VISTIMA=CONTACT.VISTIMA__ID and D.DESCP_ESTADO_PACIENTE="Muerte"

GROUP BY NOMBRE_VISTIMA,APELLIDO_VISTIMA,DIRECCION_VISTIMA) AS T WHERE T.efe>3;

