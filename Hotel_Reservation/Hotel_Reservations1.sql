select * from hotel_reservations;

SELECT arrival_month, arrival_date, COUNT(arrival_date) as count
FROM hotel_reservations
where arrival_year = 2017
GROUP BY arrival_date
ORDER BY count asc;

SELECT arrival_month, arrival_date, COUNT(arrival_date) as count
FROM hotel_reservations
where arrival_year = 2018
GROUP BY arrival_date
ORDER BY count asc;