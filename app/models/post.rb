class Post < ActiveRecord::Base
  has_paper_trail
  
  # settings for rails admin views
  rails_admin do
    show do
      field :title
      field :author
      field :content
    end
    create do
      #field :title
      #field :author
      field :content, :text do
        ckeditor true
      end
    end
    edit do
      #field :title
      #field :author
      field :content, :text do
        ckeditor true
      end
    end
    list do
      field :title
      field :author
      field :content
    end
  end
  
end
