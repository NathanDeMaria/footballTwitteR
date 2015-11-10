# Twitter

This package has a setup for searching twitter and saving it to a SQLite database.  To get started, first follow the instructions in `config/`

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


## RPushbullet
To setup `RPushbullet`, make an account [here](https://www.pushbullet.com/) and then follow [these instructions](https://github.com/eddelbuettel/rpushbullet#initialization) to setup your account. 

My `./rpushbullet.json` looks like:
```
{
  "key": "<key>",
  "devices": [],
  "names": []
}
```


## Packages
This stuff depends on a few packages. If you run `packages.R`, it should install the ones you don't have
