--Table nasil olusturulur;

--1. yol; Sıfırdan table olusturma;

CREATE TABLE Students
(
student_id SMALLINT,
student_name VARCHAR(50),
student_age SMALLINT,
student_dob DATE
);

--2.yol: Baska bir table kullanarak table olusturma:
CREATE TABLE student_name_age
AS SELECT student_name,student_age
FROM students;


SELECT * FROM student_name_age;

--Table olustururken bazi "constraints" kısıtlamalar yapabiliriz
--Constraints
--a-unique
--b- not null
--c- primary key
--d-foreign key
--e-chack constraints

--prımary key olusturmak icin iki yol kullanabiliriz

--1. yol
CREATE TABLE Students
(
student_id SMALLINT PRIMARY KEY,
student_name VARCHAR(50) NOT null,-- bos olamaz, 
student_age SMALLINT,
student_dob DATE UNIQUE-- student_id unique key--> null degerler dısındaki degerler tekrarsiz olmalidir.coklu null deger atanabilir
);

--2. yol
CREATE TABLE Students
(
student_id SMALLINT,
student_name VARCHAR(50),
student_age SMALLINT,
student_dob DATE,
CONSTRAINT student_id_pk PRIMARY KEY (student_id)
);

-- FOREING KEY CONSTRAINT NASİL EKLENİR
CREATE TABLE parents
(
student_id SMALLINT,
parent_name VARCHAR(50),
phone_number CHAR(11),
CONSTRAINT student_id_pk PRIMARY KEY (student_id)
);

CREATE TABLE Students
(
student_id SMALLINT,
student_name VARCHAR(50),
student_age SMALLINT,
student_dob DATE,
CONSTRAINT student_id_fk FOREIGN KEY(student_id) REFERENCES parents(student_id)
);
--Check constraınt nasil olusturulur?
CREATE TABLE Students
(
student_id SMALLINT,
student_name VARCHAR(50),
student_age SMALLINT,
student_dob DATE,
CONSTRAINT student_age_check CHECK (student_age BETWEEN 0 AND 30),
CONSTRAINT student_name_check CHECK (student_name = UPPER (student_name))
);
--Table'a veri nasil girilir?
CREATE TABLE Students
(
student_id SMALLINT PRIMARY KEY,
student_name VARCHAR(50) UNIQUE,
student_age SMALLINT NOT NULL,
student_dob DATE,
CONSTRAINT student_age_check CHECK (student_age BETWEEN 0 AND 30),-- YAS 0 VE30 DAHİL
CONSTRAINT student_name_check CHECK (student_name = UPPER (student_name))
);
--1. yol  tüm sütunlara veri girme:
INSERT INTO students VALUES('101','ALİ CAN',13,'10-aug-2008');
INSERT INTO students VALUES('102','VELI HAN',14,'10-aug-2007');
INSERT INTO students VALUES('103','AYSE TAN',14,'10-aug-2007');
-- Integer degerler single qoute(TEK TİRNAK) ile veya yalin kullanilabilir.
INSERT INTO students VALUES('104','KEMAL KUZU',15,NULL);
INSERT INTO students VALUES('105','TOMHANKS',15,'12-SEP-1996');
INSERT INTO students VALUES('106','ANGELINA JULIE',30,'12-SEP-1987');
INSERT INTO students VALUES('107','BRAD PITT',0,'03-12-2022');
--spesifik bir sutuna veri nasil girilir:
INSERT INTO Students(student_id, student_age) VALUES(108,17);
INSERT INTO Students(student_name,student_id, student_age) VALUES('JOHN WALKER1',109,24);

--VAROLAN BİR DATA NASİL DEGİSTİRİLİR
UPDATE Students
SET student_name ='LEO OCEAN'
WHERE student_id =108;

--JOHN WALKER, DOB SUTUNUNU 11-Dec-1997 DEGERİNE DEGİSTİR
UPDATE students
SET student_dob='11-Dec-1997'
WHERE student_id =109;

--Coklu hücre (cell) nasil degistirilir:
--105 id'li dob hücresini 11-Apr-1996 degerine ve name hücresini TOM HANKS degerine güncelle.
UPDATE Students
SET student_dob = '11-Apr-1996',
student_name ='TOM HANKS'
WHERE student_id ='105';

