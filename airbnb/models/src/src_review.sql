WITH raw_reviews as (
    SELECT * from {{source('airbnb', 'reviews')}}
)

SELECT

listing_id,
date as review_date,
reviewer_name,
comments as review_text,
sentiment as review_sentiment

from raw_reviews