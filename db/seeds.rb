Article.destroy_all
Category.destroy_all

Category.create([
  { :name => "Formats" },
  { :name => "Meows" },
  { :name => "Camping"  },
  { :name => "Trailers" },
  { :name => "License Plates" },
  { :name => "City Jobs" }
])

first_category_id = Category.first.id
second_category_id = Category.second.id

Article.create([
  { :title => "Emphasize Words",                :content_main => "Some of these words *are emphasized*. Some of these words _are emphasized also_.",                 :preview => "emphasis",          :tags => "emph",   :status => "Published", :category_id => first_category_id },
  { :title => "Cat News",                       :content_main => "I start my morning with a cup of coffee and [breaking cat news](http://www.breakingcatnews.com/)", :preview => "cat news",          :tags => "cats",   :status => "Published", :category_id => first_category_id },
  { :title => "Quick Brown Fox",                :content_main => "The quick brown fox jumped over the lazy dog's back.",                                :preview => "lazy dogs",         :tags => "dogs",   :status => "Published", :category_id => first_category_id },
  { :title => "Blockquotes, How do they work?", :content_main => "> This is a blockquote.",                                                                          :preview => "blockquote",        :tags => "blocks", :status => "Published", :category_id => first_category_id },
  { :title => "Paragraphs",                     :content_main => "Paragraphs can be written like so. A paragraph is the basic block of Markdown.",                   :preview => "markdown",          :tags => "mark",   :status => "Published", :category_id => second_category_id },
  { :title => "Make Inline Code",               :content_main => "You can also make `inline code` to add code into other things.",                                   :preview => "code",              :tags => "code",   :status => "Published", :category_id => second_category_id },
  { :title => "Basic Formatting",               :content_main => "Basic formatting of *italics* and **bold** is supported. This *can be **nested** like* so.",       :preview => "nested",            :tags => "nest",   :status => "Published", :category_id => second_category_id },
  { :title => "Oh My Gosh, Headers",            :content_main => "### Headings *can* also contain **formatting**",                                                   :preview => "header formatting", :tags => "format", :status => "Published", :category_id => second_category_id }
  ])
