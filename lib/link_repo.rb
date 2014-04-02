class LinkRepo
  attr_accessor :links

  def initialize
    @links = []
  end

  def add(link)
    url_link_data = {:url_to_redirect_to => link, :id => (@links.count.to_i) + 1, stats: true}
    @links << url_link_data
  end
end