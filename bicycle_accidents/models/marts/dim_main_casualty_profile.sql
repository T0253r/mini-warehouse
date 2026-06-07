{{ config(materialized='table') }}

with genders as (
    select unnest(['Female', 'Male', 'Other']) as gender
),

ages as (
    select unnest(['11 to 15', '16 to 20', '21 to 25', '26 to 35', '36 to 45', '46 to 55', '56 to 65', '6 to 10', '66 to 75']) as age_grp
),

severities as (
    select unnest(['Fatal', 'Serious', 'Slight']) as severity
)

select 
    md5(g.gender || a.age_grp || s.severity) as profile_id,
    g.gender,
    a.age_grp,
    s.severity
from genders g
cross join ages a
cross join severities s