--Coklu record(satir) nasil guncellenir:
-- id'si 106'dan kucuk tum dob degerlerini 01-Aug-2021 olarak guncelleyin
UPDATE students
SET student_dob='01-Aug-2021'
WHERE student_id<106;

--tum age degerlerini en yuksek age degerine guncelle.
UPDATE students
SET student_age =(SELECT MAX(student_age)FROM students)

--tum dob degerlerini minimum dob degerine sabitle
UPDATE students
SET student_dob =(SELECT MIN (student_dob)FROM Students)

SELECT * FROM Students;
--sutunları worker_id, olan worker_name, worker_salary olan bir workers table olusturun,
--WORKER_İD SUTUNUNU PRIMARY KEY ATAYIN worker_id_pk
CREATE TABLE workers
(
worker_id SMALLINT,
worker_name VARCHAR(50),
worker_salary SMALLINT,
CONSTRAINT worker_id_pk PRIMARY KEY(worker_id)
);
INSERT INTO workers VALUES (101,'Ali Can',12000);
INSERT INTO workers VALUES (102,'Veli Can',2001);
INSERT INTO workers VALUES (103,'Ayse Kan',7000);
INSERT INTO workers VALUES (104,'Angie Ocean',8500);

--veli han ın salary degerini en yuksek salary degerinin %20 dusuğune yukseltin.
UPDATE workers
SET worker_salary =(SELECT MAX (worker_salary)*0.8 FROM workers)
WHERE worker_id=102;

--ali can in salary degerinin en dusuk salary degerinin %30 fazlasına dusurun.
UPDATE workers
SET worker_salary=(SELECT MIN(worker_salary)*1.3 FROM workers)
WHERE worker_id=101;

--ortalama salary degerinden dusuk olan salary degerlerini 1000 artırın.
UPDATE workers
SET worker_salary=worker_salary + 1000 
WHERE worker_salary<(SELECT AVG (worker_salary) FROM workers)

--ortalama salary dgerinden dusuk salary degerlerini ortalama salary degere atayin.
UPDATE workers
SET worker_salary=(SELECT AVG (worker_salary )FROM workers)
WHERE worker_salary<(SELECT AVG (worker_salary )FROM workers)

SELECT * FROM workers;


--IS NULL Condition
--bir conditionun bos olup olmadigini kontrol eder

CREATE TABLE people
(
ssn INT,
name VARCHAR(50),
address VARCHAR(80)
)

INSERT INTO people VALUES (123456789,'Mark Star','Florida');
INSERT INTO people VALUES (234567890,'Angie Way','Virginia');
INSERT INTO people VALUES (345678901,'Maryy Tien','New Jarsey');
INSERT INTO people (ssn, address)VALUES (456789012,'Michigan');
INSERT INTO people (ssn, address)VALUES (567890123,'California');
INSERT INTO people(ssn, name) VALUES (567890123,'California');

-- null name degerlerini "to be inserted later" degerine guncelleyin

UPDATE people
SET name ='to be inserted later'
WHERE name IS null;

--Null address degerlerini 'to be inserted later' degerine guncelleyin
UPDATE people
SET address ='to be inserted later'
WHERE address IS null;

--bir table dan RECORD'satir' nasil silinir.
DELETE FROM people 
WHERE ssn ='234567890'

--İsimsiz RECORD lari sil
DELETE FROM people
WHERE name ='to be inserted later'

--Tum Record yani satirlari  sil
--Delete command sadece recordları siler table ı yok etmez.
DELETE FROM people;

--name ve address degerleri Null olan record lari silin
DELETE FROM people
WHERE name IS NULL OR address IS NULL;

--ssn degeri 123456789 dan buyuk ve 345678901 den kucuk olan recordlari sil
DELETE FROM people
WHERE ssn > 123456789 AND ssn < 345678901;

--name degeri NULL olmayan tum RECORD  lari silin.
DELETE FROM people
WHERE name IS NOT NULL;

