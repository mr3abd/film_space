# Film Space

This quick docs how to run and what suggestion for next improvments

- How to run
*  init rails env & ruby 3.2.2
```ruby
rake db:create && rake db:migrate && rake import:data # to import from CSV files
```


* sugestion to fix and improve

- merge all tables in one table with multiple inhernet like (user) as parent -> reviwer actor -> childs in-case not use as strong class


 - add pagination fix pagy level with order by subquery
- improve code importer task
