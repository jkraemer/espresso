
Espresso::Article.destroy_all
Espresso::Section.delete_all

root = Espresso::Section.root
root.articles.create! :title => 'Hello World!', :body => 'This is a test.', :publish => true

meta_section = root.children.create! :name => 'meta'
meta_section.articles.create! :title => 'Imprint',
                              :body => "imprint here...", :publish => true

