-- to check whether full moon had an effect on reviews
{{ config(
    materialized = 'table'
)}}

with fact_reviews as (
    select * from {{ref('fact_reviews')}}
),
full_moon_dates as (
    select * from {{ref('seed_full_moon_dates')}}
)

select
r.*,
case
    when fm.full_moon_date is null then 'not full moon'
    else 'full moon'
end as is_full_moon
from fact_reviews r left join full_moon_dates fm
on (TO_DATE(r.review_date) = DATEADD(DAY, 1, fm.full_moon_date)) --adding 1 day after full moon date