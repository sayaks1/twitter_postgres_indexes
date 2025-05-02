/*
 * Count the number of tweets that use #coronavirus
 */
SELECT COUNT(DISTINCT data->>'id')
FROM tweets_jsonb
WHERE 
    EXISTS (
        SELECT 1
        FROM jsonb_array_elements(
            COALESCE(data->'entities'->'hashtags','[]') ||
            COALESCE(data->'extended_tweet'->'entities'->'hashtags','[]')
        ) AS hashtag
        WHERE hashtag->>'text' = 'coronavirus'
    );
