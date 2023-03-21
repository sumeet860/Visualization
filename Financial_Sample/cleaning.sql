select * from financial_sample;

-- Changing discounts values
update financial_sample
set discounts = "$0"
where discount_band = "None";

-- Dropping the column month_number
alter table financial_sample
drop column Month_Number;

-- comparing gross sales and sales
select Gross_Sales, Sales,
case when Gross_Sales = Sales then True else False end
from financial_sample;