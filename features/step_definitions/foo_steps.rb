Given /^I've called foo$/ do
  @result = foo
end

Then /^the result should be true$/ do
  @result.should be_true
end
