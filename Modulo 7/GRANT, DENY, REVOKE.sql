Use TiendaPractica
Go
/*
						GRANT, DENY, REVOKE

	GRANT = otorga. DENY = bloquea explícito (gana siempre).
	REVOKE = quita el permiso otorgado antes (neutral, no bloquea).
	💡 Pregunta típica de entrevista: "si un usuario tiene GRANT por 
	un rol y DENY directo, ¿qué gana?" → siempre DENY.
*/
--otorga el permiso.
GRANT SELECT ON cliente to Alexander;

/*	DENY -> bloquea explícitamente el permiso — y esto es clave: DENY siempre gana,
	sin importar si el usuario tiene GRANT por otro lado (directo o por un rol). 
	Es la máxima prioridad en el sistema de permisos de SQL Server */

DENY SELECT ON Cliente TO Alexander;

/*	REVOKE -> quita el permiso — pero a diferencia de DENY, esto deja al usuario en 
			  un estado "neutral" (ni permitido ni bloqueado explícitamente). Si el 
			  usuario tiene ese mismo permiso por otro camino (ej: un rol), REVOKE 
			  no lo afecta ahí.
*/
REVOKE SELECT ON Cliente FROM Alexander;

--EJEMPLO PRACTICO USANDO AL USUARIO ALEXANDER

GRANT SELECT ON Cliente TO rol_programador; -- Alex es miembro, tiene acceso
DENY SELECT ON Cliente TO Alexander;   -- Ahora Alex específicamente NO puede, aunque su rol sí tenga permiso

/*	Aunque rol_programador (al que pertenece Alex) tenga GRANT, el DENY directo 
	sobre Alex anula todo — ni siquiera importa el orden en que se ejecutaron 
	los comandos.*/


--Ahora desbloqueamos a ALEXANDER con REVOKE pero de forma neutral 
REVOKE SELECT ON cliente FROM Alexander;

--IMPORTANTE 
/*
	💡 REVOKE = deja sin permiso en este momento específico, pero no impide 
				que vuelva a tenerlo después (por otro GRANT, o un rol).
	💡 DENY = bloquea de forma permanente y absoluta, hasta que alguien 
			  explícitamente haga REVOKE sobre ese DENY.
	💡 La diferencia real: REVOKE es "neutral, reversible fácilmente". DENY 
						   es "bloqueo con candado, necesita acción explícita para quitarlo".
*/