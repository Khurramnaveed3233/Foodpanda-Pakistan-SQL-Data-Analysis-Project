create database Foodpanda_Pakistan

use Foodpanda_Pakistan

CREATE TABLE FactOrders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    RestaurantID INT,
    DeliveryID INT,
    ProductID INT,
    TimeID INT,
    Quantity INT,
    UnitPrice DECIMAL(10, 2),
    TotalAmount AS (Quantity * UnitPrice) PERSISTED,
    PaymentMethod VARCHAR(50),
    OrderStatus VARCHAR(50)
);

INSERT INTO FactOrders (OrderID, CustomerID, RestaurantID, DeliveryID, ProductID, TimeID, Quantity, UnitPrice, PaymentMethod, OrderStatus)
VALUES
(1, 3, 2, 4, 6, 1, 2, 450.00, 'Cash', 'Delivered'),
(2, 5, 1, 3, 2, 2, 1, 350.00, 'Wallet', 'Delivered'),
(3, 7, 5, 1, 9, 3, 3, 275.00, 'Credit Card', 'Cancelled'),
(4, 1, 3, 2, 1, 4, 2, 500.00, 'Cash', 'Pending'),
(5, 2, 4, 5, 4, 5, 1, 600.00, 'Credit Card', 'Delivered'),
(6, 4, 6, 2, 3, 6, 4, 225.00, 'Wallet', 'Delivered'),
(7, 8, 2, 1, 7, 7, 1, 950.00, 'Wallet', 'Cancelled'),
(8, 6, 1, 4, 5, 8, 3, 300.00, 'Cash', 'Delivered'),
(9, 9, 3, 3, 10, 9, 2, 425.00, 'Credit Card', 'Delivered'),
(10, 10, 5, 2, 8, 10, 1, 675.00, 'Wallet', 'Pending');

CREATE TABLE DimCustomers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Gender VARCHAR(10),
    City VARCHAR(100),
    SignupDate DATE
);

INSERT INTO DimCustomers (CustomerID, CustomerName, Email, Phone, Gender, City, SignupDate)
VALUES
(1, 'Ali Raza', 'ali.raza@example.com', '03001234567', 'Male', 'Lahore', '2022-01-15'),
(2, 'Sara Khan', 'sara.khan@example.com', '03121234567', 'Female', 'Karachi', '2021-11-10'),
(3, 'Ahmed Malik', 'ahmed.malik@example.com', '03331234567', 'Male', 'Islamabad', '2023-03-05'),
(4, 'Ayesha Noor', 'ayesha.noor@example.com', '03441234567', 'Female', 'Rawalpindi', '2020-09-28'),
(5, 'Zain Ul Abideen', 'zain.abideen@example.com', '03551234567', 'Male', 'Faisalabad', '2021-07-12'),
(6, 'Mariam Javed', 'mariam.javed@example.com', '03011234567', 'Female', 'Lahore', '2022-05-20'),
(7, 'Usman Tariq', 'usman.tariq@example.com', '03221234567', 'Male', 'Karachi', '2023-01-01'),
(8, 'Hina Yousaf', 'hina.yousaf@example.com', '03111234567', 'Female', 'Multan', '2021-03-17'),
(9, 'Bilal Aslam', 'bilal.aslam@example.com', '03311234567', 'Male', 'Peshawar', '2020-12-08'),
(10, 'Nida Shah', 'nida.shah@example.com', '03451234567', 'Female', 'Hyderabad', '2022-08-30');


CREATE TABLE DimRestaurants (
    RestaurantID INT PRIMARY KEY,
    RestaurantName VARCHAR(100),
    City VARCHAR(100),
    CuisineType VARCHAR(100),
    Rating DECIMAL(3, 2),
    ActiveStatus BIT
);

