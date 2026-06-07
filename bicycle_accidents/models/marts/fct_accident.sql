{{ config(materialized='table') }}

select prep.*
from {{ ref('int_accidents_prep') }} prep
inner join {{ ref('dim_date') }} d on prep.date_id = d.date_id
inner join {{ ref('dim_time') }} t on prep.time_id = t.time_id
inner join {{ ref('dim_conditions') }} c on prep.conditions_id = c.conditions_id
inner join {{ ref('dim_main_casualty_profile') }} p on prep.profile_id = p.profile_id
inner join {{ ref('dim_infrastructure') }} i on prep.infrastructure_id = i.infrastructure_id