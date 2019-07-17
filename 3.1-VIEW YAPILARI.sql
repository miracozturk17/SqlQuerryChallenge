/*
SQL SERVER UZERINDE HAZIRLANMIS SORGULARI OZELLESTIRILMIS TABLOLAR VASITASIYLA TUTMA IMKANIMIZ VARDIR.

SQL SERVERDAN BESLENEN HERHANGI BIR ARABIRIME VERI ILETIMI YAPARKEN MEVCUT 
						VERILERI HAZIR BIR SEKILDE SUNMAMAIZI SAGLAYAN VIEW YAPISI BIZE DESTEK VERIRIR.

		GENEL ITIBARI ILE VIEW YAPISI;

		CREATE VIEW [VIEW ADI]
		AS
		--WITH ENCRYPTION / OPSIYONEL
		SORGU OBEGI
*/

USE BussinesLife

--PERSONEL KART BILGILERINI SAGLAYAN SORGUMU VIEW YAPISI UZERINE TASIYALIM
CREATE VIEW vWPersonalCardDetail 
AS
SELECT 
	Name,EMail,Age,City,BirthDate,Department,DepartmentManager 
FROM PERSON P 
INNER JOIN DEPARTMENT D ON D.DepartmentID=P.DepartmentID

--VIEW YAPIMIZI DUZENLEMEK ICIN
ALTER VIEW vWPersonalCardDetail 
AS
SELECT 
	Name,EMail,Age,City,BirthDate,Department,DepartmentManager 
FROM PERSON P 
INNER JOIN DEPARTMENT D ON D.DepartmentID=P.DepartmentID

--VIEW ICERIGINI sp_helptext ILE SORGULAYABILIRIZ
sp_helptext vWPersonalCardDetail

--MEVCUT VIEW YAPIMIZI SILMEK ICIN


--VIEW TABLOSUNU GORUNTULEMEK ICIN
SELECT * FROM vWPersonalCardDetail

--GROUP BY VEYA WHERE CLAUSE YAPILARI DOGRUDAN VIEW UZERINDE KISITLAMA OLUSTURABILIR 
SELECT * FROM vWPersonalCardDetail
WHERE Department='IT'

--HERHANGI BIR VIEW UZERINDE BELIRLI KOSULLAR BAZ ALINARAK VERI DUZENLEMESI YAPILMAK ISTENIRSE
UPDATE vWPersonalCardDetail
SET Name='BARBAROS' WHERE BirthDate='1971-05-03 00:00:00.000' AND EMail='se@gmailcom'

--HERHANGI BIR VIEW UZERINDE BELIRLI KOSULLAR BAZ ALINARAK VERI SILINMESI YAPILMAK ISTENIRSE
DELETE FROM  vWPersonalCardDetail WHERE Name=''

--HERHANGI BIR VIEWE VERI EKLENMEK ISTENIRSE
INSERT INTO vWPersonalCardDetail VALUES ('BERK','ber@gmailcom',28,'KIEV','1991-05-03 00:00:00.000','OPERATIONS','COO')

/*
EGER MEVCUT VIEW YAPINIZ BIRDEN COK TABLODA VERI ICERIYORSA ASAGIDAKI HATAYI ALIRSINIZ.

	View or function 'vWPersonalCardDetail' is not updatable because the modification affects multiple base tables.

COZUM ISE GIRILCEK KAYIDA AIT BILGILERIN ILISKILI TABLOLARA DA GIRILMESI.
*/

--HERHANGI BIR VIEW YAPIMIZI SIFRELEMEK ICIN
CREATE VIEW vWPersonalCardDetailCrypt 
WITH ENCRYPTION
AS
SELECT 
	Name,EMail,Age,City,BirthDate,Department,DepartmentManager 
FROM PERSON P 
INNER JOIN DEPARTMENT D ON D.DepartmentID=P.DepartmentID

--VIEW UZERINDE SCHEMA OLUSTURMAK ICIN
CREATE VIEW vWPersonalCardDetailSchema
WITH SCHEMABINDING --KEYWORD EKI KULLANILIR
AS
SELECT 
	Name,EMail,Age,City,BirthDate,Department,DepartmentManager 
FROM PERSON P 
INNER JOIN DEPARTMENT D ON D.DepartmentID=P.DepartmentID

--MEVCUT VIEW UZERINDE INDEX OLUSTURMAK ICIN
CREATE UNIQUE CLUSTERED INDEX UIX_vWPersonalCardDetail ON vWPersonalCardDetail(Name)

--GENEL VIEW ICERISINDEKI SUTUNLAR HAKKINDA BILGI ALMAK ICIN
SELECT 
	v.name AS [ViewTableName], c.name AS [ColumnName] 
FROM sys.columns c
INNER JOIN sys.views v ON c.object_id=v.object_id

/*
	BAZI DURUMLARDA MEVCUT VIEW YAPILARIMIZI GUNCELLEMEMIZ GEREKEBILIR

	DOGRUDAN SISTEM UZERINDEN TRIGGER VASITASI ILE BIR DINAMIK YAPIDA KURABILIRIZ.

	YA DA MANUEL OLARAK VIEW TABLOMUZU YENILEYEBILIRIZ.
*/
EXECUTE sp_refreshview vWPersonalCardDetail 