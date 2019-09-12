/*
@@IDENTITY, SCOPE_IDENTITY() ve IDENT_CURRENT() AYNI ISI FARKLI SEKILDE GERCEKLESTIRIRLER.

HEPSI SON URETILEN IDENTITIY DEGERINI DONDURUR.

SELECT @@IDENTITY ACILMIS OLAN SON BAGLANTIDAKI IDENTITY DEGERINI URETIR. 

@@IDENTITY TABLO VE SCOPE BAKMAKSIZIN, CONNECTION UZERINDE URETILEN SON IDENTITY DEGERINI VERIR.

NOT: EGER INSERT EDILEN TABLOMUZDA TRIGGER VARSA YANLIS IDENTITY DEGERINI ALABILIRIZ.

SELECT SCOPE_IDENTITY() ACILMIS OLAN BAGLANTIDA VE SORGUNUN BULUNDUGU SCOPETA URETILEN IDENTITY DEGERINI DONDURUR.
TRIGGER KULLANILAN TABLOLARDA @@IDENTITY YERINE SCOPE_IDENTITY() KULLANILMASI ONERILIR.

SELECT IDENT_CURRENT(TABLOADI) BAGLANTI VE SCOPE BAKMAKSIZIN,PARAMETRE OLARAK VERILEN TABLODA URETILEN SON IDENTITY DGERINI DONDURUR.
*/

--ACIKLAMALARIN MEVCUT SQL SORGUSU;
CREATE TABLE TEST_TABLO_1 ( ID INT NOT NULL IDENTITY (1, 1), ACIKLAMA VARCHAR(500) NULL, BILGI VARCHAR(1000) NULL )
CREATE TABLE TEST_TABLO_2 ( ID INT NOT NULL IDENTITY (1, 1), ACIKLAMA VARCHAR(500) NULL, EKSTRA_BILGI VARCHAR(1000) NULL )
GO

CREATE TRIGGER TRG_TEST ON TEST_TABLO_1 FOR INSERT AS INSERT INTO TEST_TABLO_2 (ACIKLAMA, EKSTRA_BILGI) VALUES ('A��klama', 'Extra Bilgi')
GO

INSERT INTO TEST_TABLO_2 (ACIKLAMA, EKSTRA_BILGI) 
VALUES ('DENEME', 'TEST1') 

INSERT INTO TEST_TABLO_2 (ACIKLAMA, EKSTRA_BILGI) 
VALUES ('DENEME', 'TEST2') 

INSERT INTO TEST_TABLO_2 (ACIKLAMA, EKSTRA_BILGI) 
VALUES ('DENEME', 'TEST3') 

INSERT INTO TEST_TABLO_2 (ACIKLAMA, EKSTRA_BILGI) 
VALUES ('DENEME', 'TEST4')

INSERT INTO TEST_TABLO_1 (ACIKLAMA, BILGI) 
VALUES ('DENEME', 'TEST1')

SELECT @@IDENTITY UNION ALL SELECT SCOPE_IDENTITY() UNION ALL SELECT IDENT_CURRENT('TEST_TABLO_1')
GO
DROP TRIGGER TRG_TEST DROP TABLE TEST_TABLO_1 DROP TABLE TEST_TABLO_2