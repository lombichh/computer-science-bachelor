SET CURRENT SCHEMA DB2INST1

-- Q1) Il numero dei dipartimenti con almeno 7 dipendenti

SELECT COUNT(*) AS NUM_DIP_7_EMP
FROM DEPARTMENT d
WHERE (SELECT COUNT(*)
	FROM EMPLOYEE e
	WHERE e.WORKDEPT = d.DEPTNO) >= 7;

-- Q2) I dati dei dipendenti che lavorano in un dipartimento con almeno 7 dipendenti

SELECT *
FROM EMPLOYEE e1
WHERE (SELECT COUNT(*)
	FROM EMPLOYEE e2
	WHERE e2.WORKDEPT = e1.WORKDEPT) >= 7;

-- Q3) I dati del dipartimento con il maggior numero di dipendenti

SELECT *
FROM DEPARTMENT d1
WHERE (SELECT COUNT(*)
	FROM EMPLOYEE e1
	WHERE e1.WORKDEPT = d1.DEPTNO) 
	>= ALL (SELECT COUNT(*)
	FROM DEPARTMENT d2, EMPLOYEE e2
	WHERE e2.WORKDEPT = d2.DEPTNO
	GROUP BY d2.DEPTNO);
	
-- Q4) Il nome delle regioni e il totale delle vendite per ogni regione con un totale di vendite
-- maggiore di 30, ordinando per totale vendite decrescente

SELECT s.REGION, SUM(s.SALES) AS SUM_SALES
FROM SALES s
GROUP BY s.REGION
	HAVING SUM(s.SALES) >= 30
ORDER BY SUM_SALES DESC;

-- Q5) Lo stipendio medio degli impiegati che non sono manager di nessun dipartimento

SELECT CAST(AVG(e.SALARY) AS DECIMAL(8, 2)) AS AVG_SALARY
FROM DEPARTMENT d, EMPLOYEE e
WHERE e.WORKDEPT = d.DEPTNO 
	AND NOT(e.EMPNO = d.MGRNO)
	
-- Q6) I dipartimenti che non hanno impiegati il cui cognome inizia per ‘L’
	
SELECT *
FROM DEPARTMENT d
WHERE NOT EXISTS (SELECT *
	FROM EMPLOYEE e
	WHERE e.WORKDEPT = d.DEPTNO
	AND e.LASTNAME LIKE 'L%')

-- Q7) I dipartimenti e il rispettivo massimo stipendio per tutti i dipartimenti aventi un salario
-- medio minore del salario medio calcolato considerando i dipendenti di tutti gli altri
-- dipartimenti
	
SELECT d.DEPTNO, MAX(e.SALARY) AS AVG_SALARY
FROM DEPARTMENT d, EMPLOYEE e
WHERE e.WORKDEPT = d.DEPTNO
GROUP BY d.DEPTNO
HAVING AVG(e.SALARY) < (SELECT AVG(e1.SALARY)
	FROM EMPLOYEE e1
	WHERE NOT (e1.WORKDEPT = d.DEPTNO))

-- Q8) Per ogni dipartimento determinare lo stipendio medio per ogni lavoro per il quale il
-- livello di educazione medio è maggiore di quello degli impiegati dello stesso
-- dipartimento che fanno un lavoro differente
	
SELECT e1.WORKDEPT, e1.JOB, AVG(e1.SALARY) AS AVG_SALARY
FROM EMPLOYEE e1
GROUP BY e1.WORKDEPT, e1.JOB
HAVING AVG(e1.EDLEVEL / 1.0) > (
	SELECT AVG(e2.EDLEVEL / 1.0)
	FROM EMPLOYEE e2
	WHERE e2.WORKDEPT = e1.WORKDEPT 
		AND e2.JOB <> e1.JOB);

-- Q9) Lo stipendio medio degli impiegati che non sono addetti alle vendite
	
SELECT CAST(AVG(e.SALARY) AS DECIMAL(8, 2)) AS AVG_SALARY
FROM EMPLOYEE e LEFT OUTER JOIN SALES s ON (e.LASTNAME = s.SALES_PERSON)
WHERE s.REGION IS NULL

-- Q10) Per ogni regione, i dati dell’impiegato che ha il maggior numero di vendite
-- (SUM(SALES)) in quella regione

SELECT DISTINCT s.REGION, e.*
FROM SALES s, EMPLOYEE e
WHERE s.SALES_PERSON = e.LASTNAME
	AND (
		SELECT SUM(s1.SALES) -- sales of e in s.region
		FROM SALES s1
		WHERE s1.SALES_PERSON = e.LASTNAME
			AND s1.REGION = s.REGION
		) > ALL (
		SELECT SUM(s2.SALES) -- sales of other employees in s.region
		FROM SALES s2, EMPLOYEE e2
		WHERE NOT(e2.EMPNO = e.EMPNO)
			AND s2.SALES_PERSON = e2.LASTNAME
			AND s2.REGION = s.REGION
		GROUP BY e2.EMPNO
		);

-- Q11) I codici dei dipendenti che svolgono un'attivita' per la quale ogni tupla di EMPPROJACT 
--	riguarda un periodo minore di 200 giorni
SELECT DISTINCT e1.EMPNO
FROM EMPPROJACT e1
WHERE NOT EXISTS (
	SELECT *
	FROM EMPPROJACT e2
	WHERE e2.ACTNO = e1.ACTNO
		AND (DAYS(e2.EMENDATE) - DAYS(e2.EMSTDATE)) >= 200
)
