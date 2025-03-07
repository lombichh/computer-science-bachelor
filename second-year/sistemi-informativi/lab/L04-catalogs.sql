-- Esercizio 2

/* Creare la vista CAT_SAMENAME(TABNAME, SAMEBEFORE, SAMEAFTER) che per ogni table
o view nel proprio schema mostra il numero di (altre) table o view con lo
stesso nome nel DB SIT_STUD create prima (SAMEBEFORE) e dopo (SAMEAFTER) */
CREATE VIEW CAT_SAMENAME(TABNAME, SAMEBEFORE, SAMEAFTER)
AS WITH SAMEBEFORE(TABNAME, SAMEBEFORE)
		AS (
			SELECT t1.TABNAME, COUNT(t2.TABNAME)
			FROM SYSCAT.TABLES t1 LEFT JOIN SYSCAT.TABLES t2 ON
				(t1.TABNAME = t2.TABNAME
				AND t2.CREATE_TIME < t1.CREATE_TIME
				AND NOT(t2.TABSCHEMA = 'A1071217'))
			WHERE t1.TYPE  = 'T'
				AND t1.TABSCHEMA = 'A1071217'
			GROUP BY t1.TABNAME
		),
		SAMEAFTER(TABNAME, SAMEAFTER)
		AS (
			SELECT t1.TABNAME, COUNT(t2.TABNAME)
			FROM SYSCAT.TABLES t1 LEFT JOIN SYSCAT.TABLES t2 ON
				(t1.TABNAME = t2.TABNAME
				AND t2.CREATE_TIME > t1.CREATE_TIME
				AND NOT(t2.TABSCHEMA = 'A1071217'))
			WHERE t1.TYPE = 'T'
				AND t1.TABSCHEMA = 'A1071217'
			GROUP BY t1.TABNAME
		)
	SELECT sb.TABNAME, sb.SAMEBEFORE, sa.SAMEAFTER
	FROM SAMEBEFORE sb JOIN SAMEAFTER sa ON
		(sb.TABNAME = sa.TABNAME)

/* Creare la vista CAT_TABDIFF(MYTABNAME, YOURSCHEMA, DIFFCOLUMN, DIFF) che per ogni
table o view del proprio schema e definita con lo stesso nome anche in altri schemi,
mostra le eventuali differenze esistenti sui nomi degli attributi definiti.
Ogni tupla riporta:
- il nome di una table del proprio schema,
- il nome di un altro schema in cui si trova una table con lo stesso nome
- il nome di una colonna in cui le 2 table differiscono
- DIFF = '+' se la colonna è definita nell'altra table e non nella propria, DIFF = '-' altrimenti*/
CREATE VIEW CAT_TABDIFF(MYTABNAME,YOURSCHEMA,DIFFCOLUMN,DIFF)
AS (
	SELECT c.TABNAME, t.TABSCHEMA, c.COLNAME, '+' -- tutte le colonne presenti nelle mie tables ma non presenti in altre
	FROM SYSCAT.TABLES t, SYSCAT.COLUMNS c
	WHERE NOT(t.TABSCHEMA = 'A1071217')
		AND c.TABSCHEMA = 'A1071217'
		AND c.TABNAME = t.TABNAME
		AND c.COLNAME NOT IN (
			SELECT c1.COLNAME -- i nomi di tutte le colonne presenti in t
			FROM SYSCAT.COLUMNS c1
			WHERE c1.TABSCHEMA = t.TABSCHEMA
				AND c1.TABNAME = t.TABNAME
		)
	UNION
	SELECT t.TABNAME, c.TABSCHEMA, c.COLNAME, '-' -- tutte le colonne non presenti nelle mie tables
	FROM SYSCAT.TABLES t, SYSCAT.COLUMNS c
	WHERE t.TABSCHEMA = 'A1071217'
		AND NOT(c.TABSCHEMA = 'A1071217')
		AND c.TABNAME = t.TABNAME
		AND c.COLNAME NOT IN (
			SELECT c1.COLNAME -- i nomi di tutte le colonne presenti in t
			FROM SYSCAT.COLUMNS c1
			WHERE c1.TABSCHEMA = 'A1071217'
				AND c1.TABNAME = t.TABNAME
		)
)