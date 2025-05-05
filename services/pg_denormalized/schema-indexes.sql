CREATE INDEX idx_tweets_hashtags_gin ON tweets_jsonb USING GIN (
    (data->'entities'->'hashtags')
);

CREATE INDEX idx_tweets_extended_hashtags_gin ON tweets_jsonb USING GIN (
    (data->'extended_tweet'->'entities'->'hashtags')
);

CREATE INDEX idx_tweets_jsonb_lang ON tweets_jsonb ((data->>'lang'));

CREATE INDEX idx_tweets_jsonb_text_search_lang ON tweets_jsonb
USING GIN (to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text', data->>'text')))
WHERE data->>'lang' = 'en';
