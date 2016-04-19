class PageFetcher

  ## Usage
  # obj = PageFetcher.new("youtube", 200)
  # obj = PageFetcher.new("youtube")

  ## Fetching data out of object
  # obj.get!
  # obj.get!(20) up to 200

  attr_reader :search_string, :pages, :fetched

  def initialize(search_string, count=200)
    @search_string = search_string
    @pages = []
    @count = count
  end

  def fetch_pages
    @fetched = Page.where("page_category LIKE '%#{@search_string}%'").page(self.params[:page])
  end

  def loop_pages(num=100)
    @pages = fetch_pages.first(num).map do |page|
      {
        page: page,
        image: page.profile_pic
      }
    end
  end

  def get!(num=100)
    loop_pages(num)
  end

end