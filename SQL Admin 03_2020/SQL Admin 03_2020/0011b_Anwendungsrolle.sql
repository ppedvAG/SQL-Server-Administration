use whoamiDB

--Anwendungsrolle in der DB anlegen mit Kennwort


--wird in der Software aktiviert...
sp_setapprole 'Gehaltsrolle', 'ppedv2019!'



--nu darf der USer nur noch das tun, was die Rechte der Rolle hergibt

--gilt auch für den Admin
--gilt nur in der Verbindung , ider wir die Rolle aktiviern 
--(Session 54 etwa)
use master

update

