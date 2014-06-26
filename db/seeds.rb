Article.destroy_all
Category.destroy_all

Category.create([
  { :name => "Formats", description: "Anything about formats" },
  { :name => "Meows", description: "I like meows a lot" },
  { :name => "Camping"  },
  { :name => "Trailers" },
  { :name => "License Plates" },
  { :name => "City Jobs", description: "Get a Job!" }
])

first_category_id = Category.first.id
second_category_id = Category.second.id

Article.create([
  { :title => "How do I apply for a Business License?",
    :content_main => "Some of these words *are emphasized*. Some of these words _are emphasized also_.",                 :preview => "emphasis",          :tags => "emph",   :status => "Published", :category_id => first_category_id },
  { :title => "Where Can I Find Good Cat News?",
    :content_main => "I start my morning with a cup of coffee and [breaking cat news](http://www.breakingcatnews.com/)", :preview => "cat news",          :tags => "cats",   :status => "Published", :category_id => first_category_id },
  { :title => "What About the Quick Brown Fox? What Does He Do?",
    :content_main => "The quick brown fox jumped over the lazy dog's back.",                                :preview => "lazy dogs",         :tags => "dogs",   :status => "Published", :category_id => first_category_id },
  { :title => "Blockquotes, How do they work?",
    :content_main => "> This is a blockquote.",                                                                          :preview => "blockquote",        :tags => "blocks", :status => "Published", :category_id => first_category_id },
  { :title => "Can I Learn More About Paragraphs?",
    :content_main => "Paragraphs can be written like so. A paragraph is the basic block of Markdown.",                   :preview => "markdown",          :tags => "mark",   :status => "Published", :category_id => second_category_id },
  { :title => "How do I Make Inline Code?",
    :content_main => "You can also make `inline code` to add code into other things.",                                   :preview => "code",              :tags => "code",   :status => "Published", :category_id => second_category_id },
  { :title => "Why is Basic Formatting Useful?",
    :content_main => "Basic formatting of *italics* and **bold** is supported. This *can be **nested** like* so.",       :preview => "nested",            :tags => "nest",   :status => "Published", :category_id => second_category_id },
  { :title => "Oh My Gosh, Headers. Why are they so Great?",
    :content_main => "### Headings *can* also contain **formatting**",                                                   :preview => "header formatting", :tags => "format", :status => "Published", :category_id => second_category_id }
  ])
