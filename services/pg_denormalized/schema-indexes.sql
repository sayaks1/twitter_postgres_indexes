CREATE INDEX idx_tweets_jsonb_gin ON tweets_jsonb USING GIN (data);

CREATE INDEX idx_tweets_hashtags ON tweets_jsonb USING GIN (
    jsonb_path_query_array(data, '$.**.hashtags[*].text')
);
