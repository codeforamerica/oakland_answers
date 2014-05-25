ActiveAdmin.register QuickAnswer do
  controller do
    load_and_authorize_resource :except => :index
      def scoped_collection
        end_of_association_chain.accessible_by(current_ability)
      end
   end

  menu :parent => "Articles"

  filter :title
  filter :tags
  filter :contact_id
  filter :status

  index do
    column "Quick Answer Title", :title do |article|
      link_to article.title, [:admin, article]
    end
    column :category
    column :contact
    column "Created", :created_at
    column "Author", :user do |article|
      if(article.user.try(:department))
        (article.user.try(:email) || "") + ", " + (article.user.try(:department).name || "")
      else
        (article.user.try(:email) || "")
      end
    end
    column :slug
    column "Status", :status
    default_actions
  end

  form :partial => "shared/admin/article_form"

  show do
    attributes_table do
      row :title
      row :content_main
      row :content_main_extra
      row :content_need_to_know
      row :preview
      row :status
      row :user
      row :created_at
      row :updated_at
      row :contact
    end
  end

  form do |f|
    f.inputs "Quick Answer Details" do
      f.input :title
      f.input :preview
      if current_user.is_writer?
        f.input :status, as: :select, collection: ["Draft", "Pending Review"]
      else
        f.input :status, as: :select, collection: ["Draft", "Pending Review", "Published"]
      end
      f.input :category
      f.input :contact
      f.input :keywords
      f.input :author_name, label: "Author"
    end
    f.inputs "Content" do
      f.input :content_main, label: "Overview/Summary"
      f.input :content_main_extra, label: "Full Content"
      f.input :content_need_to_know, label: "Related Resources"
    end
    f.buttons
  end
end
