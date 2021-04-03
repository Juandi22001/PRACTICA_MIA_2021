
#practica 1 Manejo e implementacion de archivos 
#en este  sql solo sera unicamente para llenar la TABLA TEMPORAAAAAL :v jajaj 
use Practica_MIA;


CREATE TABLE TemporalR1(
 /*Estoy creando esta tabla temporal porque esto es lo que viene en teoria del csv entonces aqui la lleno y nitido 
*/NOMBRE_VICTIMA VARCHAR(200), APELLIDO_VICTIMA VARCHAR(200), DIRECCION_VICTIMA VARCHAR(200),
FECHA_PRIMERA_SOSPECHA VARCHAR(200) ,FECHA_CONFIRMACION VARCHAR(200),FECHA_MUERTE VARCHAR(200), ESTADO_VICTIMA VARCHAR(200),
NOMBRE_ASOCIADO VARCHAR(200), APELLIDO_ASOCIADO VARCHAR(200),FECHA_CONOCIO VARCHAR(200) , CONTACTO_FISICO VARCHAR(200),
FECHA_INICIO_CONTACTO VARCHAR(200), FECHA_FIN_CONTACTO VARCHAR(200) , NOMBRE_HOSPITAL VARCHAR(200), DIRECCION_HOSPITAL VARCHAR(200),
UBICACION_VICTIMA VARCHAR(200) ,FECHA_LLEGADA VARCHAR(200), FECHA_RETIRO VARCHAR (200),TRATAMIENTO VARCHAR(200), EFECTIVIDAD INT  ,
 FECHA_INICIO_TRATAMIENTO VARCHAR(200), FECHA_FIN_TRATAMIENTO VARCHAR(200), EFECTIVIDAD_EN_VICTIMA INT 
);
load data infile '/var/lib/mysql-files/GRAND_VIRUS_EPICENTER.csv' INTO TABLE TemporalR1
    character set latin1
    fields terminated by ';'
    lines terminated by '\n'
    ignore 1 lines
    (@nombre_victima , @apellido_victima,@direccion_victima,
@fecha_primera_sospecha ,@fecha_confirmacion ,@fecha_muerte, @estado_victima ,
@nombre_asociado,@apellido_asociado,@fecha_conocio , @contacto_fisico,
@fecha_inicio_contacto , @fecha_fin_contacto  , @nombre_hospital,@direccion_hospital ,
@ubicacion_victima  ,@fecha_llegada,@fecha_retiro, @tratamiento ,@efectividad,
 @fecha_inicio_tratamiento , @fecha_fin_tratamiento , @efectividad_en_victima )
SET EFECTIVIDAD =nullif(@efectividad,''),
 EFECTIVIDAD_EN_VICTIMA=nullif(@efectividad_en_victima,'')
,NOMBRE_VICTIMA=nullif(@nombre_victima,''),APELLIDO_VICTIMA=nullif(@apellido_victima,'')
,DIRECCION_VICTIMA=nullif(@direccion_victima,''),FECHA_PRIMERA_SOSPECHA=nullif(@fecha_primera_sospecha,'')
,FECHA_CONFIRMACION=nullif(@fecha_confirmacion,''),FECHA_MUERTE=nullif(@fecha_muerte,'')
,ESTADO_VICTIMA=nullif(@estado_victima,''),NOMBRE_ASOCIADO=nullif(@nombre_asociado,'')
,APELLIDO_ASOCIADO=nullif(@apellido_asociado,''),FECHA_CONOCIO=nullif(@fecha_conocio,'')
,CONTACTO_FISICO=nullif(@contacto_fisico,''),FECHA_INICIO_CONTACTO=nullif(@fecha_inicio_contacto,'')
,FECHA_FIN_CONTACTO=nullif(@fecha_fin_contacto,''),NOMBRE_HOSPITAL=nullif(@nombre_hospital,'')
,DIRECCION_HOSPITAL=nullif(@direccion_hospital,''),UBICACION_VICTIMA=nullif(@ubicacion_victima,'')
,FECHA_LLEGADA=nullif(@fecha_llegada,''),FECHA_RETIRO=nullif(@fecha_retiro,'')
,TRATAMIENTO=nullif(@tratamiento,''),FECHA_INICIO_TRATAMIENTO=nullif(@fecha_inicio_tratamiento,'')
,FECHA_FIN_TRATAMIENTO=nullif(@fecha_fin_tratamiento,'')
;






CREATE TABLE TemporalR(
 /*Estoy creando esta tabla temporal porque esto es lo que viene en teoria del csv entonces aqui la lleno y nitido 
*/NOMBRE_VICTIMA VARCHAR(200), APELLIDO_VICTIMA VARCHAR(200), DIRECCION_VICTIMA VARCHAR(200),
FECHA_PRIMERA_SOSPECHA DATETIME ,FECHA_CONFIRMACION DATETIME,FECHA_MUERTE DATETIME, ESTADO_VICTIMA VARCHAR(200),
NOMBRE_ASOCIADO VARCHAR(200), APELLIDO_ASOCIADO VARCHAR(200),FECHA_CONOCIO DATETIME , CONTACTO_FISICO VARCHAR(200),
FECHA_INICIO_CONTACTO DATETIME, FECHA_FIN_CONTACTO DATETIME , NOMBRE_HOSPITAL VARCHAR(200), DIRECCION_HOSPITAL VARCHAR(200),
UBICACION_VICTIMA VARCHAR(200) ,FECHA_LLEGADA DATETIME, FECHA_RETIRO DATETIME,TRATAMIENTO VARCHAR(200), EFECTIVIDAD INT  ,
 FECHA_INICIO_TRATAMIENTO DATETIME, FECHA_FIN_TRATAMIENTO DATETIME, EFECTIVIDAD_EN_VICTIMA INT 
);
   
INSERT INTO TemporalR ( NOMBRE_VICTIMA , APELLIDO_VICTIMA , DIRECCION_VICTIMA ,
FECHA_PRIMERA_SOSPECHA  ,FECHA_CONFIRMACION ,FECHA_MUERTE, ESTADO_VICTIMA ,
NOMBRE_ASOCIADO , APELLIDO_ASOCIADO ,FECHA_CONOCIO  , CONTACTO_FISICO ,
FECHA_INICIO_CONTACTO , FECHA_FIN_CONTACTO  , NOMBRE_HOSPITAL , DIRECCION_HOSPITAL ,
UBICACION_VICTIMA  ,FECHA_LLEGADA ,FECHA_RETIRO, TRATAMIENTO , EFECTIVIDAD  ,
 FECHA_INICIO_TRATAMIENTO , FECHA_FIN_TRATAMIENTO , EFECTIVIDAD_EN_VICTIMA )

SELECT  NOMBRE_VICTIMA , APELLIDO_VICTIMA , DIRECCION_VICTIMA ,
FECHA_PRIMERA_SOSPECHA  ,FECHA_CONFIRMACION ,FECHA_MUERTE, ESTADO_VICTIMA ,
NOMBRE_ASOCIADO , APELLIDO_ASOCIADO ,FECHA_CONOCIO  , CONTACTO_FISICO ,
FECHA_INICIO_CONTACTO , FECHA_FIN_CONTACTO  , NOMBRE_HOSPITAL , DIRECCION_HOSPITAL ,
UBICACION_VICTIMA  ,FECHA_LLEGADA ,FECHA_RETIRO, TRATAMIENTO , EFECTIVIDAD  ,
 FECHA_INICIO_TRATAMIENTO , FECHA_FIN_TRATAMIENTO , EFECTIVIDAD_EN_VICTIMA 
 FROM TemporalR1;
