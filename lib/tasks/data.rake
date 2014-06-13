namespace :data do
  task :set_published => [:environment] do
    p 'Update Status All Articles to Published...'
    Article.all.each{|a| a.update_attributes(:status => 'Published')}
    p 'All Articles Set to Published'
  end
end
