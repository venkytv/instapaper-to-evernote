# instapaper-to-evernote
Export Instapaper articles to Evernote

Simple script to push all Instapaper articles to Evernote.  Once an article is
pushed, it is archived in Instapaper.  It works by marking each Instapaper
article as "Liked" and lets Instapaper's Evernote integration push the article
to Evernote.

### Prerequisites

- Install [bundler](http://bundler.io)
- [Register as a developer and get the API consumer token] (https://www.instapaper.com/api)
- [Connect your Instapaper account to your Evernote account] (https://www.instapaper.com/user)
- Check both the "Likes" and "Notes" integrations for the Evernote share.

### Usage

- Set the following environment variables:
  - `INSTAPAPER_USERNAME`: Your Instapaper username
  - `INSTAPAPER_PASSWORD`: Your Instapaper password
  - `API_CONSUMER_KEY`: Your Instapaper API consumer key
  - `API_CONSUMER_SECRET`: Your Instapaper API consumer secret
- Run `bundle install` to install the required gems
- Run `bundle exec ruby ip2en.rb`

#### Run within a Docker container

```
$ docker run -e INSTAPAPER_USERNAME -e INSTAPAPER_PASSWORD \
	-e API_CONSUMER_KEY -e API_CONSUMER_SECRET \
	--rm venkytv/instapaper-to-evernote:latest
```
