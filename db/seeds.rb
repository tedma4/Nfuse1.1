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
	{page_name: 'wired', thing_name: 'wired', twitter_handle: 'wired', youtube_handle: 'https://youtube.com/user/wired', instagram_handle: 'wired', facebook_handle: nil, pinterest_handle: nil, tumblr_handle: nil, gplus_handle: nil, metatag_title: 'Wired Magazine', description: 'A magazine about science and shit', page_category: 'science, technology, nerdish'},
	{page_name: 'national_geographic', thing_name: 'NatGeo', twitter_handle: 'NatGeo', youtube_handle: 'https://www.youtube.com/user/NationalGeographic', instagram_handle: 'natgeo', facebook_handle: nil, pinterest_handle: nil, tumblr_handle: nil, gplus_handle: nil, metatag_title: 'National Geographic Magazine', description: 'A magazine about nature and shit', page_category: 'the wild, nature, birds and shit'},
	{page_name: 'time_magazine', thing_name: 'Time', twitter_handle: 'TIME', youtube_handle: 'https://www.youtube.com/user/TimeMagazine', instagram_handle: 'time', facebook_handle: nil, pinterest_handle: nil, tumblr_handle: nil, gplus_handle: nil, metatag_title: 'Time Magazine', description: 'A maazine about interesing shit someone took a picture of', page_category: 'nature, technology, nerdish, pretty much everything'},
	{page_name: 'redbull', thing_name: 'Redbull', twitter_handle: 'redbull', youtube_handle: 'https://www.youtube.com/user/redbull', instagram_handle: 'redbull', facebook_handle: nil, pinterest_handle: nil, tumblr_handle: nil, gplus_handle: nil, metatag_title: 'Redbull', description: 'It gives you wings', page_category: 'energyDrink'},
	{page_name: 'forbes_magazine', thing_name: 'Forbes', twitter_handle: 'Forbes', youtube_handle: 'https://www.youtube.com/user/forbes', instagram_handle: 'forbes', facebook_handle: nil, pinterest_handle: nil, tumblr_handle: nil, gplus_handle: nil, metatag_title: 'Forbes Magazine', description: 'A magazine about cool shit rich people read about', page_category: 'magazine, lifestyle'},
	{page_name: 'google', thing_name: 'Google', twitter_handle: 'google', youtube_handle: 'https://www.youtube.com/user/Google', instagram_handle: 'google', facebook_handle: nil, pinterest_handle: nil, tumblr_handle: nil, gplus_handle: nil, metatag_title: 'Google', description: 'An awesome fuckin company that I wouldnt mind letting rule the world', page_category: 'everything'},
	{page_name: 'tedtalks', thing_name: 'Ted Talks', twitter_handle: 'TEDTalks', youtube_handle: 'https://www.youtube.com/user/TEDtalksDirector', instagram_handle: 'ted', facebook_handle: nil, pinterest_handle: nil, tumblr_handle: nil, gplus_handle: nil, metatag_title: 'Ted Talks', description: 'Because my name is in it', page_category: 'science, technology, nerdish'},
	{page_name: 'tesla', thing_name: 'Tesla', twitter_handle: 'TeslaMotors', youtube_handle: 'https://www.youtube.com/user/TeslaMotors', instagram_handle: 'teslamotors', facebook_handle: nil, pinterest_handle: nil, tumblr_handle: nil, gplus_handle: nil, metatag_title: 'Tesla', description: 'The owner seems like a good guy, but some dude at work says hes worse than Jobs', page_category: 'science, technology, nerdish, space'},
	{page_name: 'hbo', thing_name: 'HBO', twitter_handle: 'HBO', youtube_handle: 'dfhttps://www.youtube.com/user/HBOdrf', instagram_handle: 'hbo', facebook_handle: nil, pinterest_handle: nil, tumblr_handle: nil, gplus_handle: nil, metatag_title: 'HBO', description: 'Only relevent anymore because of Game of Thrones and Last Week Tonight', page_category: 'TV, Entertainment, Movies and stuff'},
	{page_name: 'marvel', thing_name: 'Marvel', twitter_handle: 'Marvel', youtube_handle: 'https://www.youtube.com/user/MARVEL', instagram_handle: 'marvel', facebook_handle: nil, pinterest_handle: nil, tumblr_handle: nil, gplus_handle: nil, metatag_title: 'Mavel', description: 'Responsible for 1/3 of the all good movies that come out every year', page_category: 'commics, nerdish, disney'}
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
