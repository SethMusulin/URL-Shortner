class Link

  attr_accessor :old_url

  def initialize (old_url)
    @old_url = old_url
  end

  def is_url?
    if !@old_url.include?("http://") && !@old_url.include?("https://")
      @old_url = @old_url.insert(0, "http://")
    end
    if @old_url =~ /^#{URI::regexp}$/ && @old_url =~ /[a-zA-Z\d]['.'][a-zA-Z][a-zA-Z]/
      true
    else
      false
    end
  end

  def is_url_empty?
    @old_url.strip.empty?
  end

end

