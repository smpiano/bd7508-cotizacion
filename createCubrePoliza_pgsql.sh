#!/bin/bash
java_ver=$(java -version 2>&1 | grep version | cut -f2 -d\" | cut -f1,2 -d\. | sed 's/\.//')
if [ $java_ver -ge 17 ]
then
	mkdir -p build/schema
	dropdb -h localhost -U postgres 'cubrepoliza'
	createdb -h localhost -U postgres 'cubrepoliza'
	psql -h localhost -U postgres -d 'cubrepoliza' < scripts/script_creacion_db.sql
	java -jar tools/schemaSpy_5.0.0.jar -t pgsql -dp tools/postgresql-9.3-1100.jdbc41.jar -host localhost -db 'cubrepoliza' -s public -u postgres -o build/schema
	#After generation copy diagram to doc/diagramas/rel2.png
	cp build/schema/diagrams/summary/relationships.real.large.png doc/diagramas/rel2.png
else
	echo "no java or older version. Need 1.7"
fi