INSERT INTO DimRestaurants (RestaurantID, RestaurantName, City, CuisineType, Rating, ActiveStatus)
VALUES
(1, 'Burger Hub', 'Karachi', 'Fast Food', 4.5, 1),
(2, 'Lahori Tikka House', 'Lahore', 'Desi', 4.2, 1),
(3, 'China Town Express', 'Islamabad', 'Chinese', 4.0, 1),
(4, 'Pizza Mania', 'Rawalpindi', 'Italian', 3.9, 1),
(5, 'BBQ Tonight', 'Karachi', 'BBQ', 4.7, 1),
(6, 'Biryani King', 'Hyderabad', 'Desi', 4.3, 1),
(7, 'Sushi Stop', 'Islamabad', 'Japanese', 4.1, 0),
(8, 'Wrap It Up', 'Lahore', 'Fast Food', 3.8, 1),
(9, 'Desi Delight', 'Faisalabad', 'Desi', 4.4, 1),
(10, 'Chopsticks', 'Multan', 'Chinese', 4.0, 1);



CREATE TABLE DimProducts (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50), -- e.g., Pizza, Burger, Drinks
    Price DECIMAL(10, 2),
    RestaurantID INT FOREIGN KEY REFERENCES DimRestaurants(RestaurantID)
);

INSERT INTO DimProducts (ProductID, ProductName, Category, Price, RestaurantID)
VALUES
(1, 'Zinger Burger', 'Burger', 450.00, 1),
(2, 'Chicken Tikka', 'Desi', 400.00, 2),
(3, 'Beef Chow Mein', 'Chinese', 550.00, 3),
(4, 'Pepperoni Pizza', 'Pizza', 850.00, 4),
(5, 'Grilled Chicken Platter', 'BBQ', 950.00, 5),
(6, 'Mutton Biryani', 'Desi', 500.00, 6),
(7, 'Salmon Sushi Roll', 'Japanese', 1200.00, 7),
(8, 'Chicken Wrap', 'Fast Food', 380.00, 8),
(9, 'Paratha Roll', 'Desi', 300.00, 9),
(10, 'Chicken Manchurian', 'Chinese', 600.00, 10);



CREATE TABLE DimDelivery (
    DeliveryID INT PRIMARY KEY,
    RiderName VARCHAR(100),
    VehicleType VARCHAR(50), -- Bike, Car, etc.
    DeliveryDurationMins INT,
    DistanceKm DECIMAL(5, 2),
    OnTimeDelivery BIT
);

INSERT INTO DimDelivery (DeliveryID, RiderName, VehicleType, DeliveryDurationMins, DistanceKm, OnTimeDelivery)
VALUES
(1, 'Imran Ali', 'Bike', 32, 4.25, 1),
(2, 'Zeeshan Khan', 'Bike', 28, 3.80, 1),
(3, 'Fahad Malik', 'Car', 45, 6.10, 0),
(4, 'Usman Tariq', 'Bike', 39, 5.50, 1),
(5, 'Naveed Shah', 'Bike', 31, 3.95, 1),
(6, 'Kashif Raza', 'Car', 50, 8.20, 0),
(7, 'Ali Abbas', 'Bike', 29, 4.60, 1),
(8, 'Bilal Yousaf', 'Bike', 40, 5.90, 0),
(9, 'Rizwan Ahmed', 'Car', 48, 7.10, 1),
(10, 'Tariq Jamil', 'Bike', 34, 4.85, 1);


CREATE TABLE DimTime (
    TimeID INT PRIMARY KEY,
    OrderDate DATE,
    OrderMonth INT,
    OrderQuarter INT,
    OrderYear INT,
    WeekdayName VARCHAR(20),
    IsWeekend BIT
);

INSERT INTO DimTime (TimeID, OrderDate, OrderMonth, OrderQuarter, OrderYear, WeekdayName, IsWeekend)
VALUES
(1, '2023-01-01', 1, 1, 2023, 'Sunday', 1),
(2, '2023-01-02', 1, 1, 2023, 'Monday', 0),
(3, '2023-01-03', 1, 1, 2023, 'Tuesday', 0),
(4, '2023-01-04', 1, 1, 2023, 'Wednesday', 0),
(5, '2023-01-05', 1, 1, 2023, 'Thursday', 0),
(6, '2023-01-06', 1, 1, 2023, 'Friday', 0),
(7, '2023-01-07', 1, 1, 2023, 'Saturday', 1),
(8, '2023-02-01', 2, 1, 2023, 'Wednesday', 0),
(9, '2023-03-01', 3, 1, 2023, 'Wednesday', 0),
(10, '2023-03-05', 3, 1, 2023, 'Sunday', 1);


-------------------------------------

select * from DimCustomers

select * from DimRestaurants

select * from DimProducts

