use credit_card;
select * from hotel_reservations;
select count(*) from hotel_reservations;

ALTER TABLE hotel_reservations
DROP COLUMN lead_time;


-- 36275 are total booking data
select count(*) from hotel_reservations
where arrival_year = 2018;

-- 11885 people have canceled the booking
select count(*) from hotel_reservations
where booking_status = 'Canceled';

-- 24390 people have not canceled the  booking
select count(*) from hotel_reservations
where booking_status = 'Not_Canceled';

-- There are only 930 repeated guest
select repeated_guest, count(*) from hotel_reservations
group by repeated_guest;

-- Only 1124 needed the parking space
select required_car_parking_space, count(*) from hotel_reservations
group by required_car_parking_space;

-- Max people have made no special requests
select No_of_special_requests, count(*) from hotel_reservations
group by No_of_special_requests;

-- 4 people have made previous cancellation 13 times
-- IT IS AN OUTLIER AS THESE MANY CANCELLATION IS NOT POSSIBLE
select no_of_previous_cancellations, count(*) from hotel_reservations
group by no_of_previous_cancellations
order by no_of_previous_cancellations desc;

-- There is an increase in hotel booking compared to year 2018
select arrival_year, count(booking_status) from hotel_reservations
group by arrival_year;

select arrival_year, count(booking_status) from hotel_reservations
group by arrival_year;

-- 23247 is increased in booking.
with cte_arrival as (select (select count(booking_status) booking_18
from hotel_reservations
where arrival_year=2018) year_18,
(select count(booking_status) from hotel_reservations
where arrival_year = 2017) year_17)
select year_18, year_17, year_18-year_17 as increase_booking
from cte_arrival;

-- Meal Plan 1 was ordered maximum 27835.
-- There are only 5 people who have ordered Meal Plan 3.
-- It shows that Meal Plan 3 is not good or the taste of food is not good.
select type_of_meal_plan, count(type_of_meal_plan) from hotel_reservations
group by type_of_meal_plan;

-- Room_Type 1 was booked maximum by 28130.
-- Room_Type 3 was booked only by 7 people.
-- This shows that the Room is not good or the room type 3 does not provide all the facilities
-- as compared to another rooms. 
select room_type_reserved, count(room_type_reserved) from hotel_reservations
group by room_type_reserved;


-- Cancellation is less compared to not cancel.
with booking as (select
(select count(booking_status) from hotel_reservations
where arrival_year=2017) as total_count_17,
(select count(booking_status) from hotel_reservations 
where booking_status = 'Not_Canceled' and arrival_year=2017) as Not_Canceled_17,
(select count(booking_status) from hotel_reservations 
where booking_status = 'Canceled' and arrival_year=2017) as Canceled_17,
(select count(booking_status) from hotel_reservations
where arrival_year=2018) as total_count_18,
(select count(booking_status) from hotel_reservations 
where booking_status = 'Not_Canceled' and arrival_year=2018) as Not_Canceled_18,
(select count(booking_status) from hotel_reservations 
where booking_status = 'Canceled' and arrival_year=2018) as Canceled_18)
select total_count_17, Not_Canceled_17, Canceled_17, total_count_18, Not_Canceled_18, Canceled_18 from booking;

select no_of_weekend_nights, count(*) from hotel_reservations
group by no_of_weekend_nights;

select no_of_week_nights, count(*) from hotel_reservations
group by no_of_week_nights;

-- In month of October the booking is high compared to other months.
-- In month of January the booking is very low.
-- It means that the price of booking in month of October is low compared to January.
select arrival_month, count(arrival_month) as count_month from hotel_reservations
group by arrival_month
order by count_month desc;

-- On 18th of November the booking was more in the year 2017
SELECT arrival_month, arrival_date, COUNT(arrival_date) as count
FROM hotel_reservations
where arrival_year = 2017
GROUP BY arrival_date
ORDER BY count DESC;

-- On 13th of September the booking was more in the year 2018
SELECT arrival_month, arrival_date, COUNT(arrival_date) as count
FROM hotel_reservations
where arrival_year = 2018
GROUP BY arrival_date
ORDER BY count DESC;

-- In 2017 only for six months booking was done from July - December
-- The price was lowest in month of November which was 37.33/ room.
select arrival_month, avg_price_per_room from hotel_reservations
where arrival_year = 2017
group by arrival_month
order by arrival_month asc;

select arrival_month, avg_price_per_room from hotel_reservations
where arrival_year = 2018
group by arrival_month
order by arrival_month asc;