--TRUNCATE command tum satirlari"reccord" siler delete den farki geri alınamaz silme yapıyor
--TRUNCATE ve DELETE  arasinda ki fark nedir?
--1)DELETE komutunda filtrelemek icin WHERE Clause kullanilabilir fakat TRUNCATE komutunda kullanılamaz.
--2)DELETE  komutunda sildigimiz RECORD lari geri cagırabiliriz fakat TRUNCATE komutunda recodlar geri cağırılamaz.(Roll Back)
TRUNCATE TABLE people;

--Schema (şema) dan tablo silme nasil yapilir?

DROP TABLE people;
SELECT * FROM people;

--DQL  Data Query Language. Data okumak icin kullanilan dil (SELECT)
CREATE TABLE workers
(
worker_id SMALLINT,
worker_name VARCHAR(50),
worker_salary SMALLINT,
CONSTRAINT worker_id_pk PRIMARY KEY(worker_id)
);
INSERT INTO workers VALUES (10001,'Ali Can',12000);
INSERT INTO workers VALUES (10002,'Veli Can',2001);
INSERT INTO workers VALUES (10003,'Ayse Kan',7000);
INSERT INTO workers VALUES (10004,'Angie Ocean',8500);

--Tum recordla nasil cagrılır

SELECT *
FROM workers;

--Spesifik bir field(sutun) nasil cağrılır:

SELECT worker_name 
FROM workers;

--Spesifik coklu field(sutun) nasil cagırılır:

SELECT worker_name, worker_salary 
FROM workers;

--spesifik bir record nasil cagırılır:
SELECT *
FROM workers
WHERE worker_id =10001;

--çoklu sepesifik recordlar nasil cağrilir
SELECT*  
FROM workers
WHERE worker_id<10003;

--salary degerleri 2000 7000 ya da 12000 olan recordlari cagırın
--1. yol
SELECT*
FROM workers
WHERE worker_salary =2001 OR worker_salary = 7000 OR worker_salary =12000;

--2. yol
--Tekrar tekrar or kullanmak yerine ın kullanın
SELECT *
FROM workers
WHERE worker_salary IN(2001,7000,12000)

--spesifik bir hucre(cell) nasil cagrılır

SELECT * 
FROM workers
WHERE worker_id=10002;


--en yuksek salary degeri olan record u cağırın
SELECT * 
FROM workers
WHERE worker_salary =(SELECT MAX(worker_salary)FROM workers);


--en duusuk salary degeri olan record u cağırın

SELECT worker_name
FROM workers
WHERE worker_salary =(SELECT MIN(worker_salary)FROM workers);


CREATE TABLE workers
(
id SMALLINT,
name VARCHAR(50),
salary SMALLINT,
CONSTRAINT id_pk PRIMARY KEY(id)
);
INSERT INTO workers VALUES (10001,'Ali Can',12000);
INSERT INTO workers VALUES (10002,'Veli Han',2000);
INSERT INTO workers VALUES (10003,'Mary Star',7000);
INSERT INTO workers VALUES (10004,'Angie Ocean',8500);


--En dusuk ve en buyuk salary degerlerine sahip recordlari cagırın.
--1. YOL kullanilirligi önerilen
SELECT *
FROM workers
WHERE salary IN ((SELECT MAX(salary) FROM WORKERS),(SELECT MIN(salary)FROM workers));

--2. YOL
SELECT *
FROM workers
WHERE salary =(SELECT MAX(salary) FROM WORKERS) OR salary=(SELECT MIN(salary)FROM workers);

--En yuksek salary degerini bulun
--AS keywordu kullanilarak konsola gecici (temporary) field olusturulabilir.)
SELECT MAX(salary) AS maximum_salary
FROM workers;

--En dusuk salary degerini bulun
SELECT MIN(salary) AS minimum_salary
FROM workers;

--Salary ortalamasını bulun.
SELECT AVG (salary) AS avarage_salary
FROM workers;

--rekord sayisini bulun.
SELECT COUNT(name) AS number_of_workers
FROM workers;

--salary degerlerinin toplamini bulun
SELECT SUM(salary) AS total_salary
FROM workers;

