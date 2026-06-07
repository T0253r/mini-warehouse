{{ config(materialized='table') }}

with road_types as (
    select unnest(['Dual carriageway', 'One way street', 'Roundabout', 'Single carriageway', 'Slip road', 'Unknown']) as road_type
),

speed_limits as (
    select unnest([20, 30, 40, 50, 60, 70]) as speed_limit
)

select 
    md5(rt.road_type || sl.speed_limit) as infrastructure_id,
    rt.road_type,
    sl.speed_limit
from road_types rt
cross join speed_limits sl