WITH tweet_hashtags AS (
    SELECT DISTINCT
        data->>'id' as id_tweets,
        '#' || (jsonb->>'text') as tag
    FROM tweets_jsonb,
    LATERAL jsonb_array_elements(
        COALESCE(data->'entities'->'hashtags', '[]'::jsonb) ||
        COALESCE(data->'extended_tweet'->'entities'->'hashtags', '[]'::jsonb)
    ) as jsonb
    WHERE 
        to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text', data->>'text')) @@ to_tsquery('english', 'coronavirus')
        AND data->>'lang' = 'en'
)
SELECT
    tag,
    count(*) AS count
FROM tweet_hashtags
GROUP BY tag
ORDER BY count DESC, tag
LIMIT 1000; 