--ınterview sorusu: en yuksek ikinci salary degerini cagırın
SELECT MAX(salary) AS seccond_highest_salary
FROM workers
WHERE salary <(SELECT MAX (salary)FROM workers);

--ınterview sorusu: en dusuk ikinci salary degerini cagırın
SELECT MIN(salary) AS seccond_lowest_salary
FROM workers
WHERE salary >(SELECT MIN (salary)FROM workers);

--en yuksek ucuncu salary degerini bulun
SELECT MAX(salary) AS third_max_salary
FROM workers
WHERE salary <(SELECT MAX(salary)
			FROM workers
			WHERE salary <(SELECT MAX (salary)FROM workers));
			
--en dusuk ucuncu salary degerini bulun
SELECT MIN(salary) AS third_min_salary
FROM workers
WHERE salary >(SELECT MIN(salary)
			FROM workers
			WHERE salary >(SELECT MIN (salary)FROM workers));
			
--salary degeri en yuksek ikinci degere sahip record'ı agırın.
--1. yol (bunu yaparsak sql bilgimizin iyi oldugunu gösterir)

SELECT *
FROM workers
WHERE salary =(SELECT MAX(salary) AS seccond_highest_salary
				FROM workers
				WHERE salary <(SELECT MAX (salary)FROM workers));
				

--2. yol (normalde bilinen yol)
SELECT *
FROM workers
ORDER BY salary DESC --BUYUKTEN KUCUGE SIRALA 
OFFSET 1 ROW --BİR SATİR ATLA DEMEK
FETCH NEXT 1 ROW ONLY;--SIRADAKİ BİR SATİRİ AL

--Salary degeri en dusuk ikinci degere sahip recordı cagırın.(odev)1. ve 2. yol

--salary degeri en yuksek ucuncu olan record ı cagırın
--1. yol
SELECT *
FROM workers
WHERE salary =(SELECT MAX(salary)
			FROM workers
			WHERE salary <(SELECT MAX(salary)
			FROM workers
			WHERE salary <(SELECT MAX (salary)FROM workers)));
--2. YOL:
SELECT *
FROM workers
ORDER BY salary DESC --Azalan sıralama
OFFSET 2 ROW-- İKİ SATİR ATLA
FETCH NEXT 1 ROW ONLY; -- BİRİNCİ SATİR AL

SELECT*FROM wokers;

CREATE TABLE costumers_products
(
product_id INT,
costumer_name VARCHAR (50),
product_name VARCHAR (50)
);

INSERT INTO costumers_products VALUES (10,'Mark','Orange');
INSERT INTO costumers_products VALUES (10,'Mark','Orange');
INSERT INTO costumers_products VALUES (20,'John','Apple');
INSERT INTO costumers_products VALUES (30,'Amy','Palm');
INSERT INTO costumers_products VALUES (20,'Mark','Apple');
INSERT INTO costumers_products VALUES (10,'Adem','Orange');
INSERT INTO costumers_products VALUES (40,'John', 'Apricot');
INSERT INTO costumers_products VALUES (20,'Eddie','Apple');

--Prodact name degeri Orange Apple ya da Palm olan recordlari cagiralim.
--1. yol
SELECT *  
FROM costumers_products
WHERE  product_name= 'Orange' OR product_name= 'Apple' OR product_name='Palm';

--2. yol
SELECT *  
FROM costumers_products
WHERE  product_name IN ('Orange','Apple','Palm');

--product_name degeri Orange Apple ya da Palm olmayan recordlari cagiralim.
SELECT *  
FROM costumers_products
WHERE  product_name NOT IN ('Orange','Apple','Palm');

--BETWEEN CONDİTİON BELLİ ARALIKLARI ALIR
--product_id si 30 dan kucuk veya esit ve 20 den buyuk veya esit olan recordları cagırın.
--1. YOL
SELECT *  
FROM costumers_products
WHERE product_id<= '30' AND product_id >='20';

--2. YOL
SELECT *  
FROM costumers_products
WHERE product_id BETWEEN 20 AND 30;

--product_id 20 DEN KUCUK 30 DEN BUYUK OLAN RECORDLARİ CAGIR.
--NOT BETWEEN DAHİL OLMAYANLAR
SELECT *  
FROM costumers_products
WHERE product_id NOT BETWEEN 20 AND 30;

