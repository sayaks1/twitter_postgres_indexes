WITH corona_tweets AS (
    SELECT data->>'id' as tweet_id,
           data->'entities'->'hashtags' as regular_hashtags,
           data->'extended_tweet'->'entities'->'hashtags' as extended_hashtags
    FROM tweets_jsonb
    WHERE data->'entities'->'hashtags' @> '[{"text": "coronavirus"}]'
       OR data->'extended_tweet'->'entities'->'hashtags' @> '[{"text": "coronavirus"}]'
)
SELECT 
    '#' || (hashtag->>'text') as tag,
    COUNT(DISTINCT tweet_id) as count
FROM corona_tweets,
    LATERAL (
        SELECT jsonb_array_elements(regular_hashtags) as hashtag
        UNION ALL
        SELECT jsonb_array_elements(extended_hashtags) as hashtag
    ) as hashtags
GROUP BY hashtag->>'text'
ORDER BY count DESC, tag
LIMIT 1000;
