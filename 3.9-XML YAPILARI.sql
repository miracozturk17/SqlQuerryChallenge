/*
XML = EXTENSIBLE MARKUP LANGUAGE

XML BIR ISARETLEME DILI TEKNOLOJISIDIR.

AJAX (ASYNCHRONOUS JAVASCRIPT AND XML), SSIS (SQL SERVER INTEGRATION SERVICE), SSRS (SQL SERVER REPORTING SERVICE) GIBI UYGULAMLARIN TEMELINI XML OLUSTURUR.

VERILERIMIZI PAYLASMANIN FARKLI VE KOLAY BIR YOLUDUR.
*/

SELECT * FROM PERSON

--VERI TABANIMIZDAKI PERSON TABLOMUZU XML YAPISINA DONUSTURELIM.
--MEVCUT SQL SORGUSU;
-- <PERSON Name="M�RA�" BirthDate="1992-06-18T00:00:00" City="ISTANBUL" />
SELECT TOP 1 Name,BirthDate,City FROM PERSON
FOR XML AUTO


--XML YAPIMIZA ROOT TAGINI EKLEYELIM.
--MEVCUT SQL SORGUSU;
/*
<RootNode>
  <PERSON Name="M�RA�" BirthDate="1992-06-18T00:00:00" City="ISTANBUL" />
</RootNode>
*/
SELECT TOP 1 Name,BirthDate,City FROM PERSON
FOR XML AUTO,ROOT('RootNode')

--TABLOLARIMIZI BAGLAYALIM VE HIYERARSIK YAPI OLUSTURALIM.
--MEVCUT SQL SORGUSU;
/*
<RootNode>
  <PERSON Name="M�RA�" BirthDate="1992-06-18T00:00:00" City="ISTANBUL">
    <DEPARTMENT Department="IT" />
  </PERSON>
</RootNode>
*/
SELECT TOP 1 Name,BirthDate,City,Department FROM PERSON
INNER JOIN DEPARTMENT ON DEPARTMENT.DepartmentID=PERSON.DepartmentID
FOR XML AUTO,ROOT('RootNode')

--KOLONLARIMIZI OZNITELIK OLARAK DEGIL ELEMENT OLARAK OLUSTURALIM.
--MEVCUT SQL SORGUSU;
/*
<RootNode>
  <PERSON>
    <Name>M�RA�</Name>
    <BirthDate>1992-06-18T00:00:00</BirthDate>
    <City>ISTANBUL</City>
    <DEPARTMENT>
      <Department>IT</Department>
    </DEPARTMENT>
  </PERSON>
</RootNode>
*/
SELECT TOP 1 Name,BirthDate,City,Department FROM PERSON
INNER JOIN DEPARTMENT ON DEPARTMENT.DepartmentID=PERSON.DepartmentID
FOR XML AUTO,ELEMENTS,ROOT('RootNode')

--XML YAPIMIZI RAW SEKLINDE OLUSTURALIM.
--MEVCUT SQL SORGUSU;
/*
<RootNode>
  <PERSON Name="M�RA�" BirthDate="1992-06-18T00:00:00" City="ISTANBUL" Department="IT" />
</RootNode>
*/
SELECT TOP 1 Name,BirthDate,City,Department FROM PERSON
INNER JOIN DEPARTMENT ON DEPARTMENT.DepartmentID=PERSON.DepartmentID
FOR XML RAW('PERSON'),ROOT('RootNode')

--TUM DEGERLERI TAMAMEN BIRER ELEMENT OLARAK OLUSTURMAMIZ SONRASINDA IMPORT EDILECEK TABLOLAR ICIN KOLAYLIK SAGLAYABILIR.
--MEVCUT SQL SORGUSU;
/*
<RootNode>
  <PERSON>
    <Name>M�RA�</Name>
    <BirthDate>1992-06-18T00:00:00</BirthDate>
    <City>ISTANBUL</City>
    <Department>IT</Department>
  </PERSON>
  <PERSON>
    <Name>KAD�R</Name>
    <BirthDate>1994-01-03T00:00:00</BirthDate>
    <City>AMASYA</City>
    <Department>FINANCE</Department>
  </PERSON>
</RootNode>
*/
SELECT TOP 2 Name,BirthDate,City,Department FROM PERSON
INNER JOIN DEPARTMENT ON DEPARTMENT.DepartmentID=PERSON.DepartmentID
FOR XML PATH('PERSON'),ROOT('RootNode')

