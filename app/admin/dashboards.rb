def recent_articles_table
  table_for Article.order("created_at DESC").limit(5), title: "My Title" do
    column "Article Title", :title do |article|
      title = ""
      if article.title.present?
        title = article.title
      elsif article.title_es.present?
        title = article.title_es
      elsif article.title_cn.present?
        title = article.title_cn
      end
      link_to title, [:admin, article]
    end
    column "Author", :user do |article|
      article.user.try(:email)
    end
    column "Status", :status
    column "Date Created", :created_at
    column "Date Updated", :updated_at
  end
end

def your_articles_table
  table_for current_user.articles.order("created_at DESC") do
    column "Article Title", :title do |article|
      link_to article.title, [:admin, article]
    end
    column "Author", :user do |article|
      article.user.try(:email)
    end
    column "Status", :status
    column "Date Created", :created_at
  end
end

def users_table
  table_for User.order("created_at DESC").limit(5) do
    column "User", :email do |user|
      link_to user.email, [:admin, user]
    end
  end
  strong { link_to "View All Users", admin_users_path }
end


ActiveAdmin.register_page "Dashboard" do
  content do
    
    if current_user.is_admin? || current_user.is_editor?
      panel "Recent Articles" do recent_articles_table end
    end
    
    if current_user.is_writer?
      panel "Your Articles" do your_articles_table end
    end
    
    if current_user.is_admin?
      panel "Users" do users_table end
    end

  end
end