--EXİSTs condition eger var ise anlamına gelir -subquery ile kullanilir
--			eger subquery herhangi bir data cagırırsa auter query calistirilir
--			eger subquery herhangi bir data cagırmazsa auter query calısmaz
--exist condition select ınsert uppdate delete comutlarinda kullanilabilir
--exist eger verilen degerlerden biri varsa geri kalanlari hepsini degistirir

CREATE TABLE costumers_likes
(
product_id CHAR(10),
costumer_name VARCHAR(50),
liked_product VARCHAR(50)
);
INSERT INTO costumers_likes VALUES (10,'Mark','Orange');
INSERT INTO costumers_likes VALUES (50,'Mark','Pineapple');
INSERT INTO costumers_likes VALUES (60,'John','Avocado');
INSERT INTO costumers_likes VALUES (30,'Lary','Cherries');
INSERT INTO costumers_likes VALUES (20,'Mark','Apple');
INSERT INTO costumers_likes VALUES (10,'Adem','Orange');
INSERT INTO costumers_likes VALUES (40,'John','Apricot');
INSERT INTO costumers_likes VALUES (20,'Eddie','Apple');

--costumer_name degerleri arasinda lary varsa costumer_name degerlerini hepsini no name olarak guncelle
UPDATE costumers_likes
SET costumer_name='No name'
WHERE EXISTS (SELECT liked_product FROM costumers_likes WHERE costumer_name= 'Lary');

--liked_product degerleri arasinda 'Orange','Pneapple','Avacado' varsa name degerlerini 'No Name' olarak guncelle.
UPDATE costumers_likes
SET costumer_name='No name'
WHERE EXISTS (SELECT costumer_name FROM costumers_likes WHERE liked_product IN('Orange','Pineapple','Avocado'));

--costumer_name degerleri arasinda 'Orange' degeri varsa recordlari silin.
DELETE FROM costumers_likes
WHERE EXISTS (SELECT liked_product FROM costumers_likes WHERE liked_product ='Orange');
SELECT *FROM costumers_likes
--SUBQUERY 
--
CREATE TABLE employees
(
id CHAR(9),
name VARCHAR(50),
state VARCHAR(50),
salary SMALLINT,
company VARCHAR(20)
);
INSERT INTO employees VALUES(123456789,'John Wolker','Florida',2500,'IBM');
INSERT INTO employees VALUES(234567890,'Brad Pitt','Florida',1500,'APPLE');
INSERT INTO employees VALUES(123456789,'Eddie Murphy','Texas',3000,'IBM');
INSERT INTO employees VALUES(123456789,'Eddie Murphy','Virginia',1000,'GOOGLE');
INSERT INTO employees VALUES(123456789,'Eddie Murphy','Texas',7000,'MICROSOFT');
INSERT INTO employees VALUES(123456789,'Brad Pitt','Texas',1500,'GOOGLE');
INSERT INTO employees VALUES(123456789,'Mark Stone','Pennsylvania',2500,'IBM');

SELECT *FROM employees;

CREATE TABLE companies
(
company_id CHAR(9),
company VARCHAR(20),
number_of_employees SMALLINT
);
INSERT INTO companies VALUES(100,  'IBM',12000);
INSERT INTO companies VALUES(101,  'GOOGLE',18000);
INSERT INTO companies VALUES(102,  'MICROSOFT',10000);
INSERT INTO companies VALUES(103,  'APPLE',21000);
SELECT *FROM companies;
--number_of_employees 15000 den buyuk olan name ve company degerlerini cagirin.
SELECT name, company
FROM  employees
WHERE company IN (SELECT company FROM companies WHERE number_of_employees>15000);

--Florida da bulunan campany_id ve company degerlerini cagirin.
SELECT company_id,company
FROM companies
WHERE company IN (SELECT company FROM employees WHERE state ='Florida');

--companyid degeri 100 den buyuk olan name ve state degerlerini cagirin.
SELECT name,state, company
FROM employees
WHERE company IN(SELECT company FROM companies WHERE company_id >'100');

