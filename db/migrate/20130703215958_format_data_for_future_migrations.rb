class FormatDataForFutureMigrations < ActiveRecord::Migration
  def up
    rename_column :articles, :type, :old_type
    Article.all.each do |article|
      new_content_main = [article.content_main, article.content_main_extra, article.content_need_to_know].join("\n\n")
      if article.old_type == "Guide"
        guide_steps = ActiveRecord::Base.connection.select_all("SELECT * from guide_steps where article_id = #{article.id}")
        step_strings = []
        guide_steps.each do |guide_step|
          step_strings << "#{guide_step['step']} #{guide_step['title']}\n#{guide_step['content']}"
        end
        new_content_main = "#{new_content_main} #{step_strings.join("\n\n")}"
      end
      article.update_attribute(:content_main,  new_content_main)
      article.update_attribute(:status, "Published")
    end
  end

  def down
    rename_column :articles, :old_type, :type
  end
end