--MEVCUT ELEMENTLERIMIZ NULL OLAN VERILER DISINDAKI TUM BILGILERI GETIRMEKTEDIR.
--FAKAT NULL OLAN VERILERDE HERHANGIL BIR TABLO SUTUNUNA KAYIT ATILIRKEN GEREKMEKTEDIR. (ELEMENTS XSINIL)
--MEVCUT SQL SORGUSU;
/*
  <PERSON>
    <Name>�SMET</Name>
    <BirthDate xsi:nil="true" />
    <City>KOPENHAG</City>
    <Department>SALES</Department>
  </PERSON>
*/
SELECT TOP 2 Name,BirthDate,City,Department FROM PERSON
INNER JOIN DEPARTMENT ON DEPARTMENT.DepartmentID=PERSON.DepartmentID
FOR XML PATH('PERSON'),ROOT('RootNode'), ELEMENTS XSINIL

--HERHANGI BIR ERISILEBILIR DOYSA KONUMUNDA MEVCUT XML UZANTILI KAYNAGIMIZ VARSA BELIRLEDIGIMIZ VERI KOKLERINI ISTEDIGIMIZ GIBI TABLOLARIMIZDA KULLANABILIRIZ.
--MEVCUT SQL SORGUSU;
DECLARE @XML XML
SELECT
@XML = BULKCOLUMN
FROM OPENROWSET(BULK 'D:\PERSON.xml',SINGLE_BLOB) AS X
SELECT
X.value('@PersonNumber','VARCHAR(50)') AS ID,
X.value('@Name','VARCHAR(50)') AS SURNAME,
X.value('@Surname','VARCHAR(50)') AS NAME
FROM @XML.nodes('/Persons/Person') i(X)


--XML SCHEMA OLUSUMU.
--MEVCUT SQL SORGUSU;
CREATE XML SCHEMA COLLECTION xml_Schema
AS
'<?xml version="1.0" encoding="UTF-8" ?>
 <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema">
  <xs:element name="Person">
   <xs:complexType>
     <xs:sequence>
	  <xs:element FirstName="Mirac" minOccurs="1" type="xs:string"/>
	  <xs:element Lastname="Kadir" minOccurs="1" type="xs:string"/>
	  <xs:element name="Omer"  minOccurs="1" type="xs:string"/>
	</xs:sequence>
  </xs:complexType>
 </xs:element>
</xs:schema>'

--OLUSTURDUGUMUZ XML TABLOSUNA VERILERIMIZI EKLEYELIM.
--MEVCUT SQL SORGUSU;
INSERT INTO 
BussinesLife.dbo.XML(UNTYPED,TYPE,CONTENTDETAIL)
VALUES(
' <Person>
    <Name>MIRAC</Name>
    <SurName>OZTURK</SurName>
    </Person>','
    <Person>
    <Name>KADIR</Name>
    <SurName>OZTURK</SurName>
    </Person>'
	,
    '<Person>
    <Name>KADIR</Name>
    <SurName>OZTURK</SurName>
    </Person>'
)

SELECT * FROM XML

--MEVCUT ELIMIZDE OLAN BIR XML KOD BLOGUNU (SERVIS,DOSYA...) PARAMETRE BELIRLEYEREK MODELLEYIP KULLANABILIRIZ.
--PARAMETRELER TAG ISIMLERI ILE AYNI OLMALI !!!
--MEVCUT SQL SORGUSU;
DECLARE @hdoc INT;
DECLARE @doc  NVARCHAR(1000);
SET @doc=
'<Person>
    <Name>MIRAC</Name>
    <SurName>OZTURK</SurName>
 </Person>'

EXECUTE sp_xml_preparedocument @hdoc OUTPUT, @doc;

SELECT * 
FROM OPENXML(@hdoc,'/Person',2)
	 WITH (Name NVARCHAR(50),SurName NVARCHAR(50))

EXECUTE sp_xml_removedocument @hdoc

--VERILEN XML YAPISINI DOGRUDAN ISTEDIGINIZ BIR TABLOYA YADA YENI BIR TABLO ICINE AKTARABILIRSINIZ.
--MEVCUT SQL SORGUSU;
DECLARE @hdoc INT;
DECLARE @doc  NVARCHAR(1000);
SET @doc=
'<Person>
    <Name>MIRAC</Name>
    <SurName>OZTURK</SurName>
 </Person>'

EXECUTE sp_xml_preparedocument @hdoc OUTPUT, @doc;

SELECT * 
INTO BussinesLife.dbo.XML2
FROM OPENXML(@hdoc,'/Person',2)
	 WITH (Name NVARCHAR(50),SurName NVARCHAR(50))

EXECUTE sp_xml_removedocument @hdoc

select * from XML2