select * from DimDelivery

select * from DimTime

select * from FactOrders

-------------------------------------------
--- Q1: Which are the top 5 best-selling products by revenue? 

select top 5 p.ProductName , sum(f.TotalAmount )  as Revenue 
from FactOrders f
join DimProducts p on f.ProductID = p.ProductID
group by ProductName
order by sum(f.TotalAmount ) desc 

--- Q2: Which restaurants have the highest average order value?

select  r.restaurantname , avg(f.totalamount) as Avg_order_value 
from DimRestaurants r 
join FactOrders f on r.RestaurantID = f.RestaurantID
group by r.RestaurantName
order by avg(f.totalamount) desc 

-- Q3: Which city has the most active customers?

select top 1 city , count(customerid) as ActiveCustomers 
from DimCustomers
group by city 
order by ActiveCustomers  desc 

--- Q4: What's the average delivery time by vehicle type?

select vehicletype , AVG(deliverydurationmins) as AvgDlvryTime 
from DimDelivery
group by vehicletype

--- Q5: What percentage of orders are delivered on time?

select concat(cast(sum(cast(ontimedelivery as int)) * 100.0 / count(*) as decimal(5)),' %')  as OnTimeDlvryPercentage
from DimDelivery

--- Q6: What is the monthly revenue trend?

select t.ordermonth , sum(f.totalamount) as Revenue 
from DimTime t
join FactOrders f on t.TimeID = f.TimeID
group by t.OrderMonth
order by Revenue desc 

--- Q7: Who are the top 5 customers by spending?

select top 5 customername , sum(f.totalamount) as TotalSpendings 
from DimCustomers c 
join FactOrders f on c.CustomerID = f.CustomerID
group by CustomerName
order by TotalSpendings desc 

--- Q8: Which product categories generate the highest revenue?

select top 1 p.category , sum(f.totalamount) as HighestRevenue  
from DimProducts p
join FactOrders f on p.ProductID = f.ProductID 
group by Category 
order by Category desc 

--- Q9: Which restaurants have the highest cancellation rates?

select r.restaurantname , count(*) as TotalOrders , 
       count(case when f.OrderStatus = 'cancelled' then 1 end ) AS CancelledOrders , 
	   concat(cast(count(case when f.OrderStatus = 'cancelled' then 1 end ) * 100.0 / count(*) as decimal(5)) , '%')  AS CancellationRate 
from FactOrders f 
join DimRestaurants r on f.RestaurantID = r.RestaurantID
group by r.restaurantname
order by CancellationRate  desc 

--- Q10: Which delivery riders consistently exceed the average delivery duration?

select d.ridername AS RiderName , d.DeliveryDurationMins , 
       ( select AVG(DeliveryDurationMins) from dimdelivery ) AvgDeliveryTime , 
	   d.DeliveryDurationMins - (SELECT AVG(DeliveryDurationMins) FROM DimDelivery) AS TimeOverAvg
from DimDelivery d
WHERE D.DeliveryDurationMins > ( select AVG(DeliveryDurationMins) from dimdelivery )
ORDER BY TimeOverAvg

--- Q13: How often do customers place repeat orders within a month?

select c.customername , count(f.orderid) as OrderCount , datename(month,t.orderdate) as OrderMonth 
from DimCustomers c
join FactOrders f on c.CustomerID = c.CustomerID
join DimTime t on f.TimeID = T.TimeID
GROUP BY c.customername , datename(month,t.orderdate)
HAVING count(f.orderid) > 1 
ORDER BY OrderCount DESC 

--- Q11: What are the peak ordering hours across different cities?

select c.city , DATEPART(hour,cast(t.orderdate as datetime)) as HourOfDay , count(f.orderid) as OrderVolume 
from DimCustomers c 
join FactOrders f on c.CustomerID = f.CustomerID
join DimTime t on f.TimeID = t.TimeID
group by c.city , DATEPART(hour,cast(t.orderdate as datetime))
order by OrderVolume desc 

-- Q12: Which payment methods are most popular among customers?

SELECT PaymentMethod, COUNT(*) AS UsageCount,
       CAST(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM FactOrders) AS DECIMAL(5,2)) AS UsagePercentage
FROM FactOrders
GROUP BY PaymentMethod
ORDER BY UsageCount DESC;







