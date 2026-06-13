{{ config(materialized='view') }}

select
    -- Accident Fact Keys & Metrics
    a.accident_id,
    a.num_of_casualties,
    a.num_of_vehicles,
    
    -- Date Dimension
    d.date,
    d.year,
    d.month,
    d.month_name,
    d.day_of_month,
    d.day_of_week,
    d.day_of_week_name,
    
    -- Time Dimension
    t.hour,
    t.minute,
    t.time_of_day_name,
    t.time_of_day_hours,
    t.rush_hour,
    
    -- Conditions Dimension
    c.weather_conditions,
    c.light_conditions,
    c.road_conditions,
    
    -- Casualty Profile Dimension
    p.gender,
    p.age_grp,
    p.severity,
    
    -- Infrastructure Dimension
    i.road_type,
    i.speed_limit

from {{ ref('fct_accident') }} a
left join {{ ref('dim_date') }} d on a.date_id = d.date_id
left join {{ ref('dim_time') }} t on a.time_id = t.time_id
left join {{ ref('dim_conditions') }} c on a.conditions_id = c.conditions_id
left join {{ ref('dim_main_casualty_profile') }} p on a.profile_id = p.profile_id
left join {{ ref('dim_infrastructure') }} i on a.infrastructure_id = i.infrastructure_id
