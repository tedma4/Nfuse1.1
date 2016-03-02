# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


pages = Page.create([
	# first_or_initialize allows us to re-run this without recreating data
	# page_name is the name of the method and route, thing_name is the full name of the company/person/whatever, twitter_handle is the twitter username and name of the image
	# We can add other fields in here as well for SEO
	# Also, We can add other types of seed data. Like forum posts for a specific page or whatever
	{page_name: 'wired', thing_name: 'wired', twitter_handle: 'Wired', youtube_handle: 'https://youtube.com/wired', instagram_handle: 'wired', facebook_handle: nil, pinterest_handle: nil, tumblr_handle: nil, gplus_handle: nil, metatag_title: 'Heres the custom title for a page', description: 'Here is a custom description for this page', page_category: 'science, technology, nerdish'}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}
	# {page_name: '', thing_name: '', twitter_handle: '', youtube_handle: '', instagram_handle: '', facebook_handle: '', pinterest_handle: '', tumblr_handle: '', gplus_handle: ''}

	])
