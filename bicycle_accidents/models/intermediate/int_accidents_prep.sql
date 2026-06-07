{{ config(materialized='view') }}

with accidents as (
    select * from {{ ref('stg_accidents') }}
),

bikers as (
    select * from {{ ref('stg_bikers') }}
)

select
    a.accident_index as accident_id,

    cast(strftime(try_cast(a.date as date), '%Y%m%d') as integer) as date_id,
    (cast(date_part('hour', a.time) as integer) * 100) + cast(date_part('minute', a.time) as integer) as time_id,
    md5(a.weather_conditions || a.light_conditions || a.road_conditions) as conditions_id,
    md5(b.gender || b.age_grp || b.severity) as profile_id,
    md5(a.road_type || cast(a.speed_limit as integer)) as infrastructure_id,
    
    try_cast(a.number_of_casualties as integer) as num_of_casualties,
    try_cast(a.number_of_vehicles as integer) as num_of_vehicles,

    a.date,
    a.time,
    a.weather_conditions,
    a.light_conditions,
    a.road_conditions,
    a.road_type,
    a.speed_limit,
    b.gender,
    b.age_grp,
    b.severity

from accidents a
left join bikers b 
    on a.accident_index = b.accident_index
where a.date is not null 
  and a.time is not null