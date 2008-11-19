class Page
  include DataMapper::Resource
  property :id, Serial
  property :name, String
  property :description, Text
  property :content, Text
  validates_is_unique :name
  validates_present   :name
  validates_present   :description
  validates_present   :content
  def self.sexhy
  {
    :properties => {
      :name => {
        :input => :text_field,
        :label => 'Nom',
        :order => 1
      },
      :description => {
        :input => :text_area,
        :label => 'Description',
        :order => 2
      },
      :content => {
        :input => :text_area,
        :label => 'Contenu',
        :order => 3
      },
    },
    :html => {
      :input => {
        :tag   => :p,
        :attributes => {
          :class => 'sexhy_p'
        },
      },
      :label => {
        :tag => :label,
        :attributes => {
          :class => 'sexhy_label',
        },
      },
    },
  }
  end
  def self.form_definition

  end
end
