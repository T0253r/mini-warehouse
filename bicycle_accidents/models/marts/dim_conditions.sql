{{ config(materialized='table') }}

with weather as (
    select unnest(['Clear', 'Clear and windy', 'Fog', 'Missing data', 'Other', 'Rain', 'Rain and windy', 'Snow', 'Snow and windy', 'Unknown']) as weather_conditions
),

light as (
    select unnest(['Darkness lights lit', 'Darkness no lights', 'Daylight']) as light_conditions
),

road as (
    select unnest(['Dry', 'Flood', 'Frost', 'Missing Data', 'Snow', 'Wet']) as road_conditions
)

select 
    md5(w.weather_conditions || l.light_conditions || r.road_conditions) as conditions_id,
    w.weather_conditions,
    l.light_conditions,
    r.road_conditions
from weather w
cross join light l
cross join road r