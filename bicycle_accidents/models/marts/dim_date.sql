{{ config(materialized='table') }}

with date_bounds as (
    select 
        min(try_cast(Date as date)) as min_date,
        current_date as max_date
    from {{ ref('stg_accidents') }}
),

date_series as (
    select unnest(generate_series(
        (select min_date from date_bounds), 
        (select max_date from date_bounds), 
        INTERVAL 1 DAY
    )) as date_day
)

select
    cast(strftime(date_day, '%Y%m%d') as integer) as date_id,
    
    date_day as date,
    year(date_day) as year,
    month(date_day) as month,
    monthname(date_day) as month_name,
    day(date_day) as day_of_month,
    isodow(date_day) as day_of_week,
    dayname(date_day) as day_of_week_name

from date_series