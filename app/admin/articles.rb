ActiveAdmin.register Article do

  controller.authorize_resource

  filter :title
  filter :tags
  filter :contact_id
  filter :status

  index do
    column "Article Title", :title do |article|
      link_to article.title, [:admin, article]
    end
    column :category
    column :content_type
    column :type
    column "Created", :created_at
    column "Author name", :author_name
    column "Status", :status
    default_actions
  end

  form do |f|
    f.inputs "Article Details" do
      if params[:action] == 'new'
        f.input :user_id, :as => :hidden, :input_html => { :value => current_user.id }
      end
      if current_user.is_writer?
        f.input :status,  :as => :select, :collection => ["Draft", "Pending Review"]
      else
        f.input :status,  :as => :select, :collection => ["Draft", "Pending Review", "Published"]
      end
      f.input :title
      f.input :content, :input_html => {:class => 'editor'}
      f.input :preview
      f.input :category
      f.input :type,  :as => :select, :collection => ["QuickAnswer", "WebService", "Guide"]
      f.input :contact
      f.input :service_url
      f.input :tags, :as => :string
      f.input :author_link
      f.input :author_pic
      f.input :author_name
    end
    f.actions
  end
end
