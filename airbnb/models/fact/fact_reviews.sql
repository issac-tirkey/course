--increment materialization
-- when upstream source data changes schema, we also need to modify

{{
    config(
        materialized = 'incremental',
        on_scheme_change= 'fail'       
    )
}}
WITH src_reviews as (
    select * from {{ ref('src_review') }}
)
select * from src_reviews
where review_text is not null
{% if is_incremental() %}
    AND review_date > (select max(review_date) from {{this}}) --this refers to fact model
{% endif %}