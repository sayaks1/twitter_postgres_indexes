SELECT
    data->>'lang' as lang,
    count(DISTINCT data->>'id') as count
FROM tweets_jsonb
WHERE 
    data->'entities'->'hashtags' @> '[{"text": "coronavirus"}]'::jsonb OR
    data->'extended_tweet'->'entities'->'hashtags' @> '[{"text": "coronavirus"}]'::jsonb
GROUP BY data->>'lang'
ORDER BY count DESC, lang; 
