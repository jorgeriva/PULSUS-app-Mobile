# PULSUS app Mobile

Aplicación mobil desarrollada durante los laboratorios LABIC-ES por el equipo de Terceridade

## Problema actual
Cuando iniciamos sesión hacemos una llamada a la base de datos de supabase para tratar de obtener el tenant_id,
este se encuentra en el schema saas, no en el public. El problema se genera por que no somos capaces de acceder a
ese esquema. Las soluciones que encontramos implican lo siguiente.  1  await supabase.from('saas.tenants').select('id');
poner el saas. antes del nombre de la tabla, no da resultado. 2 cambiar algun permiso en supabase, por lo que hemos 
revisado los permisos están correctos.

