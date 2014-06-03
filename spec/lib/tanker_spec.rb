require 'spec_helper'
require 'rake'

describe "Tanker" do  
  context "when TankerArticleDefaults is included in a model" do
    
    # these should match the fields listed in TankerDefaults
    let(:fields) do
      [
       :title, :title_es, :title_cn,
       :content_main, :content_main_es, :content_main_cn,
       :tags, :preview, :preview_es, :preview_cn, 
       :metaphones, :synonyms,:keywords,
       :stems, :title, :title_es,
       :title_cn, :content_main, :content_main_es,
       :content_main_cn, :tags, :preview,
       :preview_es, :preview_cn, :metaphones,
       :synonyms, :keywords, :stems
       ]
    end
    
    # any models which have `include TankerDefaults` should be part of this Array:
    let(:models) do
      [
        Article,
        Guide,
        QuickAnswer,
        WebService
      ]
    end
    
    it "indexes the proper fields for several models" do
      models.each do |model|
        indexes = model.tanker_config.indexes
        index_names = indexes.map {|i| i.first}
        
        # Ensures that each model where `TankerDefaults` is included
        # contains the proper index fields.
        fields.each do |field|
          expect(index_names).to(include(field))
        end
        
      end
    end
    
  end
end
