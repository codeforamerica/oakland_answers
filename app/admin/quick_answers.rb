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
end
