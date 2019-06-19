/*
SQL SERVER ICERISINDE BASIT ISLEMLERIMIZI GERCEKLESTIRMEMIZI SAGLAYAN STRING FONKSIYONLAR BULUNMAKTADIR.
*/
USE BussinesLife
SELECT * FROM PERSON

--ISTENILEN KARAKTERI ASCII KARAKTERI OLARAK DONDURMEYI SAGLAYAN SORGU
SELECT ASCII('M')

--VERILEN ASCII KODUNU KARAKTERE DONUSTUREN SORGU
SELECT CHAR(77)

--ALFABEMIZDEKI KARAKTERLERI BUYUK OLARAK ASCII KODU DONUSUMU ILE VEREN SORGU
 DECLARE @Start int
 SET @Start = 65
 WHILE (@Start <= 90)
 BEGIN
	PRINT CHAR(@Start)
	SET @Start = @Start +1
END

--ALFABEMIZDEKI KARAKTERLERI KUCUK OLARAK ASCII KODU DONUSUMU ILE VEREN SORGU
 DECLARE @Start int
 SET @Start = 97
 WHILE (@Start <= 122)
 BEGIN
	PRINT CHAR(@Start)
	SET @Start = @Start +1
END

--RAKAMLARI (0 DAHIL) ASCII KODU DONUSUMU ILE VEREN SORGU
 DECLARE @Start int
 SET @Start = 48
 WHILE (@Start <= 57)
 BEGIN
	PRINT CHAR(@Start)
	SET @Start = @Start +1
END

--LTRIM SOLDAN BOSLUK ICEREN VERILERDEKI BOSLUKLARI SILER
SELECT LTRIM(Name) FROM PERSON

--RTRIM SAGDAN BOSLUK ICEREN VERILERDEKI BOSLUKLARI SILER
SELECT RTRIM(Name) FROM PERSON

--LOWER VERILERI KUCUK HARFLERLE YAZDIRIR
SELECT LOWER(Name) FROM PERSON

--UPPER VERILERI BUYUK HARFLERLE YAZDIRIR
SELECT UPPER(Name) FROM PERSON

--REVERSE VERILERI TERSTEN YAZAR
SELECT REVERSE(Name) FROM PERSON

--LEN VERILERIN STRING OLARAK KAC KARAKTER ICERDIGINI DONDURUR(BOSLUKTA KARAKTERDIR)
SELECT LEN(Name) FROM PERSON

--LEFT SOLDAN VERI ICERISINDEKI KARAKTERLERIN ISTENILEN SAYI KADARLIK KISMINI DONDURUR
SELECT LEFT(Name,1) +'_'+LEFT(City,3)+'_'+LEFT(DepartmentID,1) AS Unuq�eId FROM PERSON

--RIGHT SAGDAN VERI ICERISINDEKI KARAKTERLERIN ISTENILEN SAYI KADARLIK KISMINI DONDURUR
SELECT RIGHT(Name,1) +'_'+RIGHT(City,3)+'_'+RIGHT(DepartmentID,1) AS Unuq�eId FROM PERSON

--CHARINDEX BASLANGICTAN VEYA OZEL KONUMDAN ISTENILEN KARAKTERE KADAR KAC KARAKTER OLDUGUNU DONDURUR
SELECT CHARINDEX('@',Email,1) FROM PERSON

--SUBSTRING ISTENILEN BIR KARAKTERDEN ISTENILEN YERE KADAR KARAKTERLERI KESIP ALIR
--DOMAINLERI VEREN SORGU
SELECT SUBSTRING(Email,CHARINDEX('@',Email,1)+1,50) AS Domain FROM PERSON
GROUP BY SUBSTRING(Email,CHARINDEX('@',Email,1)+1,50)
 
--REPLICATE ARD ARDA VEYA BELLI BIR SAYIDA KARAKTER YAZDIRMAK ICIN KULLANILIR
SELECT REPLICATE('MIRAC',3)

--EMAIL HESABINI GUVENLIGE ALMAK ICIN MASKELEME YAPILAN SORGU ORNEGI
SELECT Name,
	   SUBSTRING(EMail,1,1) + REPLICATE('*',5) +
	   SUBSTRING(EMail,CHARINDEX('@',EMail),LEN(EMail)-CHARINDEX('@',EMail)+1) AS EMail
	   FROM PERSON

--SPACE FONKSIYONU VERILERIN YAZIMI SIRASINDA BOSLUK BIRAKMAK KULLANILIR
SELECT Name +SPACE(5)+EMail FROM PERSON

--REPLACE ISTENILEN DEGER VEYA KARAKTER YERINE ISTENILEN YENI DEGERI VEYA KARAKTERI YAZAR
SELECT Name,REPLACE(EMail,'gmail','yahoo') FROM PERSON

--STUFF FONKSIYONU ISTENILEN BASLANGIC KARAKTERINDEN ISTENILEN KARAKTERE KADAR YAZILMASI ISTENILEN KARAKTERLERI YAZAR
SELECT Name,STUFF(EMail,2,4,'***') FROM PERSON 