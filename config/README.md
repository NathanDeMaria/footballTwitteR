# Configuration

Replace configuration values from `sample_config.xml` with your own values in a file called `config.xml` in the same directory.

## Twitter OAuth
To get the keys, go to https://apps.twitter.com/app/{app_id}/keys

The first time you run `register_oauth.R`, it will ask you if you want to cache the oauth stuff.  Pick either one :)

A common error looks like:
```
[1] "Using direct authentication"
Error in check_twitter_oauth() : OAuth authentication error:
This most likely means that you have incorrectly called setup_twitter_oauth()'
```

I'm not really sure what it means, and [I'm not sure if the internet does either](https://github.com/geoffjentry/twitteR/issues/74), but installing the `base64enc` package seemed to fix things for me.
