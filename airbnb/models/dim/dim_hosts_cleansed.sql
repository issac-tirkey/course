-- cleaning layer on top of src_hosts
{{ config(
    materialized = 'view'
)
}}
with hosts_cleansed as (
    select * from {{ref('src_hosts')}}
)

select
host_id,
coalesce(host_name,'Anonymous') as host_name,
is_superhost,
created_at,
updated_at
from hosts_cleansed