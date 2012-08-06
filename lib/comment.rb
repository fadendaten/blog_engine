require "data_mapper"

class Comment
  include DataMapper::Resource
  property :id, Serial, :index => true
  property :content, Text, :required => true
  property :author, String, :required => true
  property :article_slug, String, :required => true, :key => true, :index => true
  property :created_at, DateTime
  
  def self.for_article(article)
    all(:article_slug => article.slug, :order => :created_at.desc)
  end
  
  def initialize(attributes)
    attributes.each do |name, value|
      self.send("#{name}=", value)
    end
    self
  end
end