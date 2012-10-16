Given /^the following articles exist:$/ do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |article|
    # each returned element will be a hash whose key is the table header.
    Article.create(article)
  end
end

Given /^the following comments exist:$/ do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |article|
    # each returned element will be a hash whose key is the table header.
    Article.create(article)
  end
end

Given /^I log out$/ do
  click_button 'Log out'
end

Then /^I should not see merge options$/ do
  assert page.has_no_content?("merge")
end

Given /^I merge "(.*?)" with "(.*?)"$/ do |arg1, arg2|
  article1 = Article.find_by_title(arg1)
  article2 = Article.find_by_title(arg2)
  visit '/admin/content/edit/#{article1.id}'
  fill_in 'merge_with', :with => '#{article2.id}'
  click_button 'merge'
  assert page.has_content('Merge successful')
end

Given /^I fill in the merge field with the ID of "(.*?)"$/ do |arg1|
  fill_in 'merge_with', :with => '#{article2.id}'
end

Then /^the text of "(.*?)" should contain "(.*?)"$/ do |arg1, text|
  article1 = Article.find_by_title(arg1)
  assert article1.body.has_content(text)
end

Then /^the author of "(.*?)" should be "(.*?)"$/ do |arg1, arg2|
  article1 = Article.find_by_title(arg1)
  assert_equal(arg2, article1.author)
end

Then /^the comments of "(.*?)" should contain "(.*?)"$/ do |arg1, arg2|
  article1 = Article.find_by_title(arg1)
  comment = Article.find_by_title(arg2)
  assert_equal(comment.article_id, article1.id)
end
