{{ config(materialized='table') }}

with hours as (
    select unnest(generate_series(0, 23)) as hour
),

minutes as (
    select unnest(generate_series(0, 59)) as minute
)

select 
    (h.hour * 100) + m.minute as time_id,
    h.hour,
    m.minute,
    case 
        when h.hour > 22 or h.hour <= 4 then 'Night'
        when h.hour > 4 and h.hour <= 10 then 'Morning'
        when h.hour > 10 and h.hour <= 14 then 'Midday'
        when h.hour > 14 and h.hour <= 18 then 'Afternoon'
        when h.hour > 18 and h.hour <= 22 then 'Evening'
    end as time_of_day_name,
    case 
        when h.hour > 22 and h.hour <= 4 then '22-04'
        when h.hour > 4 and h.hour <= 10 then '05-10'
        when h.hour > 10 and h.hour <= 14 then '11-14'
        when h.hour > 14 and h.hour <= 18 then '15-18'
        when h.hour > 18 and h.hour <= 22 then '19-22'
    end as time_of_day_hours,
    case 
        when h.hour >= 7 and h.hour <= 9 then 'Rush Hour'
        when h.hour >= 15 and h.hour <= 17 then 'Rush Hour'
        else 'Non Rush Hour'
    end as rush_hour,
from hours h
cross join minutes m