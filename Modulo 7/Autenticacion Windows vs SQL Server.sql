USE TiendaPractica
GO
/*
			AUTENTICACION: WINDOWS VS SQL SERVER

	Windows Authentication: la opción por defecto y más recomendada en empresas 
							 con dominio de Active Directory — para empleados 
							 internos (DBAs, desarrolladores).

	SQL Server Authentication: para aplicaciones externas, conexiones desde fuera del dominio,
							   o entornos sin Windows.
*/

--AUTENTICACION WINDOWS
/*	usa las credenciales de Windows con las que ya iniciaste sesión en la 
	PC — no pide usuario/contraseña aparte, SQL Server confía en que Windows 
	ya te validó. Es el modo que usaste sin querer durante todo el módulo.
*/
CREATE LOGIN [DESKTOP-7CSH9I5\Alexander] FROM WINDOWS;

--AUTENTICACION SQL SERVER
/*	usuario y contraseña propios de SQL Server, independientes de Windows — es lo 
	que intentamos usar con Alex/AlexSQL.

	Ventajas:
	---> Necesario cuando el cliente no es Windows (una app web, una app desde Linux/Mac,
		 conexiones desde fuera del dominio corporativo).
	---> Permite crear cuentas de servicio para aplicaciones, sin depender de una cuenta 
		 de Windows real.
*/
CREATE LOGIN Alex WITH PASSWORD = 'Clave123!';

--MODO MIXTO
/*	permite ambos modos a la vez en el mismo servidor — confirmaste que tu LocalDB ya 
	lo tenía activado (IsIntegratedSecurityOnly = 0), por eso técnicamente sí podías 
	crear el login Alex, aunque tuvimos ese lío con la conexión.
*/

---- Se configura en las propiedades del servidor (Server Properties → Security), no por código

/*	💡 Lección de tu propia experiencia: cuando algo "no bloquea como debería", lo primero a verificar 
	 es con qué cuenta estás realmente conectado (SUSER_NAME()) — fue la causa real de tu confusión, 
	 no un bug de SQL Server.
*/