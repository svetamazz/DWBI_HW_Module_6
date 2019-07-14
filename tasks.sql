USE module_6_matskiv;
GO

/*1.�������� �������, ��� ������� ������ ��������, ��������� � ���������� ������� ��� �� ���� ����������� + ���������� ����� ����� � ������ (�������� ��������� ��� ����������� ������). */
SELECT productid,[name],city,
ROW_NUMBER() OVER(ORDER BY city) AS row_number_
FROM products;
GO

/*2.�������� �������, ��� ������� ������ ��������, ��������� � ���������� ������� ��� �� ���� ����������� + ���������� ����� � ����� ������ ���� (������������ �� ������ ��������). */
SELECT productid,[name],city,
ROW_NUMBER() OVER(PARTITION BY city ORDER BY [name]) AS row_number_
FROM products
ORDER BY city;
GO

/*3.�������������� �� ������ ��������� ����� �������� �����, ���� ������� ���� � ���������� ������� 1. */
SELECT *
FROM(
	SELECT productid,[name],city,
	ROW_NUMBER() OVER(PARTITION BY city ORDER BY [name]) AS row_number_
	FROM products
	) AS p
WHERE row_number_=1
ORDER BY city;
GO

/*4.�������� �����, ���� ������� ������ ��������, �������, ��� ��������,  �������� ������� �������� ��� ������� �������� � �������� ������� �������� ��� ����� �����. */
SELECT productid,detailid,quantity,
SUM(quantity) OVER(PARTITION BY productid) AS all_quantity_per_prod,
SUM(quantity) OVER(PARTITION BY detailid) AS all_quantity_per_det
FROM supplies;
GO

/*5.����������� ������������ ���� ���������� � ������� ��������, ������������ ��  ���������������, ������� ������ � 10 �� 15 �����, ��������� ������� ���������� ����� ������ � �������� ������� ������ � ������� ��������. */
SELECT * 
FROM (
	SELECT supplierid,detailid,productid,quantity,
	ROW_NUMBER() OVER(ORDER BY supplierid) AS rn,
	COUNT(*) OVER() AS tot
	FROM supplies
	) AS s
WHERE rn BETWEEN 10 AND 15;
GO

/*6.�������� �����, �� ��������� ������� ������� �������� � �������� � �������� � ��������, �� ������� �������� ����� ��������. */
SELECT * FROM
 (SELECT supplierid,detailid,productid,quantity,
 AVG(quantity) OVER() AS avg_qty
 FROM supplies
 ) AS s
WHERE quantity<avg_qty;
GO