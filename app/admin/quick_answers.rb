#encoding: utf-8

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

  show do |quick_answer|
    attributes_table do
      row :status
      row :category
      row :contact
      row  "Keywords" do
        quick_answer.keywords.map { |k| k.name }.join(", ")
      end
      row "Author" do
        quick_answer.author_name
      end
      row :created_at
      row :updated_at
      row :title
      row :preview
      row :content_main
      row :title_es
      row :preview_es
      row :content_main_es
      row :title_cn
      row :preview_cn
      row :content_main_cn
    end
  end

  form do |f|
    f.inputs "Quick Answer Details" do
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
      f.input :title, label: "Title (English)"
      f.input :preview, label: "Preview (English)"
      f.input :content_main, label: "Content (English)"
      f.input :title_es, label: "Title (Español)", wrapper_html: { class: 'top-break' }
      f.input :preview_es, label: "Preview (Español)"
      f.input :content_main_es, label: "Content (Español)"
      f.input :title_cn, label: "Title (中文)", wrapper_html: { class: 'top-break' }
      f.input :preview_cn, label: "Preview (中文)"
      f.input :content_main_cn, label: "Content (中文)"
    end
    f.actions
  end
end
