USE module_6_matskiv;
GO

/*1.Написати команду, яка повертає список продуктів, складений в алфавітному порядку міст де вони знаходяться + порядковий номер деталі в списку (наскрізна нумерація для порядкового номера). */
SELECT productid,[name],city,
ROW_NUMBER() OVER(ORDER BY city) AS row_number_
FROM products;
GO

/*2.Написати команду, яка повертає список продуктів, складений в алфавітному порядку міст де вони знаходяться + порядковий номер в межах одного міста (відсортований за іменем продукту). */
SELECT productid,[name],city,
ROW_NUMBER() OVER(PARTITION BY city ORDER BY [name]) AS row_number_
FROM products
ORDER BY city;
GO

/*3.Використовуючи за основу попередній запит написати запит, який повертає міста з порядковим номером 1. */
SELECT *
FROM(
	SELECT productid,[name],city,
	ROW_NUMBER() OVER(PARTITION BY city ORDER BY [name]) AS row_number_
	FROM products
	) AS p
WHERE row_number_=1
ORDER BY city;
GO

/*4.Написати запит, який повертає список продуктів, деталей, їхні поставки,  загальну кількість поставок для кожного продукту і загальну кількість поставок для кожної деталі. */
SELECT productid,detailid,quantity,
SUM(quantity) OVER(PARTITION BY productid) AS all_quantity_per_prod,
SUM(quantity) OVER(PARTITION BY detailid) AS all_quantity_per_det
FROM supplies;
GO

/*5.Організувати посторінковий вивід інформації з таблиці поставок, відсортований за  постачальниками, вивести записи з 10 по 15 запис, додатково вивести порядковий номер стрічки і загальну кількість записів у таблиці поставок. */
SELECT * 
FROM (
	SELECT supplierid,detailid,productid,quantity,
	ROW_NUMBER() OVER(ORDER BY supplierid) AS rn,
	COUNT(*) OVER() AS tot
	FROM supplies
	) AS s
WHERE rn BETWEEN 10 AND 15;
GO

/*6.Написати запит, що розраховує середню кількість елементів в поставці і виводить ті поставки, де кількість елементів менше середньої. */
SELECT * FROM
 (SELECT supplierid,detailid,productid,quantity,
 AVG(quantity) OVER() AS avg_qty
 FROM supplies
 ) AS s
WHERE quantity<avg_qty;
GO