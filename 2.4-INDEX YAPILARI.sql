/*
	INDEX; VERILERIN ALANINA GORE SIRALANMIS VE TABLO HALINI ALMIS SEKLIDIR. 
	BELIRLI BIR SIRA DUZENINE GECMEK ICIN INDEKS YAPISI KULLANILIR.

	INDEX TIPLERI;
	1-  CLUSTERED / KUMELENMIS
	2-  NONCLUSTERED / KUMELENMEMIS
	3-  UNIQUE / TEKIL
*/

USE BussinesLife
SELECT * FROM PERSON

--SORGU YOLUYLA MEVCUT TABLO ICERISINDE BIR SUTUNA GORE INDEX OLUSTURMAK
--KURDUGUMUZ BU INDEX 'nonclustered located on PRIMARY' OZELLIGINDEDIR
CREATE INDEX IX_tablePerson_ID ON PERSON (ID ASC)

--MEVCUT OLARAK HERHANGI BIR TABLONUN INDEX YAPISININ BULUNUP BULUNMADIGINA DAIR BILGI ALMAK ICIN
sp_Helpindex PERSON

--MEVCUT HERHANGI BIR INDEX YAPISINI KALDIRMAK ISTERSEK
DROP INDEX PERSON.IX_tablePerson_ID 


SELECT * FROM PERSON P
ORDER BY P.ID DESC

--KUMELENMIS INDEKSLEME ICIN / VARSAYILAN INDEKS TIPIDIR
CREATE CLUSTERED INDEX IX_tblPERSONDEPARTMENT ON PERSON (DepartmentID ASC)

--KUMELENMEMIS INDEKSLEME ICIN
CREATE NONCLUSTERED INDEX IX_tblPERSONDEPARTMENT ON PERSON (DepartmentID ASC)