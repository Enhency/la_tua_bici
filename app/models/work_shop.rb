class WorkShop < ActiveRecord::Base
  scope :sorting, lambda{ |options|
    attribute = options[:attribute]
    direction = options[:sorting]

    attribute ||= "id"
    direction ||= "DESC"

    order("#{attribute} #{direction}")
  }

  include BeautifulScaffoldModule
  before_save :fulltext_field_processing

  # You can OVERRIDE this method used in model form and search form (in belongs_to relation)
  def caption
    (self["name"] || self["label"] || self["description"] || "##{id}")
  end

  def fulltext_field_processing
    # You can preparse with own things here
    generate_fulltext_field(["description"])
  end

  def self.permitted_attributes
    return :name,:photo,:description,:address,:phone,:email,:website,:latitude,:longitude,:mon_wt,:mon_lt,:tue_wt,:tue_lt,:wed_wt,:wed_lt,:thu_wt,:thu_lt,:fri_wt,:fri_lt,:sat_wt,:sat_lt,:sun_wt,:sun_lt
  end
end
